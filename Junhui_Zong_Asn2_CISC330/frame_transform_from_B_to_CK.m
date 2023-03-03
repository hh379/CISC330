% This function is to generate frame transformations 
% from B detector image frames to the CK frames

function [transFromBToCk] = frame_transform_from_B_to_CK()
% Input:
%       None
% Output:
%       transFromBToCk: homogeneous transformation matrix from B to CK

% center of detector B computed in my paper work
C_B_inCk = [-50*sqrt(2) -50*sqrt(2) 0];

% generate the homogeneous rotation matrix 
% from detector B frame to CK frame
C_B_x = [0 0 1];
C_B_y = [sqrt(2)/2 -sqrt(2)/2 0];
C_B_z = [sqrt(2)/2 sqrt(2)/2 0];
rotmFromBToCk = [[C_B_x';0] [C_B_y';0] [C_B_z';0] [0;0;0;1]];

% translation transformation from B to CK
trmFromBToCk = [[eye(3) [C_B_inCk(1); C_B_inCk(2); C_B_inCk(3);]] 
                0 0 0 1];

% compute homogeneous transformation matrix from B to CK
transFromBToCk = trmFromBToCk * rotmFromBToCk;

end % end the function