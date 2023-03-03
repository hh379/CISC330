% This main.m is used to call other functions to test their validities.

%% call testinng functions to do tests, uncommennt them to do relevant tests

% Test_tool_tip_calibration();

% Test_tool_axis_calibration();

Test_navigation_error_simulator();

%% Test for tool tip calabration
function Test_tool_tip_calibration()
clc;
% ground truth points in tracker-frame
At_inTrack = [0, 20, 0] + [-2,-2, 0];
Bt_inTrack = [0, 20, 0] + [4, -2, 0];
Ct_inTrack = [0, 20, 0] + [-2, 4, 0];
% ground truth tip in tool-frame
ground_truth_tipTool = [0, -20, 0];

% initialize a vector to store the coordinates of markers in random poses
randMarkers = [];

% generate 50 sets of poses within a 60 degree cone
N = 50;
for i = 1:N    
    % randomly choose the angle of rotation
    rot_degree_1 = 30 * rand;
    
    % first rotate the points around x axis by 0-30 degrees
    [rotm1, ~] = rotation_about_frame_axis('x', rot_degree_1);
    At_inTrack = (rotm1 * At_inTrack')';
    Bt_inTrack = (rotm1 * Bt_inTrack')';
    Ct_inTrack = (rotm1 * Ct_inTrack')';

    % then rotate the points around z axis by 0-30 degrees
    [rotm2, ~] = rotation_about_frame_axis('z', rot_degree_1);
    At_inTrack = (rotm2 * At_inTrack')';
    Bt_inTrack = (rotm2 * Bt_inTrack')';
    Ct_inTrack = (rotm2 * Ct_inTrack')';
    
    % lastly rotate the points around y axis by 0-360 degrees
    rot_degree_2 = 360 * rand;
    [rotm3, ~] = rotation_about_frame_axis('y', rot_degree_2);
    At_inTrack = (rotm3 * At_inTrack')';
    Bt_inTrack = (rotm3 * Bt_inTrack')';
    Ct_inTrack = (rotm3 * Ct_inTrack')';
    
    % add rotated points in randMarkers
    randMarkers(i, :) = [At_inTrack, Bt_inTrack, Ct_inTrack];
end

% feed the resulting simulated tool marker coordinates to
% the to the Tool Tip Calibrator
tip_inTool = tool_tip_calibration(randMarkers);

fprintf("Expected output: [%d %d %d]\n", ...
    ground_truth_tipTool(1), ground_truth_tipTool(2), ground_truth_tipTool(3));
disp(" ");
fprintf("The coordinate of tool tip in tool-frame calculated using Concentric Sphere Fitting: [%.2f %.2f %.2f]", ...
    tip_inTool(1), tip_inTool(2), tip_inTool(3));
disp(" ");

clear;

end

%% Test for tool axis calabration
function Test_tool_axis_calibration()
clc;
% ground truth points in tracker-frame
At_inTrack = [0, 20, 0] + [-2,-2, 0];
Bt_inTrack = [0, 20, 0] + [4, -2, 0];
Ct_inTrack = [0, 20, 0] + [-2, 4, 0];
% ground truth axis in tool-frame
ground_truth_axisTool = [0, 1, 0];

% initialize a vector to store the coordinates of markers in random poses
randMarkers = [];

% when N = 120, it means that we do a rotation every 3 degrees increase
N = 120;
degree_incr = 360/N;

% find rotation matrix around y based on degree increment.
[rotm, ~] = rotation_about_frame_axis('y', degree_incr);
for i = 1:N
    % rotate the points around y axis by 360/N degrees
    At_inTrack = (rotm * At_inTrack')';
    Bt_inTrack = (rotm * Bt_inTrack')';
    Ct_inTrack = (rotm * Ct_inTrack')';

    % add rotated points in randMarkers
    randMarkers(i, :) = [At_inTrack, Bt_inTrack, Ct_inTrack];
end

% feed the resulting simulated tool marker coordinates to
% the Tool Axis Calibrator
axis_inTool = tool_axis_calibration(randMarkers);

fprintf("Expected output: [%d %d %d]\n", ...
    ground_truth_axisTool(1), ground_truth_axisTool(2), ground_truth_axisTool(3));
disp(" ");
fprintf("The calculated coordinate of tool axis in tool-frame: [%d %d %d]\n", ...
    axis_inTool(1), axis_inTool(2), axis_inTool(3));
disp(" ");

clear;
end

%% Test for navigation_error_simulator.m
function Test_navigation_error_simulator()
clc;
navigation_error_simulator();
clear;
end