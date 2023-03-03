% This function is to determine if a point is inside an ellipsoid or not.

function flag = is_inside_ellipsoid(P, CTR, A, B, C)
% INPUT:
%       P: the point to be determined
%       C: the center of the ellipsoid
%       A, B, C: lengths of three half axises of the ellipsoid
% OUTPUT:
%       flag: a boolean value to indicate if the point is 
%             inside the ellipsoid

flag = ((P(1) - CTR(1))^2/A + (P(2) - CTR(2))^2/B + (P(3) - CTR(3))^2)/C < 1;

end