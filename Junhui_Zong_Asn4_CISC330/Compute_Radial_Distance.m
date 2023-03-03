% Q7: Compute Radial Distance

function radial_distance = Compute_Radial_Distance(point_of_interest, beam_index)
% This function is to  compute the radial distance between arbitrary 
% point of interest and the center line of a beam.
% Input:
%       point_of_interest: an arbitrary point of interest
%       beam_index: the index of the pencil beam
% Output:
%       radial_distance: the distance of the point from the beam

global PTV_CENTER;
beam_structure_array = Compute_Skin_Entry_Points();

% find the corresponding beam
unit_v = beam_structure_array(beam_index, 3:5);

% find the distance by using the function written before
radial_distance = distance_of_point_from_line(PTV_CENTER, unit_v, point_of_interest);

end % end the function