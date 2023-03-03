% This program is designed to calculate the angle between 2 vectors
% in 3D space.

function angle = angle_between_twoVectors(v1, v2)
angle = atan2d(norm(cross(v1, v2)), dot(v1, v2));
end % end the function