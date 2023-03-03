function navigation_error_simulator()
clear;

% Ground truth points
% points on F_tool
At_inTrack = [0, 20, 0] + [-2,-2, 0];
Bt_inTrack = [0, 20, 0] + [4, -2, 0];
Ct_inTrack = [0, 20, 0] + [-2, 4, 0];
% points on F_m
Am_inTrack = [10, 10, 0] + [-2,-2, 0];
Bm_inTrack = [10, 10, 0] + [4, -2, 0];
Cm_inTrack = [10, 10, 0] + [-2, 4, 0];
% ground truth tip and axis in tool-frame
true_tipTool_inTool = [0, -20, 0];
true_tipTool_inTrakcer = [0, 0, 0];
true_axisTool_inTool = [0, 1, 0];
% depth
depth = 20;

%% Compute the true tool axis in m-frame, which will be used later.
% generate the relevant orthonormal tool-frame based on 3 ground truth markers
[Oe, e1, e2, e3] = generate_orthonormal_frame(At_inTrack, Bt_inTrack, Ct_inTrack);
% generate the relevant orthonormal m-frame based on 3 ground truth markers
[Ov, v1, v2, v3] = generate_orthonormal_frame(Am_inTrack, Bm_inTrack, Cm_inTrack);

% Find the homogeneous transformation matrix 
% from tool-frame to tracker-frame(v->home)
[true_trm_fromToolToTracker] =  frame_transform_from_v_to_home(Oe, e1, e2, e3);
% Find the homogeneous transformation matrix 
% from tracker-frame to m-frame(home->v)
[true_trm_fromTrackerToM] =  frame_transform_from_home_to_v(Ov, v1, v2, v3);

% Find the homogeneous transformation matrix 
% from tool-frame to m-frame
true_trm_fromToolToM = true_trm_fromTrackerToM * true_trm_fromToolToTracker;

% true tool tip in m-frame:
true_tipTool_inM = true_trm_fromToolToM * [true_tipTool_inTool 1]';
true_tipTool_inM = [true_tipTool_inM(1) true_tipTool_inM(2) true_tipTool_inM(3)];
% true tool axis in m-frame:
true_axisTool_inM = true_trm_fromToolToM * [true_axisTool_inTool 1]';
true_axisTool_inM = [true_axisTool_inM(1) true_axisTool_inM(2) true_axisTool_inM(3)];

%% Discription of my approach
% I will choose a E0 = 2*sigma sphere since the case -
% "only 5% of the points fall outside E0 sphere" is the most reasonable
% case in a surgery. 1*sigma means too many points falling outside,
% and 3*sigma means too little points falling outside.
% Since we assume that for each marker the magnitude of the tracking
% error is random Gaussianly distributed with RMSE = 0.25cm,
% then "radius of E0 sphere" = 2*sigma = 2*RMSE = 0.5cm.

% To make it a "Glow" sphere, with each 0.05cm interval, 
% I will set different probabilities to achieve that   
% The rule I set is shown as below:
% 0.00-0.05: 20%    0.05-0.10: 17%  
% 0.10-0.15: 14%    0.15-0.20: 11%
% 0.20-0.25: 8%     0.25-0.30: 6%
% 0.30-0.35: 5.5%   0.35-0.40: 5%
% 0.40-0.45: 4.5%   0.45-0.50: 4%
% 0.50-1.00: 5%(fall outside E0 sphere)
% Note:
% 1. probability shown above is added up to 100%.
% 2. For exmaple, for interval 0.00-0.05,
%    there is a 20% chance that a marker will
%    fall 0.00-0.05cm from the original position
% 3. For 0.00-0.25, since it is equal to 1*sigma, the rule I set makes
%    probability in this interval added up to 70%(close to 68%).
%    For 0.25-0.50, probability in this interval is added up to 30%.

% To represent the probability, I choose to use "rand".
% For instance, I will set: if "rand" is equal to a number between 0-0.2,
% then a marker will fall in the corresponding interval. Since "rand" is a
% number between 0 and 1, and there is approximately 20% chance for "rand" 
% being a number between 0 and 0.2.

%% Marker simulation and Sphere of tool tip error

