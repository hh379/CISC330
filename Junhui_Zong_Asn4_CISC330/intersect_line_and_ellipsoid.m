% q4 - This file finds the intersection of a line and a canonical ellipsoid.

function [num intersection] = intersect_line_and_ellipsoid(p, v, a, b, c)
% Input:
%       p: a fix point on the line
%       v: the direction vector of the line
%       a, b, c: a number - the half-axes lengths of this ellipsoid
% Output:
%       num: the number of the intersections
%       intersection: the coordinates of intersection points

assert(isequal(size(p), size(v), [1, 3]), ...
        'Input arguments are of wrong formats.');


% Here we assume the 2nd degree polynomial form of the equation is
% At^2 + Bt + C = 0
% According the calculation on my paper, it could be derived in the
% following way:
vx = v(1);
vy = v(2);
vz = v(3);
if vx == vy && vy == vz && vz == 0
    error("A valid direction vector is needed.");
end

px = p(1);
py = p(2);
pz = p(3);

% find the coefficients
A = (b * c * vx)^2 + (a * c * vy)^2  + (a * b * vz)^2;
B = 2 * (vx * (b * c)^2 * px + vy * (a * c)^2 * py + vz * (a * b)^2 * pz);
C = (b * c * px)^2 + (a * c * py)^2 + (a * b * pz)^2 - (a^2) * (b^2) * (c^2);

% compute the determinant
determinant = B^2 - 4 * A * C;
% check the determinant and then find roots
if determinant < 0
    num = 0;
    intersection = 0;
elseif determinant == 0
    num = 1;
    % find roots
    t = roots([A B C]);
    intersections = p + t * v;
    intersection = intersections(1, :);
else
    num = 2;
    % find roots
    t = roots([A B C]);
    intersection = p + t * v;
end % end if statement

end % end the function