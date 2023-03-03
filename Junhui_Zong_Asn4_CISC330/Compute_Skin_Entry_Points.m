% Q5: Compute Skin Entry Points

function new_beam_structure_array = Compute_Skin_Entry_Points()
% This function is to compute for each beam the skin entry point and 
% the depth of the isocenter from the skin entry point.
% INPUT:
%       None
% OUTPUT:
%       None

global ISOCENTER;
global HEAD_A;
global HEAD_B;
global HEAD_C;
beam_structure_array = Compute_Beam_Directions(ISOCENTER, HEAD_A, HEAD_B, HEAD_C);

[N, ~] = size(beam_structure_array);
new_beam_structure_array = zeros(N, 9);
% plot all beams
for i = 1:N
    % get the unit direction vector
    unit_v = beam_structure_array(i, 3:5);

    % calculate the coordinates of intersections of 
    % pencil beam and the head
    [~, intersections] = intersect_line_and_ellipsoid(ISOCENTER, unit_v, HEAD_A, HEAD_B, HEAD_C);
    % We will have 2 intersections.
    % By checking the value of Z, we keep those whose value of Z 
    % is greater or equal than 0.
    intersect1 = intersections(1, :);
    intersect2 = intersections(2, :);
    if (intersect1(3) >= 0)
        intersect = intersect1;
    else
        intersect = intersect2;
    end % end if-statement

    % compute the depth of the isocenter from the skin entry point 
    d = distance_of_two_points(intersect, ISOCENTER);

    % update the array
    new_beam_structure_array(i, :) = [beam_structure_array(i, :) intersect d];

end % end for-loop

end % end the function