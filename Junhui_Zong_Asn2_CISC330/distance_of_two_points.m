% This function is to calculate the distance of two points in 3D space. 

function [d] = distance_of_two_points(p1, p2)
d = sqrt(((p1(1) - p2(1))^2) + ((p1(2) - p2(2))^2) + ((p1(3) - p2(3))^2));
end % end the function