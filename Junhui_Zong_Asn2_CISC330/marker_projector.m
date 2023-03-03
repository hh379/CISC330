% This function is to project a point in CK space onto the two imaging 
% detectors and report the resulting coordinates in detector image frame.

function [p_inA, p_inB] = marker_projector(p_inCk)
% Input:
%       p_inCk: point in CK frame
% Output:
%       p_inA: projected point in detector A frame
%       p_inB: projected point in detector B frame

% find coordinates of two x-ray sources in CK frame
S_A_inCk = [-50*sqrt(2) 50*sqrt(2) 0];
S_B_inCk = [50*sqrt(2) 50*sqrt(2) 0];
% find normal vectors of planes in which detectors A and B are located
n_A = [-sqrt(2)/2 sqrt(2)/2 0];
n_B = [sqrt(2)/2 sqrt(2)/2 0];

% fix points on detectors A and B
C_A_inCk = [50*sqrt(2) -50*sqrt(2) 0];
C_B_inCk = [-50*sqrt(2) -50*sqrt(2) 0];

%% Project to detector A
% compute the direction vector of the projection line from source A
v_A = (p_inCk - S_A_inCk) / (norm((p_inCk - S_A_inCk)));

% find the intersection of projecting line from source A and detector A,
% which is the projecting point from CK to A
[pA_inCk] = intersect_line_and_plane(C_A_inCk, n_A, p_inCk, v_A);
[transFromCkToA, ~] = frame_transform_from_CK_to_AB();
p_inA = transFromCkToA * [pA_inCk 1]';
p_inA = [p_inA(1) p_inA(2) p_inA(3)];

%% Project to detector B
% compute the direction vector of the projection line from source B
v_B = (p_inCk - S_B_inCk) / (norm((p_inCk - S_B_inCk)));

% find the intersection of projecting line from source B and detector B,
% which is the projecting point from CK to B
[pB_inCk] = intersect_line_and_plane(C_B_inCk, n_B, p_inCk, v_B);
[~, transFromCkToB] = frame_transform_from_CK_to_AB();
p_inB = transFromCkToB * [pB_inCk 1]';
p_inB = [p_inB(1) p_inB(2) p_inB(3)];

% % Test the validity of this function: uncomment them to do tests
% % by calculating the sum of the squares of the two right-angled sides and 
% % the square of the hypotenuse, respectively,
% % then print them to see if they are equal.
% 
% % for projecting onto A,
% disp("For projection onto A,")
% d1 = p_inA(1)*p_inA(1) + 200^2;
% disp("The sum of the squares of the two right-angled sides:");
% disp(d1);
% d2 = (S_A_inCk(1) - pA_inCk(1))^2 + (S_A_inCk(2) - pA_inCk(2))^2;
% disp("the square of the hypotenuse:");
% disp(d2);
% disp(" ");
% % for projecting onto B,
% disp("For projection onto B,");
% d3 = p_inB(1)*p_inB(1) + 200^2;
% disp("The sum of the squares of the two right-angled sides:");
% disp(d3);
% d4 = (S_B_inCk(1) - pB_inCk(1))^2 + (S_B_inCk(2) - pB_inCk(2))^2;
% disp("the square of the hypotenuse:");
% disp(d4);

end % end the function