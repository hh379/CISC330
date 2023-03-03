% Q2: Compute Dose Absorption Function Table

function dose_absoroption_function_table = Compute_Depth_Dose(resolution, max)
% This function is to compute the dose absorption table with some sensible
% resolution and maximum depth.
% absorption function given in the assignment.
% INPUT:
%       resolution: increment between each row in the table
%       max: maximum depth
% OUTPUT:
%       dose_absorption_function_table

% initialize a matrix to store elements in the table
row_num = max / resolution + 1;
dose_absoroption_function_table = zeros(row_num, 2);

% initialize a counter
d = 0;
% fill out the table
while (d <= max)
    % calculate the row index in table
    row_idx = round(d / resolution) + 1;

    % According to the plot provided earlier,
    % before and after 20 are two different linear equations.
    if (d <= 20)
        dose_absoroption_function_table(row_idx, :) = [d, 0.5 + 0.025 * d];
    else
        dose_absoroption_function_table(row_idx, :) = [d, 1 - 0.005 * (d - 20)];
    end % end if-statement

    % update d
    d = d + resolution;
end % end while-loop

end % end the function