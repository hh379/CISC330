% q5 - This file computes the number of intersection points (0, 1 infinite) 
% between a sphere and an infinite cylinder.

function [num_intersection] = intersect_sphere_and_cylinder(C, R, r, P, v)
% Input:
%       C: the center of the sphere
%       R: the radius of the sphere
%       r: the radius of the cylinder
%       P: a fix point on the central axis of the cylinder
%       v: the direction vector of its central axis of the cylinder
% Output:
%       num_intersection: the number of intersection points (0, 1 infinite)

% First, compute the distance of the center of the sphere from 
% the central axis of the cylinder
d = distance_of_point_from_line(P, v, C);

% then we could determine the number of intersections 
% by cheking the distance calculated before
%     0    - d > R + r - There will be never an intersection between them
%     1    - d = R + r - Cylinder and sphere happen to be tangent to each other
% infinite - d < R + r - Cylinder and sphere intersect together and form a surface, 
%                        thus having an infinite number of intersection points
if (d > (R + r))
    num_intersection = 0;
elseif (d == R + r)
    num_intersection = 1;
else
    num_intersection = Inf;
end % end if-statement

end % end the function