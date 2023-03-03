% This file finds the intersection of a line and a plane.

function [intersection_point] = intersect_line_and_plane(A, n, p, v)
% This function finds the intersection of a line and a plane.
% Input:
%       A: a fix point on the plane
%       n: the normal vector of the plane
%       p: a fix point on the line
%       v: the normal vector of the line
% Output:
%       intersection_point: the coordinate of the intersection point
%                           of the line and the plane

assert(isequal(size(A), size(n), size(p), size(v), [1, 3]), ...
        'Input arguments are of wrong formats.');

% normalize the direction vector
v = normalize(v);

if dot(n, v) == 0
    intersection_point = 0;
else
    % compute the t
    t = dot((A - p), n) / (dot(v, n));
    intersection_point = p + v * t;
end % end if-statement

end % end the function