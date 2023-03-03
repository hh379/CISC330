% This main.m is for calling and testing all of other files or functions.

% All points or vectors in this file is in the format of [A B C].

%% call testinng functions to do tests, uncommennt them to do relevant tests

% test_frame_transform_from_CK_to_AB();

% test_marker_projector();

% test_marker_reconstruction();

% test_marker_correspondence();

% test_target_registration();

% test_TRE_Simulation();               % for one single TRE simulation

%% Tests for frame_transform.m
function test_frame_transform_from_CK_to_AB()
clc;
% test#1 - (0, 0, 0) from CK frame to A and B
disp("test#1:");
[transFromCkToA1, transFromCkToB1] = frame_transform_from_CK_to_AB();
p1_inCk = [0 0 0];
disp("Test point in CK frame:");
disp(p1_inCk);
p_inA1 = transFromCkToA1 * [p1_inCk 1]';
disp("The point in A detector image frame is: ");
p_inA1 = [p_inA1(1) p_inA1(2) p_inA1(3)];
disp(p_inA1);
p_inB1 = transFromCkToB1 * [p1_inCk 1]';
p_inB1 = [p_inB1(1) p_inB1(2) p_inB1(3)];
disp("The point in B detector image frame is: ");
disp(p_inB1);
disp(" ");
% test#2 - (1, 0, 0) from CK frame to A and B
disp("test#2:");
[transFromCkToA2, transFromCkToB2] = frame_transform_from_CK_to_AB();
p5_inCk = [1 0 0];
disp("Test point in CK frame:");
disp(p5_inCk);
p_inA2 = transFromCkToA2 * [p5_inCk 1]';
disp("The point in A detector image frame is: ");
p_inA2 = [p_inA2(1) p_inA2(2) p_inA2(3)];
disp(p_inA2);
p_inB2 = transFromCkToB2 * [p5_inCk 1]';
p_inB2 = [p_inB2(1) p_inB2(2) p_inB2(3)];
disp("The point in B detector image frame is: ");
disp(p_inB2);
disp(" ");
% test#3 - (0, 1, 0) from CK frame to A and B
disp("test#3:");
[transFromCkToA3, transFromCkToB3] = frame_transform_from_CK_to_AB();
p3_inCk = [0 1 0];
disp("Test point in CK frame:");
disp(p3_inCk);
p_inA3 = transFromCkToA3 * [p3_inCk 1]';
disp("The point in A detector image frame is: ");
p_inA3 = [p_inA3(1) p_inA3(2) p_inA3(3)];
disp(p_inA3);
p_inB3 = transFromCkToB3 * [p3_inCk 1]';
p_inB3 = [p_inB3(1) p_inB3(2) p_inB3(3)];
disp("The point in B detector image frame is: ");
disp(p_inB3);
disp(" ");
clear;
end

%% Tests for marker_projector.m
function test_marker_projector()
clc;
% test#1
disp("test#1:");
p_inCk1 = [0 0 0];
disp(p_inCk1);
[p_inA1, p_inB1] = marker_projector(p_inCk1);
disp("The coordinate of the point projected to detector A is:");
disp(p_inA1);
disp("The coordinate of the point projected to detector B is:");
disp(p_inB1);
disp(" ");
% test#2
disp("test#2:");
p_inCk2 = [1 0 0];
disp(p_inCk2);
[p_inA2, p_inB2] = marker_projector(p_inCk2);
disp("The coordinate of the point projected onto detector A is:");
disp(p_inA2);
disp("The coordinate of the point projected onto detector B is:");
disp(p_inB2);
disp(" ");
% test#3
disp("test#3:");
p_inCk3 = [0 1 0];
disp(p_inCk3);
[p_inA3, p_inB3] = marker_projector(p_inCk3);
disp("The coordinate of the point projected onto detector A is:");
disp(p_inA3);
disp("The coordinate of the point projected onto detector B is:");
disp(p_inB3);
clear;
end

%% Tests for marker_reconstruction.m
function test_marker_reconstruction()
clc;
% test#1
% -------same points from test_marker_projector()------ %
disp("test#1:");
p_inCk1 = [0 0 0];
[p_inA1, p_inB1] = marker_projector(p_inCk1);
[p_reconstructed_inCk1, REM1] = marker_reconstruction(p_inA1, p_inB1);
disp("The reconstructed point in CK frame is:");
disp(p_reconstructed_inCk1);
disp("REM:");
disp(REM1);
disp(" ");
% test#2
% -------same points from test_marker_projector()------ %
disp("test#2:");
p_inCk2 = [1 0 0];
[p_inA2, p_inB2] = marker_projector(p_inCk2);
[p_reconstructed_inCk2, REM2] = marker_reconstruction(p_inA2, p_inB2);
disp("The reconstructed point in CK frame is:");
disp(p_reconstructed_inCk2);
disp("REM:");
disp(REM2);
disp(" ");
% test#3
% -------same points from test_marker_projector()------ %
disp("test#3:");
p_inCk3 = [0 1 0];
[p_inA3, p_inB3] = marker_projector(p_inCk3);
[p_reconstructed_inCk3, REM3] = marker_reconstruction(p_inA3, p_inB3);
disp("The reconstructed point in CK frame is:");
disp(p_reconstructed_inCk3);
disp("REM:");
disp(REM3);
disp(" ");

