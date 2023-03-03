% This function is designed to do marker simulation.

function new_marker = marker_simulator(original_marker)

% This is the distance of the marker offset
off_distance = 0;
% 0.00-0.05: 20%
if (rand >= 0) && (rand < 0.2)
    off_distance = randomNum_generator(0, 0.05);
% 0.05-0.10: 17%
elseif (rand >= 0.2) && (rand < 0.37)
    off_distance = randomNum_generator(0.05, 0.1);
% 0.10-0.15: 14%
elseif (rand >= 0.37) && (rand < 0.51)
    off_distance = randomNum_generator(0.1, 0.15);
% 0.15-0.20: 11%
elseif (rand >= 0.51) && (rand < 0.62)
    off_distance = randomNum_generator(0.15, 0.2);
% 0.20-0.25: 8.0%
elseif (rand >= 0.62) && (rand < 0.7)
    off_distance = randomNum_generator(0.2, 0.25);
% 0.25-0.30: 6%
elseif (rand >= 0.7) && (rand < 0.76)
    off_distance = randomNum_generator(0.25, 0.3);
% 0.30-0.35: 5.5%
elseif (rand >= 0.76) && (rand < 0.815)
    off_distance = randomNum_generator(0.3, 0.35);
% 0.35-0.40: 5%
elseif (rand >= 0.815) && (rand < 0.865)
    off_distance = randomNum_generator(0.35, 0.4);
% 0.40-0.45: 4.5%
elseif (rand >= 0.865) && (rand < 0.91)
    off_distance = randomNum_generator(0.4, 0.45);
% 0.45-0.50: 4%
elseif (rand >= 0.91) && (rand < 0.95)
    off_distance = randomNum_generator(0.45, 0.5);
% 0.50-1.00: 5%
elseif (rand >= 0.95) && (rand <= 1)
    off_distance = randomNum_generator(0.5, 1);
end % end if-statement

% generate a random unit error vector
err_vec = generate_random_unit_vector(3);
err_vec = err_vec / norm(err_vec) * off_distance;

% spoil the original marker
new_marker = original_marker + err_vec;

end % end the function