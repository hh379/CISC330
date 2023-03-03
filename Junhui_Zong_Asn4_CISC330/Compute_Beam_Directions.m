% Q4: Compute Beam Directions

function beam_structure_array = Compute_Beam_Directions(isoctr, head_a, head_b, head_c)
% This function is to compute the longitude, latitude, and 
% unit direction vector for each pencil beam’s centerline.
% INPUT:
%       isoctr: isocenter - a common cneter that all of the pencil beams 
%               aims at
%       head_a, head_b, head_c: half lengths of head ellipsoid
% OUTPUT:
%       beam_structure_array: contains the longitude, latitude, and 
%                             unit direction vector for each pencil 
%                             beam s centerline

global BEAM_SEP_ANGLE;

% row index position
row_idx = 1;

% initialize an array
beam_structure_array = zeros(360/BEAM_SEP_ANGLE*2, 5);
for lon = 0:BEAM_SEP_ANGLE:(360 - BEAM_SEP_ANGLE)
    for lat = 0:BEAM_SEP_ANGLE:90
        % convert the longitude and latitude into cartesian coordinates
        x = head_a * cosd(lat) * cosd(lon);
        y = head_b * cosd(lat) * sind(lon);
        z = head_c * sind(lat);
        head_point = [x y z];
        
        % by subtract the isocenter and the point converted, we can 
        % calculate the direction vector from the point on the helmet to 
        % the center of the helmet
        v = isoctr - head_point;
        
        % unitize the direction vector
        unit_v = v/norm(v);

        % uodate the array
        beam_structure_array(row_idx, :) = [lon lat unit_v];

        % update row index position
        row_idx = row_idx + 1;
    end
end

end % end the function