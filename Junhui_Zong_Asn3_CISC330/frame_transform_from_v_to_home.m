% This function computes the transformation that 
% takes the perspective from v-frame to home frame.

%% It has been modified to fit this homework.
function [hm] =  frame_transform_from_v_to_home(Ov, v1, v2, v3)
% Input:
%       Ov:  the centre in orthonormal v frame
%       v1, v2, v3:  3 base vectors in orthonormal v frame
% Output:
%       hm: 4x4 homogeneous transformation matrix

% Translation 
% comopute homogeneous translation matrix using Ov
T = [
        [1   0   0   Ov(1)]
        [0   1   0   Ov(2)]
        [0   0   1   Ov(3)]
        [0   0   0     1  ]
        ];

% Rotation 
% comopute homogeneous rotation matrix
R = [
     [v1(1) v2(1) v3(1) 0]
     [v1(2) v2(2) v3(2) 0]
     [v1(3) v2(3) v3(3) 0]
     [  0     0     0   1]
     ];

% comopute homogeneous matrix
hm = T * R;

end % end the function