N = 200;
max_dist_toolTip = 0;
for i = 1:N

    % spoil each marker in tool-frame
    At_inTrack_err = marker_simulator(At_inTrack);
    Bt_inTrack_err = marker_simulator(Bt_inTrack);
    Ct_inTrack_err = marker_simulator(Ct_inTrack);
    % spoil each marker in m-frame(patient marker)
    Am_inTrack_err = marker_simulator(Am_inTrack);
    Bm_inTrack_err = marker_simulator(Bm_inTrack);
    Cm_inTrack_err = marker_simulator(Cm_inTrack);

    % generate the relevant orthonormal tool-frame based on 3 spoiled markers
    [Oe, e1, e2, e3] = generate_orthonormal_frame(At_inTrack_err, Bt_inTrack_err, Ct_inTrack_err);

    % generate the relevant orthonormal m-frame based on 3 spoiled markers
    [Ov, v1, v2, v3] = generate_orthonormal_frame(Am_inTrack_err, Bm_inTrack_err, Cm_inTrack_err);

    % Find the homogeneous transformation matrix 
    % from tool-frame to tracker-frame(v->home)
    [trm_fromToolToTracker] =  frame_transform_from_v_to_home(Oe, e1, e2, e3);
    % Find the right homogeneous transformation matrix 
    % from tracker-frame to m-frame(home->v)
    [trm_fromTrackerToM] =  frame_transform_from_home_to_v(Ov, v1, v2, v3);
    % Find the right homogeneous transformation matrix 
    % from tool-frame to m-frame
    trm_fromToolToM = trm_fromTrackerToM * trm_fromToolToTracker;
    % transform the tool tip from tracker-frame to m-frame
    tool_tip_inM = trm_fromToolToM * [true_tipTool_inTool 1]';
    tool_tip_inM = [tool_tip_inM(1) tool_tip_inM(2) tool_tip_inM(3)];

    % compute the supersphere by updating and recoring the maximum 
    % distance between transformed tumor center and the true one
    dist = norm(tool_tip_inM - true_tipTool_inM);
    if (dist >= max_dist_toolTip)
        max_dist_toolTip = dist;
    end % end if-statement

end % end for-loop

% display the relevant information of the sphere of tool tip error
disp("For the sphere of tool tip error, ");
fprintf("the center of the sphere of tool tip error in tool-frame is: [%d %d %d], which is [0 0 0] in tracker-frame.", ...
    true_tipTool_inTool(1), true_tipTool_inTool(2), true_tipTool_inTool(3));
disp(" ");
% compute the radius of the sphere
R_sphere_toolTipErr = max_dist_toolTip;
fprintf("The radius of the sphere of tool tip error is: %.4f\n", R_sphere_toolTipErr);
disp(" ");

%% Cone of tool axis

max_angle = 0;
for i = 1:N

    % spoil each marker
    At_inTrack_err = marker_simulator(At_inTrack);
    Bt_inTrack_err = marker_simulator(Bt_inTrack);
    Ct_inTrack_err = marker_simulator(Ct_inTrack);
    % spoil each marker in m-frame(patient marker)
    Am_inTrack_err = marker_simulator(Am_inTrack);
    Bm_inTrack_err = marker_simulator(Bm_inTrack);
    Cm_inTrack_err = marker_simulator(Cm_inTrack);

    % generate the relevant orthonormal frame based on 3 spoiled markers
    [Oe, e1, e2, e3] = generate_orthonormal_frame(At_inTrack_err, Bt_inTrack_err, Ct_inTrack_err);

    % generate the relevant orthonormal m-frame based on 3 spoiled markers
    [Ov, v1, v2, v3] = generate_orthonormal_frame(Am_inTrack_err, Bm_inTrack_err, Cm_inTrack_err);

    % Find the homogeneous transformation matrix 
    % from tool-frame to tracker-frame(v->home)
    [trm_fromToolToTracker] =  frame_transform_from_v_to_home(Oe, e1, e2, e3);
    % Find the right homogeneous transformation matrix 
    % from tracker-frame to m-frame(home->v)
    [trm_fromTrackerToM] =  frame_transform_from_home_to_v(Ov, v1, v2, v3);
    % Find the right homogeneous transformation matrix 
    % from tool-frame to m-frame
    trm_fromToolToM = trm_fromTrackerToM * trm_fromToolToTracker;
    % transform the true tool axis from tool-frame to tracker-frame
    tool_axis_inM = trm_fromToolToM * [true_axisTool_inTool 1]';
    tool_axis_inM = [tool_axis_inM(1, :) tool_axis_inM(2, :) tool_axis_inM(3, :)];

    % compute the angle between the current transformed axis 
    % between the original one
    angle = angle_between_twoVectors(tool_axis_inM, true_axisTool_inM);
    if (angle > max_angle)
        % update the maximum angle
        max_angle = angle;
    end % end if-statement

end % end for-loop

% compute the angle of the uncertainty cone
cone_apex_half_angle = max_angle;
cone_apex_angle = 2 * cone_apex_half_angle;

% compute the apex of the cone
% To improve the availability of the data, I will repeat the calculation 
% of the distance between the apex of cone and the center of the sphere,
% and then average them out.
dis_vec = [];

for k = 1:N
    dis_vec(k) = R_sphere_toolTipErr / sind(cone_apex_half_angle);
end % end for-loop

% average them out
dist_between_apexCone_toolTipSphere = mean(dis_vec);
% initilaize coordinate of the apex of uncertainty cone
apex_cone_inTracker = [0 0 0];
apex_cone_inTracker(2) = true_tipTool_inTrakcer(2) + dist_between_apexCone_toolTipSphere;

disp("For the uncertainty cone of tool axis, ");
fprintf("the apex of the uncertainty cone in tracker-frame is: [%d %.4f %d]\n", apex_cone_inTracker(1), apex_cone_inTracker(2), apex_cone_inTracker(3));
fprintf("And the angle of the uncertainty cone apex is: %.4f\n", cone_apex_angle);

