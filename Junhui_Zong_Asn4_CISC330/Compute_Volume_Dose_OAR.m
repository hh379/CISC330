% Q14: Compute Volume Dose in OAR

function Compute_Volume_Dose_OAR()
% This function is to compute the dose inside the structure, using a 
% uniform cartesian grid placed in the center of the structure.
% INPUT:
%       None
% OUTPUT:
%       None

global OAR_A;
global OAR_B;
global OAR_C;
global OAR_CENTER;
global GRID_SIZE;

% initialize a vector to store dose values
dose_val = [];
% counter to count the number of valid points
counter = 0;
for x = (OAR_CENTER(1) - OAR_A):GRID_SIZE:(OAR_CENTER(1) + OAR_A)
    for y = (OAR_CENTER(2) - OAR_B):GRID_SIZE:(OAR_CENTER(2) + OAR_B)
        for z = (OAR_CENTER(3) - OAR_C):GRID_SIZE:(OAR_CENTER(3) + OAR_C)
            % to check if this point is inside this ellipsoid or not
            if is_inside_ellipsoid([x y z], OAR_CENTER, OAR_A, OAR_B, OAR_C)
                % compute dose in the inside voxels
                point_dose = Compute_Point_Dose_from_All_Beams([x y z]);
                dose_val = [dose_val point_dose];
                counter = counter + 1;
            end % end if-statement
        end % end for loop
    end % end for loop
end % end for loop

% use histcounts() to generate the data 
% points for the dose volume histogram
[N, edges] = histcounts(dose_val, 10);

% compute the relative volume
relative_volume = N./counter;

% compute the cumulative volumes
cum_volum = cumsum(relative_volume);

% plot the result
hold on;
title('OAR Dose Volume Histogram');
xlabel('relative dose');
ylabel('ratio of total structure volume[%]');
plot(edges(:,2:end), relative_volume(:,:), 'b');
plot(edges(:,2:end), cum_volum(:,:), 'r');
legend('Relative Dose', 'Cumulative Dose');
hold off;

end % end the function