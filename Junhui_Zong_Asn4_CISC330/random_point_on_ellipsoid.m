function p = random_point_on_ellipsoid(CTR, A, B, C)
% This function is used to generate a point on a ellipsoid.
% INPUT:
%       CTR: the center of the ellipsoid
%       A, B, C: half lengths of the ellipsoid
% OUTPUT:
%       p: the coordinate the point on the ellipsoid

% use built-in function ellipsoid to generate the coordinates
[x, y, z] = ellipsoid(CTR(1), CTR(2), CTR(3), A, B, C);
[~, N] = size(x);
% generate a random number
i = randi([1, N]);
j = randi([1, N]);
% select a random coordinate as the one of the point
p = [x(i, j) y(i, j) z(i, j)];

end