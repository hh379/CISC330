% q1 - This function finds the distance of a point from a line.

function [distance] = distance_of_point_from_line(p, v, A)
% Input:
%       p: a fix point on the line 
%       v: the direction vector of the line 
%       A: the point outside of the line
% Output:
%       distance: the distance of a point from a line

    assert(isequal(size(p), size(v), size(A), [1, 3]), ...
        'Input arguments are of wrong formats.');

    % normalize the direction vector
    v = normalize(v);

    % find the length of c
    c = norm(A - p);
    % find the the length of a
    a = dot(v, (A - p));
    % find the distance
    distance = sqrt((c + a)*(c - a));

end % end the function
