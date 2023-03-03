%q6 - This function reconstructs the best fitting sphere from a set of points. 

function [C, R] = sphere_reconstruct(points_in)
% Input:
%       points_in: a set of points
% Output:
%       C: center point of the reconstructed sphere
%       R: radius of the reconstructed sphere

% Sphere fit function - sphereFit.m acquired from 
% [Alan Jennings, University of Dayton]
[C, R] = sphereFit(points_in);

end % end the function