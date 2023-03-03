% q9 - This file computes an orthonormal frame from three points.

function [Oe, base_v] = generate_orthonormal_frame(A, B, C)
% Input:
%       A, B, C: 3 points used to compute the frame      
% Output:
%       Oe: the center of the frame
%       base_v: 3 base vectors (e1, e2, e3) of the frame

% by calculating the area of the triangle formed by the three points A, B and C，
% to check if they are collinear
area = (1/2) * norm(cross((B - A), (C - A)));
if (area == 0)
    error("Three points are collinear and cannot generate  an orthonormal frame.");
end % end if-statement

% compute the center of the frame
Oe = (A + B + C) / 3;

% compute bases of the frame
e1 = normalize(B - A);
e3 = normalize(cross(e1, (C - A)));
e2 = cross(e3, e1);

% normalization
e1 = e1 / norm(e1);
e2 = e2 / norm(e2);
e3 = e3 / norm(e3);

base_v = [e1; e2; e3];

end % end the function