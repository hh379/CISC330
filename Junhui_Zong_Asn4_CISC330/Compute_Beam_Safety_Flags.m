% Q6: Compute Beam Safety Flags


function new_beam_structure_array = Compute_Beam_Safety_Flags()
% This function is to compute a beam safety flag for each beam.
% INPUT:
%       None
% OUTPUT:
%       Non

global ISOCENTER;
global OAR_A;
global OAR_B;
global OAR_C;
global OAR_CENTER;
beam_structure_array = Compute_Skin_Entry_Points();

global BEAM_DIAMETER;
beam_radius = BEAM_DIAMETER / 2;

% To check if the beam is safe or unsafe,
% I will check the supersphere on the ellipsoid first. If there is no
% intersection of beam and this supersphere, then we can make sure that the
% beam is safe, which makes the flag equal 1. If there is more than 1 
% intersection, then I will generate a point on the ellipsoid and check
% each surface point with respect to the cylinder for N times(i.e. check:
% distance of the point and the direction vector of central axis of the 
% cylinder). As long as there is an intersection between them both once in 
% N times, then the flag is 0.
[M, ~] = size(beam_structure_array);
% intialize a matrix
new_beam_structure_array = zeros(M, 10);
for i = 1:M
    % get the unit direction vector
    unit_v = beam_structure_array(i, 3:5);
    num_intersect = intersect_sphere_and_cylinder(OAR_CENTER, OAR_B, beam_radius, ISOCENTER, unit_v);
    if (num_intersect == 0)
        % safe case
        new_beam_structure_array(i, :) = [beam_structure_array(i, :) 1];
    else
        % check each surface point with respect to the cylinder for N times
        N = 300;
        for j = 1:N
            % generate a point on the ellipsoid
            p_ellipsoid = random_point_on_ellipsoid(OAR_CENTER, OAR_A, OAR_B, OAR_C);
            d = distance_of_point_from_line(ISOCENTER, unit_v, p_ellipsoid);
            if (d <= beam_radius)
                % unsafe case
                new_beam_structure_array(i, :) = [beam_structure_array(i, :) 0];
                break;
            else
                % safe case
                new_beam_structure_array(i, :) = [beam_structure_array(i, :) 1];
            end % end if-statement
        end % end for-loop
    end % end if-statement

end % end for-loop 

end % end the function