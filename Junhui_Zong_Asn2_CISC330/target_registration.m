% This function is to  register a target point from CT frame to CK frame.

function [target_inCK] = target_registration(target_inCT, points_inCT,  points_inCK)
% Input:
%       target_inCT: target point in CT frame
%       points_inCT: 3 marker points in CT frame
%       points_inCK: 3 marker points in CK frame
% Output:
%       target_inCK: target point registered from CT to CK

M1_CT = points_inCT(1, :);
M2_CT = points_inCT(2, :);
M3_CT = points_inCT(3, :);

M1_CK = points_inCK(1, :);
M2_CK = points_inCK(2, :);
M3_CK = points_inCK(3, :);

% Given 3 points in a frame, 
% compute the orthonormal frame with 1 center and 3 base vectors
[C_inCT, base_v_inCT] = generate_orthonormal_frame(M1_CT, M2_CT, M3_CT);
[C_inCK, base_v_inCK] = generate_orthonormal_frame(M1_CK, M2_CK, M3_CK);

% Find the homogeneous transformation matrix
% help was from:
% [https://github.com/nghiaho12/rigid_transform_3D/blob/master/rigid_transform_3D.m]
% To fit this problem, this function has been modified.
[rotm] = rigid_transform_3D(base_v_inCT, base_v_inCK);
% find the homogeneous rotation matrix
rotmFromCTToCK = [[rotm [0;0;0]]
                    [0 0 0 1]];
% rotated the center of the orthonormal frame of 3 points in CT frame 
% to CK frame
O_CT_inCK = rotm * C_inCT';
% calculate the translation vector
trvec = O_CT_inCK - C_inCK';
% translation transformation from CT to CK
trmFromCTToCK = [[eye(3) -trvec] 
                0 0 0 1];
% calculate the homogeneous transformation matrix
transmFromCTToCK = trmFromCTToCK * rotmFromCTToCK;

% transform the target point from CT frame to CK frame
target = transmFromCTToCK * [target_inCT 1]';
target_inCK = [target(1) target(2) target(3)];

end % end the function