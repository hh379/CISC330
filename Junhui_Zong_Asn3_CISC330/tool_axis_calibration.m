% This program is developed to accomplish calibration for the tool axis.

function [axis_inTool] = tool_axis_calibration(markers_inTrack)
% Input:
%       markers_inTrack: array of marker positions supplied by the tracker
% Output:
%       tip_inTool: the tool axis in tool-frame

% Split input markers into 3 seperate set of points, 
% which will be used in sphere fitting.
A_points_inTrack = [markers_inTrack(:, 1), markers_inTrack(:, 2), markers_inTrack(:, 3)];
B_points_inTrack = [markers_inTrack(:, 4), markers_inTrack(:, 5), markers_inTrack(:, 6)];
C_points_inTrack = [markers_inTrack(:, 7), markers_inTrack(:, 8), markers_inTrack(:, 9)];

% Since we know: each marker travels on a planar circle,
% then we can compute the normal vector of each plane using affine_fit(),
% which is cited as:
% [Adrien Leygue (2022)
% Plane fit (https://www.mathworks.com/matlabcentral/fileexchange/43305-plane-fit)
% MATLAB Central File Exchange
% Retrieved November 10, 2022]
[n_A, ~, ~] = affine_fit(A_points_inTrack);
[n_B, ~, ~] = affine_fit(B_points_inTrack);
[n_C, ~, ~] = affine_fit(C_points_inTrack);

% Points in my programs are all row vecotrs but the output of the cited
% function is column vector, so I will transpose the output.
n_A = n_A';
n_B = n_B';
n_C = n_C';

% And we will check to see if those 3 computed normal vectors are in the
% same direction. If not, we'll adjust them to point to the same direction.
% Here, we take the direction of n_A as the base direction,
% the other two will keep the same direction as n_A.
if (dot(n_A, n_B) < 0)
    % flip the direction of n_B
    n_B = -n_B;
elif (dot(n_A, n_C) < 0)
    % flip the direction of n_C
    n_C = -n_C;
end % end if-statement

% Compute the average to get vh in tracker frame
Vh = mean([n_A ; n_B ; n_C]);

% Create a matrix to store all of the poses transformed to tool-frame
Vm = [];

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
    trm_fromTrackerToTool(4, :) = [];
    trm_fromTrackerToTool(:, 4) = [];
    Vmi = trm_fromTrackerToTool * Vh';

    % update Vm
    Vm(i, :) = Vmi;

end % end for-loop

% calculate the tool axis in tool-frame
axis_inTool = mean(Vm);

end % end the function