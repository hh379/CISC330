% Q13: Compute Volume Dose in PTV

function Compute_Volume_Dose_PTV()
% This function is used  to compute the dose inside the structure, using 
% a uniform cartesian grid placed in the center of the structure.
% INPUT:
%       None
% OUTPUT:
%       None

global PTV_RADIUS;
global PTV_CENTER;
global GRID_SIZE;

% initialize a vector to store dose values
dose_val = [];
% counter to count the number of valid points
counter = 0;
for x = (PTV_CENTER(1) - PTV_RADIUS):GRID_SIZE:(PTV_CENTER(1) + PTV_RADIUS)
    for y = (PTV_CENTER(2) - PTV_RADIUS):GRID_SIZE:(PTV_CENTER(2) + PTV_RADIUS)
        for z = (PTV_CENTER(3) - PTV_RADIUS):GRID_SIZE:(PTV_CENTER(3) + PTV_RADIUS)
            % to check if this point is inside this sphere or not
            if is_inside_sphere([x y z], PTV_CENTER, PTV_RADIUS)
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
title('PTV Dose Volume Histogram');
xlabel('relative dose');
ylabel('ratio of total structure volume[%]');
plot(edges(:,2:end), relative_volume(:,:), 'b');
plot(edges(:,2:end), cum_volum(:,:), 'r');
legend('Relative Dose', 'Cumulative Dose');
hold off;

end % end the function