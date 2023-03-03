% This function is to generate frame transformations 
% from A detector image frames to the CK frames

function [transFromAToCk] = frame_transform_from_A_to_CK()
% Input:
%       None
% Output:
%       transFromAToCk: homogeneous transformation matrix from A to CK

% center of detector A computed in my paper work
C_A_inCk = [50*sqrt(2) -50*sqrt(2) 0];

% generate the homogeneous rotation matrix 
% from detector A frame to CK frame
C_A_x = [0 0 1];
C_A_y = [sqrt(2)/2 sqrt(2)/2 0];
C_A_z = [-sqrt(2)/2 sqrt(2)/2 0];
rotmFromAToCk = [[C_A_x';0] [C_A_y';0] [C_A_z';0] [0;0;0;1]];

% translation transformation from A to CK
trmFromAToCk = [[eye(3) [C_A_inCk(1); C_A_inCk(2); C_A_inCk(3);]] 
                0 0 0 1];

% compute homogeneous transformation matrix from A to CK
transFromAToCk = trmFromAToCk * rotmFromAToCk;

end % end the function