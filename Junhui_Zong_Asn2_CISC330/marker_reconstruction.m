% This function is to  reconstruct a point in CK frame 
% from two detector image points.

function [p_reconstructed_inCk, REM] = marker_reconstruction(p_inA, p_inB)
% Input:
%       p_inCk: point in CK frame
% Output:
%       p_inA: projected point in detector A frame
%       p_inB: projected point in detector B frame

% coordinates of two x-ray sources in CK frame
S_A_inCk = [-50*sqrt(2) 50*sqrt(2) 0];
S_B_inCk = [50*sqrt(2) 50*sqrt(2) 0];

%% Compute transformations
% get homogeneous transformation matrices 
% from A, B detector image frames to CK frame
[transFromAToCk] = frame_transform_from_A_to_CK();
[transFromBToCk] = frame_transform_from_B_to_CK();

% transform the point in A frame to be one in CK frame
pA_inCk = transFromAToCk * [p_inA 1]';
pA_inCk = [pA_inCk(1) pA_inCk(2) pA_inCk(3)];

% transform the point in B frame to be one in CK frame
pB_inCk = transFromBToCk * [p_inB 1]';
pB_inCk = [pB_inCk(1) pB_inCk(2) pB_inCk(3)];

%% Construct back projection lines
% Construct back projection line from Detector A to source A:
% Compute the direction vector of the projection line 
% from Detector A to source A
v_A = (S_A_inCk - pA_inCk) / (norm((S_A_inCk - pA_inCk)));

% Construct back projection line from Detector B to source B:
% Compute the direction vector of the projection line 
% from Detector B to source B
v_B = (S_B_inCk - pB_inCk) / (norm((S_B_inCk - pB_inCk)));

%% compute reconstruction point in CK and REM
[p_reconstructed_inCk, REM] = intersect_two_lines(pA_inCk, v_A, pB_inCk, v_B);

end % end the function