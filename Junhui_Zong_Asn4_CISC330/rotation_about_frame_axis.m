% q10 - This function generates a transformation matrix to rotate a point 
% about one of the (x,y,z) frame axes by a given rotation angle.

function [rm, h_rm] = rotation_about_frame_axis(axis, angle)
% Input:
%       axis:  the (x,y,z) frame axes
%       angle: the given rotation angle
% Output:
%       rm: rotation matrix (3x3)
%       h_rm: homogeneous rotation matrix (4x4)

if axis == 'x'
    rm = [
        [1       0             0     ]
        [0  cosd(angle)  -sind(angle)]
        [0  sind(angle)   cosd(angle)]
        ];
    h_rm = [
        [1        0            0            0]
        [0  cosd(angle)  -sind(angle)       0]
        [0  sind(angle)   cosd(angle)       0]
        [0        0            0            1]
            ];
elseif axis == 'y'
    rm = [
        [cosd(angle)   0     sind(angle)]
        [0             1          0     ]
        [-sind(angle)  0     cosd(angle)]
        ];
    h_rm = [
        [cosd(angle)   0     sind(angle)    0]
        [0             1          0         0]
        [-sind(angle)  0     cosd(angle)    0]
        [0             0          0         1]
        ];
else
    rm = [
        [cosd(angle)   -sind(angle)    0]
        [sind(angle)    cosd(angle)    0]
        [0                 0           1]
        ];
    h_rm = [
        [cosd(angle)   -sind(angle)    0    0]
        [sind(angle)    cosd(angle)    0    0]
        [     0             0          1    0]
        [     0             0          0    1]
        ];
end % end if-statement
        
end % end the function