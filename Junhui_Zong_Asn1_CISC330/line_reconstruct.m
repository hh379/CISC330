% q8 - This file reconstructs the best fitting straight line from a set of points. 

function [p, v] = line_reconstruct(points_in)
% Input:
%       points_in: a set of points
% Output:
%       p: a holding point on the reconstructed line
%       v: the direction vector of the reconstructed line

% The following code is from mathworks and was written by Matt J.
% https://www.mathworks.com/matlabcentral/answers/78363-3d-line-of-best-fit
r0 = mean(points_in);
points_in=bsxfun(@minus, points_in, r0);
[~,~,V]=svd(points_in,0);

% find the fix point
p = r0;
% find the direction vector
v = V(:,1)';

end % end the function