% -----more tests-----
C_inCk = [0 -30 30];
M1_inCk = [-30 30 30];
M2_inCk = [30 30 0];
M3_inCk = [0 30 60];
% test#4 - test of projecting C_CK
disp("test#4:");
[p_inA4, p_inB4] = marker_projector(C_inCk);
[p_reconstructed_inCk4, REM4] = marker_reconstruction(p_inA4, p_inB4);
disp("The reconstructed point in CK frame is:");
disp(p_reconstructed_inCk4);
disp("REM:");
disp(REM4);
disp(" ");
% test#5 - test of projecting M1_CK
disp("test#5:");
[p_inA5, p_inB5] = marker_projector(M1_inCk);
[p_reconstructed_inCk5, REM5] = marker_reconstruction(p_inA5, p_inB5);
disp("The reconstructed point in CK frame is:");
disp(p_reconstructed_inCk5);
disp("REM:");
disp(REM5);
disp(" ");
% test#6 - test of projecting M2_CK
disp("test#6:");
[p_inA6, p_inB6] = marker_projector(M2_inCk);
[p_reconstructed_inCk6, REM6] = marker_reconstruction(p_inA6, p_inB6);
disp("The reconstructed point in CK frame is:");
disp(p_reconstructed_inCk6);
disp("REM:");
disp(REM6);
disp(" ");
% test#7 - test of projecting M3_CK
disp("test#7:");
[p_inA7, p_inB7] = marker_projector(M3_inCk);
[p_reconstructed_inCk7, REM7] = marker_reconstruction(p_inA7, p_inB7);
disp("The reconstructed point in CK frame is:");
disp(p_reconstructed_inCk7);
disp("REM:");
disp(REM7);
clear;
end

%% Tests for marker_correspondence.m
function test_marker_correspondence()
clc;
M1_inCk = [-30 30 30];
M2_inCk = [30 30 0];
M3_inCk = [0 30 60];
[M1_inA, M1_inB] = marker_projector(M1_inCk);
[M2_inA, M2_inB] = marker_projector(M2_inCk);
[M3_inA, M3_inB] = marker_projector(M3_inCk);
% test#(1)
disp("test#(1):");
disp("Before swapping,");
points_inA1 = [M1_inA; M2_inA; M3_inA];
points_inB1 = [M1_inB; M2_inB; M3_inB];
[corpd_m1] = marker_correspondence(points_inA1, points_inB1);
disp(corpd_m1);
% test#(2)
disp("test#(2):");
disp("After swapping,");
points_inA2 = [M2_inA; M1_inA; M3_inA];
points_inB2 = [M1_inB; M2_inB; M3_inB];
[corpd_m2] = marker_correspondence(points_inA2, points_inB2);
disp(corpd_m2);
clear;
end

%% Tests for target_registration.m
function test_target_registration()
clc;
C_CT = [0 -30 30];
% points in CT frame
M1_inCT = [-30 30 30];
M2_inCT = [30 30 0];
M3_inCT = [0 30 60];
points_inCT = [M1_inCT; M2_inCT; M3_inCT];
% points in CK frame
M1_inCk = [-30 30 30];
M2_inCk = [30 30 0];
M3_inCk = [0 30 60];
points_inCK = [M1_inCk; M2_inCk; M3_inCk];
% C_CT
disp("C_CT(0, -30, 30),");
disp("In CT frame:");
disp(C_CT);
[target_inCK1] = target_registration(C_CT, points_inCT,  points_inCK);
disp("In CK frame:");
disp(target_inCK1);
% M1_inCT
disp("M1_inCT(-30, 30, 30),");
disp("In CT frame:");
disp(M1_inCT);
[target_inCK2] = target_registration(M1_inCT, points_inCT,  points_inCK);
disp("In CK frame:");
disp(target_inCK2);
% M2_inCT
disp("M2_inCT(30, 30, 0),");
disp("In CT frame:");
disp(M2_inCT);
[target_inCK3] = target_registration(M2_inCT, points_inCT,  points_inCK);
disp("In CK frame:");
disp(target_inCK3);
% M3_inCT
disp("M3_inCT(0, 30, 60),");
disp("In CT frame:");
disp(M3_inCT);
[target_inCK4] = target_registration(M3_inCT, points_inCT,  points_inCK);
disp("In CK frame:");
disp(target_inCK4);
clear;
end

%% Tests for TRE_Simulation.m
function test_TRE_Simulation()
clc;
TRE_Simulation();
clear;
end