%% Sphere of tumor/nerve registration error(since radius of them both are equal)
disp(" ");
% Below is the coordinate of the center of the tumor sphere.
true_tumorCener_inTool = [0 -40 0];
% transform the tumor center from tool-frame to m-frame
true_tumorCener_inM = true_trm_fromToolToM * [true_tumorCener_inTool 1]';
true_tumorCener_inM = [true_tumorCener_inM(1) true_tumorCener_inM(2) true_tumorCener_inM(3)];

% below is the initialized distance between the tumor center after
% transforming to m-frame and the true tumor center in m-frame
max_dist_tumor = 0;
for i = 1:N

    % spoil each marker
    At_inTrack_err = marker_simulator(At_inTrack);
    Bt_inTrack_err = marker_simulator(Bt_inTrack);
    Ct_inTrack_err = marker_simulator(Ct_inTrack);
    % spoil each marker in m-frame(patient marker)
    Am_inTrack_err = marker_simulator(Am_inTrack);
    Bm_inTrack_err = marker_simulator(Bm_inTrack);
    Cm_inTrack_err = marker_simulator(Cm_inTrack);

    % generate the relevant orthonormal frame based on 3 spoiled markers
    [Oe, e1, e2, e3] = generate_orthonormal_frame(At_inTrack_err, Bt_inTrack_err, Ct_inTrack_err);

    % generate the relevant orthonormal m-frame based on 3 spoiled markers
    [Ov, v1, v2, v3] = generate_orthonormal_frame(Am_inTrack_err, Bm_inTrack_err, Cm_inTrack_err);

    % Find the homogeneous transformation matrix 
    % from tool-frame to tracker-frame(v->home)
    [trm_fromToolToTracker] =  frame_transform_from_v_to_home(Oe, e1, e2, e3);
    % Find the right homogeneous transformation matrix 
    % from tracker-frame to m-frame(home->v)
    [trm_fromTrackerToM] =  frame_transform_from_home_to_v(Ov, v1, v2, v3);
    % Find the right homogeneous transformation matrix 
    % from tool-frame to m-frame
    trm_fromToolToM = trm_fromTrackerToM * trm_fromToolToTracker;
    % transform the true tool axis from tool-frame to m-frame
    tumorCenter_inM = trm_fromToolToM * [true_tumorCener_inTool 1]';
    tumorCenter_inM = [tumorCenter_inM(1) tumorCenter_inM(2) tumorCenter_inM(3)];

    % compute the supersphere by updating and recoring the maximum 
    % distance between transformed tumor center and the true one
    dist = norm(tumorCenter_inM - true_tumorCener_inM);
    if (dist >= max_dist_tumor)
        max_dist_tumor = dist;
    end % end if-statement

end % end for-loop

% display the relevant information of the sphere of tool tip error
disp("For the sphere of tumor registration error, ");
fprintf("the center of the sphere of tool tip error in tool-frame is: [%d %d %d], which is [0 -20 0] in tracker-frame.", ...
    true_tumorCener_inTool(1), true_tumorCener_inTool(2), true_tumorCener_inTool(3));
disp(" ");
% compute the radius of the sphere
R_sphere_tumorCenterErr = max_dist_tumor;
fprintf("The radius of the sphere of tumor registration error is: %.4f\n", R_sphere_tumorCenterErr);
R_sphere_nerve = R_sphere_tumorCenterErr;
disp(" ");
disp("For the sphere of nerve registration error,");
fprintf("the radius of the sphere of registration error is: %.4f\n", R_sphere_nerve);
disp(" ");

%% Compute the radius of the smallest spherical tumor that we can hit with "near certainty"
% Calculate the distance from the tumor center to the surface of 
% the uncertainty cone
D = (dist_between_apexCone_toolTipSphere + depth) * sind(cone_apex_half_angle);
if (D > R_sphere_tumorCenterErr)
    disp("");
    fprintf("The distance from the tumor center to the surface of the uncertainty cone is: %.4f\n", D);
    fprintf("And the radius of the sphere of registration error is: %.4f\n", R_sphere_tumorCenterErr);
    R_smallestSphereTumor = D - R_sphere_tumorCenterErr;
    fprintf('The radius of the smallest spherical tumor that we can hit with "near certainty" is: %.4f\n', ...
        R_smallestSphereTumor);
else
    disp("");
    fprintf("The distance from the tumor center to the surface of the uncertainty cone is: %.4f\n", D);
    fprintf("And the radius of the sphere of registration error is: %.4f\n", R_sphere_tumorCenterErr);
    disp("Then the sphere of tumor registration error is beyond the uncertainty cone. " + ...
        'Thus no matter what its radius is, we can hit the tumor with "near certainty".')
end % end if-statement

%% Compute the closest distance from the needle trajectory for a nerve that  we can spare with "near certainty".
% here I will take case(2) in my paper work as the solution.
% As mentioned in paper work, the radius of the sphere of nerve
% registration error can be equal to the radius of the sphere of tumor
% registration error.
closest_dist = R_sphere_nerve / cosd(cone_apex_half_angle) + D / cosd(cone_apex_half_angle);
disp(" ");
disp('The closest distance from the needle trajectory for a nerve that  we can spare with "near certainty" is: ');
disp(closest_dist);

end % end the function