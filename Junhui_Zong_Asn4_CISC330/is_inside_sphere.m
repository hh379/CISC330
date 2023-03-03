% This function is to determine if a point is inside a sphere or not.

function flag = is_inside_sphere(P, C, R)
% INPUT:
%       P: the point to be determined
%       C: the center of the sphere
%       R: the radius of the sphere
% OUTPUT:
%       flag: a boolean value to indicate if the point is inside the sphere

flag = ((P(1) - C(1))^2 + (P(2) - C(2))^2 + (P(3) - C(3))^2) <= R^2;

end