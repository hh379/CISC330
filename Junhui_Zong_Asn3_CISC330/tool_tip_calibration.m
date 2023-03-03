% This program is developed to accomplish calibration for the tool tip.
% And it is implemented using the method - concentric sphere fitting.

function [tip_inTool] = tool_tip_calibration(markers_inTrack)
% Input:
%       markers_inTrack: array of marker positions supplied by the tracker
% Output:
%       tip_inTool: the tool tip in tool-frame

% Split input markers into 3 seperate set of points, 
% which will be used in sphere fitting.
A_points_inTrack = [markers_inTrack(:, 1), markers_inTrack(:, 2), markers_inTrack(:, 3)];
B_points_inTrack = [markers_inTrack(:, 4), markers_inTrack(:, 5), markers_inTrack(:, 6)];
C_points_inTrack = [markers_inTrack(:, 7), markers_inTrack(:, 8), markers_inTrack(:, 9)];

% Since each point is moving on a sphere, 
% then we can fit a sphere on each marker cloud.
[Ctr_A, ~] = sphere_reconstruct(A_points_inTrack);
[Ctr_B, ~] = sphere_reconstruct(B_points_inTrack);
[Ctr_C, ~] = sphere_reconstruct(C_points_inTrack);

% Take the average of compluted centers to 
% the best estimate for pivot point in tracker frame (Ph).
Ph = mean([Ctr_A; Ctr_B; Ctr_C]);

% Create a matrix to store all of the poses transformed to tool-frame
Pm = [];

[N, ~] = size(markers_inTrack);
for i = 1:N
    % pick the ith point in each set of marker points
    p_A = A_points_inTrack(i, :);
    p_B = B_points_inTrack(i, :);
    p_C = C_points_inTrack(i, :);

    % generate the relevant orthonormal frame based on those 3 points
    [Oe, e1, e2, e3] = generate_orthonormal_frame(p_A, p_B, p_C);

    % Find the homogeneous transformation matrix 
    % from tracker-frame to tool-frame(home->v)
    [trm_fromTrackerToTool] =  frame_transform_from_home_to_v(Oe, e1, e2, e3);

    % calculate the pose transformed to tool-frame
    Pmi = trm_fromTrackerToTool * [Ph 1]';
    Pmi = [Pmi(1, :) Pmi(2, :) Pmi(3, :)];

    % update Pm
    Pm(i, :) = Pmi;

end % end for-loop

% calculate the tool tip in tool-frame
tip_inTool = mean(Pm);

end % end the function