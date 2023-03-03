% This is to analyze the robustness of target registration 
% against marker segmentation errors.

function TRE_Simulation()
% Input:
%       None
% Output:
%       None

%% Generate N random ground-truth target points inside the envelop
% Number of random ground-truth target points
N = 50;        
err = 0.1;
% Initialize a matrix to store those target points
target_points = zeros(N, 3);
% Radius of the target envelop
R = 20;
% Center of the target envelop
C_CT = [0 -30 30];
for ix = 1:N
    % "scale" is a number between 0 and 1.
    % By multiplying it with x, y, z coordinates, 
    % we can have target points inside the target envelop.
    scale = rand(1, 1);
    theta = 2*pi*rand(1, 1);
    phi = pi*rand(1, 1);
    deltaR = -err + 2 * err * rand(1, 1);
    x = C_CT(1) + (R + deltaR) .* sin(phi) .* cos(theta) * scale;
    y = C_CT(2) + (R + deltaR) .* sin(phi) .* sin(theta) * scale;
    z = C_CT(3) + (R + deltaR) .* cos(phi) * scale;
    target_points(ix, :) = [x y z];
end

%% Project markers to the detectors
M1_inCk = [-30 30 30];
M2_inCk = [30 30 0];
M3_inCk = [0 30 60];
[M1_inA, M1_inB] = marker_projector(M1_inCk);
[M2_inA, M2_inB] = marker_projector(M2_inCk);
[M3_inA, M3_inB] = marker_projector(M3_inCk);
% Store image points in a matrix,
% so that we can spoil them one by one by a error vector
image_points = [
                M1_inA;
                M1_inB;
                M2_inA;
                M2_inB;
                M3_inA;
                M3_inB;
                ];

%% Simulation cycle
M1_inCT = [-30 30 30];
M2_inCT = [30 30 0];
M3_inCT = [0 30 60];
% collect 3 markers in CT frame
CT_frame_marker = [M1_inCT; M2_inCT; M3_inCT];
scalor = 1;
increment = 0.1;
flag = true;
while flag
    % update the marker segmentation error as a vector of 
    % random direction and of a fixed magnitude
    Emax = increment * scalor;

    %% Blend segmentation error
    % Spoil each marker image point by a error vector 
    % of random direction and of Emax magnitude,
    % within the detectorplane.
    for jx = 1:6
        % generate a segmentation error vector, which only spoil 
        % each marker image point within x-y plane in image frame
        err_vec = generate_random_unit_vector(3);
        err_vec(3) = 0;
        err_vec = err_vec / norm(err_vec) * Emax;
        % spoil each image point
        image_points(jx, :) = image_points(jx, :) + err_vec;
    end

    M1_err_inA = image_points(1, :);
    M1_err_inB = image_points(2, :);
    M2_err_inA = image_points(3, :);
    M2_err_inB = image_points(4, :);
    M3_err_inA = image_points(5, :);
    M3_err_inB = image_points(6, :);
    
    %% Target reconstruction
    % reconstruct the error-spoilt image points
    [M1_error_inCk, ~] = marker_reconstruction(M1_err_inA, M1_err_inB);
    [M2_error_inCk, ~] = marker_reconstruction(M2_err_inA, M2_err_inB);
    [M3_error_inCk, ~] = marker_reconstruction(M3_err_inA, M3_err_inB);

    % collect 3 markers with errors in CK frame
    CK_frame_marker_withErr = [M1_error_inCk; M2_error_inCk; M3_error_inCk];
    % register each ground-truth point from CT frame to CK frame
    for kx = 1:N
        %% Target registration
        target_p_inCT = target_points(kx, :);
        target_p_inCk = target_registration(target_p_inCT, CT_frame_marker,  CK_frame_marker_withErr);
        %% Compute TRE
        % since the CT frame and CK frame are identical, TRE:
        TRE = distance_of_two_points(target_p_inCT, target_p_inCk);
        maxTRE = 1;
        % check if TRE exceeds maxTRE
        if TRE > maxTRE
            disp("Exceed the clinical limit. Exit the simulation!");
            disp(" ");
            disp("TRE for now is:");
            disp(TRE);
            disp("The max allowable marker segmentation error is:");
            Emax = Emax - 0.1;
            disp(Emax);
            flag = false;
            break;
        end
    end

    % update the scalor
    scalor = scalor + 1;

end % end while-loops

end % end the function






