% Q10: Compute Point Dose from All Beams

function point_dose_value = Compute_Point_Dose_from_All_Beams(point_of_interest)
% This function is to compute the dose in a given point of interest 
% from all beams.
% Input:
%       point_of_interest: an arbitrary point of interest
% Output:
%       point_dose_value: the dose in a given point of interest 
%                         from all beams

beam_structure_arr = Compute_Skin_Entry_Points();
[N, ~] = size(beam_structure_arr);

% initialize the value to be 0
point_dose_value = 0;
for index = 1:N
    pd_value = Compute_Point_Dose_from_Beam(point_of_interest, index);
    point_dose_value = point_dose_value + pd_value;
end % end for-loop

end % end the function