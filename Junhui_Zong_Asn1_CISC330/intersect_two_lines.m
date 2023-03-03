% q2 - This file finds the approximate (symbolic) intersection of two lines, 
% with a suitable error metric.

function [intersection_point, REM] = intersect_two_lines(p1, v1, p2, v2)
% Input:
%       p1: a fix point on line1 
%       v1: the direction vector of line1
%       p2: a fix point on line2
%       v2: the direction vector of line2
% Output:
%       intersection_point: the coordinate of the symbolic intersection point
%       REM: Residual Error Metric

assert(isequal(size(p1), size(v1), size(p2), size(v2), [1, 3]), ...
    'Input arguments are of wrong formats.');

if v1 == v2
    intersection_point = 0;
    REM = norm(p1 - p2) / 2;
else

    % normalize the direction vector
    v1 = normalize(v1);
    v2 = normalize(v2);

    % compute and normalize the direction vector
    v3 = cross(v1, v2);
    v3 = normalize(v3);

    % find three t values
    avec = p1' - p2';
    amatrix = [-v1' v2' v3'];
    t_val = amatrix \ avec;

    % find the intersects of the third line and the other two
    L1 = p1 + t_val(1) .* v1;
    L2 = p2 + t_val(2) .* v2;

    % find the intersection point - the middle of L1 and L2
    intersection_point = (L1 + L2) / 2;
    % compute REM
    REM = norm(L1 - L2) / 2;

end % end if-statement

end % end function