
function [R] = rigid_transform_3D(A, B)
    
    % This function finds the optimal Rigid/Euclidean transform in 3D space
    % It expects as input a 3x3 matrix of 3D points.
    % It returns R

    narginchk(2,2);
    assert(all(size(A) == size(B)));

% ----------modified----------
%     [num_rows, num_cols] = size(A);
%     if num_rows ~= 3
%         error("matrix A is not 3xN, it is %dx%d", num_rows, num_cols)
%     end
% 
%     [num_rows, num_cols] = size(B);
%     if num_rows ~= 3
%         error("matrix B is not 3xN, it is %dx%d", num_rows, num_cols)
%     end
% 
%     % find mean column wise
%     centroid_A = mean(A, 2);
%     centroid_B = mean(B, 2);
% ----------modified----------

    % find mean column wise
    centroid_A = mean(A);
    centroid_B = mean(B);

    N = size(A,1);

    % subtract mean
    Am = A - repmat(centroid_A, N, 1);
    Bm = B - repmat(centroid_B, N, 1);

    % calculate covariance matrix (is this the correct terminology?)
    H = Am * Bm';

    % find rotation
    [U,S,V] = svd(H);
    R = V*U';

    if det(R) < 0
% ----------modified----------
%         printf("det(R) < R, reflection detected!, correcting for it ...\n");
% ----------modified----------
        V(:,3) = V(:,3) * -1;
        R = V*U';
    end

% ----------modified----------
%     t = -R*centroid_A + centroid_B;
% ----------modified----------

end
