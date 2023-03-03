% Q3: This function is to compute radial dose function value according 
% to the plot provided in the instruction

function radial_dose_function_table = Compute_Radial_Dose(resolution)
% INPUT:
%       resolution: increment between each row in the table
% OUTPUT:
%       radial_dose_function_table

% initialize a matrix to store elements in the table
row_num = 45/resolution + 1;
radial_dose_function_table = zeros(row_num, 2);

% initialize a counter
d = 1;
% variable - x
var = -23;
max = 23;
% fill out the table
while (var <= max)
    % According to the plot provided earlier,
    % before -22.5, between -22.5 and after -7.5, between -7.5 and 7.5, 
    % between 7.5 and 22.5, after 22.5 are five 
    % different linear equations.
    if (var < -22.5)
        radial_dose_function_table(d, :) = [var, 0];
    elseif (var >= -22.5 && var < -7.5)
        radial_dose_function_table(d, :) = [var, (1/15)*var + 3/2];
    elseif (var >= -7.5 && var < 7.5)
        radial_dose_function_table(d, :) = [var, 1];
    elseif (var >= 7.5 && var < 22.5)
        radial_dose_function_table(d, :) = [var, (-1/15)*var + 3/2];
    else
        radial_dose_function_table(d, :) = [var, 0];
    end % end if-statement

    % update var
    var = var + 1;
    % update d
    d = d + resolution;
end % end while-loop

end % end the function