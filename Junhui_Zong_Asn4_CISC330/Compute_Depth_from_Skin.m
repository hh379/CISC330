% Q8: Compute Depth from Skin

function depth_from_skin = Compute_Depth_from_Skin(point_of_interest, beam_index)
% This function is  to compute the skin depth belonging to an arbitrary 
% point of interest with respect to a pencil beam.
% Input:
%       point_of_interest: an arbitrary point of interest
%       beam_index: the index of the pencil beam
% Output:
%       depth_from_skin: the skin depth("d")

global PTV_CENTER;
beam_structure_arr = Compute_Skin_Entry_Points();

% find the corresponding beam
unit_v = beam_structure_arr(beam_index, 3:5);

% find the intersection of the beam and the plane where the point of 
% interest is located on
intersect = intersect_line_and_plane(point_of_interest, unit_v, PTV_CENTER, unit_v);

% find the skin entry point
skinEntry = beam_structure_arr(beam_index, 6:8);
% compute the skin depth
depth_from_skin = norm(skinEntry - intersect);

end % end the function