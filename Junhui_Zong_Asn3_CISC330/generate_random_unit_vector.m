%q7 - This file generates a unit vector in random direction in 2D or in 3D. 

function [vector] = generate_random_unit_vector(d)
% This function generates a unit vector in random direction in 2D or in 3D. 
% Input:
%       d: the dimension(2 or 3)
% Output:
%       vector: a unit vector generated in random direction

% Generate a random vector, numbers within the vector is from -1 to 1,
% which would allow me to generate vectors in all four quadrants.
vector = rand(1,d) * 2 - 1;
% Compute the magnitude of the vector.
dis = norm(vector);
% Make a vector using (1/dis), which would give me a vector of magnitude 1,
% which is the unit vector.
vector = (1/dis) * vector;

end % end the function