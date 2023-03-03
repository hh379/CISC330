% This function is to generate frame transformations 
% from the CK frame to the A and B detector image frames.

function [transFromCkToA, transFromCkToB] = frame_transform_from_CK_to_AB()
% Input:
%       None
% Output:
%       transFromCkToA: homogeneous transformation matrix from CK to A
%       transFromCkToB: homogeneous transformation matrix from CK to B

%% ----------Computation of center and bases of each frame is done in paper work--------- %%

%% From CK to A
% center of detector A computed in my paper work
C_A_inCk = [50*sqrt(2) -50*sqrt(2) 0];

% generate the homogeneous rotation matrix 
% from CK frame to detector A frame
C_A_x = [0 0 1];
C_A_y = [sqrt(2)/2 sqrt(2)/2 0];
C_A_z = [-sqrt(2)/2 sqrt(2)/2 0];
rotmFromCkToA = [[C_A_x 0; C_A_y 0; C_A_z 0]
                0 0 0 1];

% translation transformation from CK to A
trmFromCkToA = [[eye(3) [-C_A_inCk(1); -C_A_inCk(2); -C_A_inCk(3);]] 
                0 0 0 1];

% compute homogeneous transformation matrix from CK to A
transFromCkToA = rotmFromCkToA * trmFromCkToA;

%% From CK to B
% center of detector B computed in my paper work
C_B_inCk = [-50*sqrt(2) -50*sqrt(2) 0];

% generate the homogeneous rotation matrix 
% from CK frame to detector B frame
C_B_x = [0 0 1];
C_B_y = [sqrt(2)/2 -sqrt(2)/2 0];
C_B_z = [sqrt(2)/2 sqrt(2)/2 0];
rotmFromCkToB = [[C_B_x 0; C_B_y 0; C_B_z 0]
                0 0 0 1];

% translation transformation from CK to B
trmFromCkToB = [[eye(3) [-C_B_inCk(1); -C_B_inCk(2); -C_B_inCk(3);]] 
                0 0 0 1];

% compute homogeneous transformation matrix from CK to B
transFromCkToB = rotmFromCkToB * trmFromCkToB;

end % end the function