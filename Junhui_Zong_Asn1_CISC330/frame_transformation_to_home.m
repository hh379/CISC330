% q11  This function computes the transformation that 
% takes the perspective from v frame to home.

function [hm] =  frame_transformation_to_home(Ov, base_v)
% Input:
%       Ov:  the centre in v frame
%       base_v:  3 base vectors in v frame
% Output:
%       hm: 4x4 homogeneous matrix
h1 = [1 0 0];
h2 = [0 1 0];
h3 = [0 0 1];

% to find the relevant orthonormal frames
[Ov, orth_v] = generate_orthonormal_frame(base_v(1, :), base_v(2, :), base_v(3, :));
[Oh, orth_h] = generate_orthonormal_frame(h1, h2, h3);

orth_v1 = orth_v(1, :)';
orth_v2 = orth_v(2, :)';
orth_v3 = orth_v(3, :)';

orth_h1 = orth_h(1, :)';
orth_h2 = orth_h(2, :)';
orth_h3 = orth_h(3, :)';

% generate the rotation matrix using procrustes
[~, ~, trans] = procrustes([orth_h1 orth_h2 orth_h3], [orth_v1 orth_v2 orth_v3]);
% [~, ~, trans] = procrustes([orth_v1 orth_v2 orth_v3], [orth_h1 orth_h2 orth_h3]);
% to access the rotation matrix from trans
rotm = trans.T;
% by multiplying the rotation matrix, transfer the center of v-frame to home
rot_Ov = rotm * Ov';
% to find the translation vector by calculating the difference 
% between two center points
trvec = Oh' - rot_Ov;
% find the 4x4 rotation matrix
R = rotm2tform(rotm);
% find the 4x4 translation matrix
T = trvec2tform(trvec');

% find the 4x4 homogeneous transformation matrix
hm = T * R;

end % end the function
