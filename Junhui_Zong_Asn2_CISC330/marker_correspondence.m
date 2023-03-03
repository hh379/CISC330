% This function is to resolve the correspondences
% in the reconstruction of 3 identical markers.

function [corpd_m] = marker_correspondence(points_inA, points_inB)
% Input:
%       points_inA: 3 points in A detector frame
%       points_inB: 3 points in B detector frame
% Output:
%       corpd_m: a correspondence matrix

%% Find the REM matrix
% initialize a REM matrix
REM_m = eye(3);
for ix = 1:3
    for jx = 1:3
        % use marker_reconstruction() to compute REM
        [~, REM] = marker_reconstruction(points_inA(ix, :), points_inB(jx, :));
        REM_m(ix, jx) = REM;
    end
end

% create a vector to store the number of 
% (zero) elements in each row
row_zero_num_v = zeros(3, 1);
for ix1 = 1:3
    zero_counter1 = 0;
    for jx1 = 1:3
        if round(REM_m(ix1, jx1)) == 0
            zero_counter1 = zero_counter1 + 1;
        end
    end
    row_zero_num_v(ix1) = zero_counter1;
end

% create another vector to store the number of 
% (zero) elements in each column
col_zero_num_v = zeros(1, 3);
for ix2 = 1:3
    zero_counter2 = 0;
    for jx2 = 1:3
        if round(REM_m(jx2, ix2)) == 0
            zero_counter2 = zero_counter2 + 1;
        end
    end
    col_zero_num_v(ix2) = zero_counter2;
end

%% Find the correspondence matrix
% initialize a correspondence matrix
corpd_m = zeros(3, 2);
for ix1 = 1:3
    corpd_m(ix1, 1) = ix1;
end

for mx = 1:3
    % use index to track the position of (near) 0 element
    index = 0;
    for nx = 1:3
        % Check if the REM matrix satisfies:
        % there should be be exactly 1 (near) zero element 
        % in each row and each column
        if row_zero_num_v(mx) == 1 && col_zero_num_v(nx) == 1 && round(REM_m(mx, nx)) == 0
            index = nx;
            break;
        else
            index = -1;
        end
    end
    % update the correspondence matrix
    corpd_m(mx, 2) = index;
end

end % end the function