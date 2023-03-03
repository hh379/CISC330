% This main.m is used to store some global variables and call other
% functions to test their validities.

global D_0;
D_0 = 1;
global D_100;
D_100 = 20;
global D_OARMAX;
D_OARMAX = 10;

% Attributes of the helmet
global BEAM_SEP_ANGLE;
BEAM_SEP_ANGLE = 30;
global BEAM_DIAMETER;
BEAM_DIAMETER = 30;

% Attributes of PTV sphere
global PTV_RADIUS;
PTV_RADIUS = 15;
global PTV_CENTER;
PTV_CENTER = [30 0 15];
global ISOCENTER;
ISOCENTER = PTV_CENTER;

% Attributes of OAR ellipsoid
global OAR_A;
OAR_A = 15;
global OAR_B;
OAR_B = 25;
global OAR_C;
OAR_C = 15;
global OAR_CENTER;
OAR_CENTER = [0 30 45];

% Attributes of patient head ellipsoid
global HEAD_A;
HEAD_A = 80;
global HEAD_B;
HEAD_B = 100;
global HEAD_C;
HEAD_C = 80;
global HEAD_CENTER;
HEAD_CENTER = [0 0 0];

% grid size in mm
global GRID_SIZE;
GRID_SIZE = 1;

%% call testinng functions to do tests, uncommennt them to do relevant tests

% test_Draw_3D_Scene(); % Q1

% test_Compute_Depth_Dose(); % Q2

% test_Compute_Radial_Dose(); % Q3

% test_Compute_Beam_Directions(); % Q4

% test_Compute_Skin_Entry_Points(); % Q5

% test_Compute_Beam_Safety_Flags(); % Q6

% test_Compute_Radial_Distance(); % Q7

% test_Compute_Depth_from_Skin(); % Q8

% test_Compute_Point_Dose_from_Beam(); % Q9

% test_Compute_Point_Dose_from_All_Beams(); % Q10

% test_Compute_Surface_Dose_PTV(); % Q11

% test_Compute_Surface_Dose_OAR(); % Q12

% test_Compute_Volume_Dose_PTV(); % Q13

% test_Compute_Volume_Dose_OAR(); % Q14

%% Test for Draw_3D_Scene()
function test_Draw_3D_Scene()
Draw_3D_Scene();
end

%% Test for Compute_Depth_Dose()
function test_Compute_Depth_Dose()
global HEAD_B;
% let the max depth be twice of the longest half length of HEAD
max_d = HEAD_B * 2;
r = 1;
table = Compute_Depth_Dose(r, max_d);
disp(table);
end

%% Test for Compute_Radial_Dose()
function test_Compute_Radial_Dose()
r = 1;
table = Compute_Radial_Dose(r);
disp(table);
end

%% Test for Compute_Beam_Directions()
function test_Compute_Beam_Directions()
global PTV_CENTER;
global ISOCENTER;
global HEAD_A;
global HEAD_B;
global HEAD_C;
beam_structure_array = Compute_Beam_Directions(ISOCENTER, HEAD_A, HEAD_B, HEAD_C);

% plot isocenter
plot3(PTV_CENTER(1), PTV_CENTER(2), PTV_CENTER(3));
hold on;
axis equal;
xlabel("X-axis");
ylabel("Y-axis");
zlabel("Z-axis");
title("Pencil Beams")

[N, ~] = size(beam_structure_array);
% plot all beams
for i = 1:N
    % get the unit direction vector
    unit_v = beam_structure_array(i, 3:5);
    % select reasonable starting and ending points
    start_beam = PTV_CENTER - 60 * unit_v;
    end_beam = PTV_CENTER + 75 * unit_v;
    % plot the pencil beam
    plot3([start_beam(1), end_beam(1)], ...
          [start_beam(2), end_beam(2)], ...
          [start_beam(3), end_beam(3)]);
end % end for-loop

end

%% Test for Compute_Skin_Entry_Points()
function test_Compute_Skin_Entry_Points()
global PTV_CENTER;
global HEAD_A;
global HEAD_B;
global HEAD_C;
global HEAD_CENTER;
global BEAM_STRUCTURE_AARAY;
beam_structure_array = Compute_Skin_Entry_Points();

% intialize sphere points
[X, Y, Z] = sphere;

% plot head ellipsoid 

% get head ellipsoid points
X_H = X * HEAD_A + HEAD_CENTER(1);
Y_H = Y * HEAD_B + HEAD_CENTER(2);
Z_H = Z * HEAD_C + HEAD_CENTER(3);

% color of the head
head_color = [0.5 0.5 0.5];
% plot sphere
head_h = surf(X_H, Y_H, Z_H);
set(head_h, 'FaceAlpha', 0.01, 'EdgeColor', head_color, 'EdgeAlpha', 0.4);

hold on;
axis equal;
xlabel("X-axis");
ylabel("Y-axis");
zlabel("Z-axis");
title("Pencil Beams Intersections")

% plot isocenter
plot3(PTV_CENTER(1), PTV_CENTER(2), PTV_CENTER(3), '.', 'MarkerSize', 20);

[N, ~] = size(beam_structure_array);
% plot all beams
for i = 1:N
    intersect = beam_structure_array(i, 6:8);
    % plot the intersections
    plot3(intersect(1), intersect(2), intersect(3), '.', 'MarkerSize', 10);
    % get the unit direction vector
    unit_v = beam_structure_array(i, 3:5);
    % select reasonable starting and ending points
    start_beam = PTV_CENTER - 120 * unit_v;
    end_beam = PTV_CENTER + 150 * unit_v;
    % plot the pencil beam
    plot3([start_beam(1), end_beam(1)], ...
          [start_beam(2), end_beam(2)], ...
          [start_beam(3), end_beam(3)]);
end % end for-loop

hold off;

end

%% Test for Compute_Beam_Safety_Flags()
function test_Compute_Beam_Safety_Flags()
global HEAD_CENTER;
global HEAD_A;
global HEAD_B;
global HEAD_C;
global OAR_A;
global OAR_B;
global OAR_C;
global OAR_CENTER;
global PTV_CENTER;
beam_structure_array = Compute_Beam_Safety_Flags();

% intialize sphere points
[X, Y, Z] = sphere;

% plot head ellipsoid 

% get head ellipsoid points
X_H = X * HEAD_A + HEAD_CENTER(1);
Y_H = Y * HEAD_B + HEAD_CENTER(2);
Z_H = Z * HEAD_C + HEAD_CENTER(3);

% color of the head
head_color = [0.5 0.5 0.5];
% plot sphere
head_h = surf(X_H, Y_H, Z_H);
set(head_h, 'FaceAlpha', 0.01, 'EdgeColor', head_color, 'EdgeAlpha', 0.4);
text(0.75*HEAD_A, 0.75*HEAD_B, 0, "HEAD");

hold on;
axis equal;
xlabel("X-axis");
ylabel("Y-axis");
zlabel("Z-axis");

% plot OAR ellipsoid
X_OAR = X * OAR_A + OAR_CENTER(1);
Y_OAR = Y * OAR_B + OAR_CENTER(2);
Z_OAR = Z * OAR_C + OAR_CENTER(3);
% color of OAR
% OAR_color = [0.5 0.25 0.25];
OAR_color = [0.8500 0.3250 0.0980];
% plot sphere
OAR_h = surf(X_OAR, Y_OAR, Z_OAR);
set(OAR_h, 'FaceAlpha', 0.2, 'EdgeColor', OAR_color, 'EdgeAlpha', 0.2);
text(OAR_CENTER(1), OAR_CENTER(2), OAR_CENTER(3), "OAR");

% plot PTV_CENTER
plot3(PTV_CENTER(1), PTV_CENTER(2), PTV_CENTER(3), '.', 'MarkerSize', 15);

[N, ~] = size(beam_structure_array);
for i = 1:N
    flag = beam_structure_array(i, 10);
    % check if it is a safe beam
    if flag == 0
        % initialize a cylinder
        [X_c, Y_c, Z_c] = cylinder;
        [M, N] = size(X_c);

        % initialize two rotation matrices to rotate beam cylinder
        [rotY, ~] = rotation_about_frame_axis('y', -beam_structure_array(i,2));
        [rotZ, ~] = rotation_about_frame_axis('z', beam_structure_array(i,1));

        % rotate each ponit of the beam cylinder
        for j = 1:M
            for k = 1:N
                rot_pt = (rotZ * rotY * [X_c(j,k); Y_c(j,k); Z_c(j,k)]) + PTV_CENTER.';
                X_c(j, k) = rot_pt(1);
                Y_c(j, k) = rot_pt(2);
                Z_c(j, k) = rot_pt(3);
            end
        end
        % plot beam cylinder
        Cylinder_h = surf(X_c, Y_c, Z_c);
        set(Cylinder_h, 'FaceAlpha', 0.2, 'EdgeColor', OAR_color, 'EdgeAlpha', 0.2);
        % find the directional vector of corresponding beam
        unit_v = beam_structure_array(i, 3:5);

        % select reasonable starting and ending points
        start_beam = PTV_CENTER - 120 * unit_v;
        end_beam = PTV_CENTER + 150 * unit_v;

        % plot the beam
        plot3([start_beam(1), end_beam(1)],[start_beam(2), end_beam(2)],[start_beam(3), end_beam(3)], 'k');
    end
end
hold off
end

%% Test for Compute_Radial_Distance()
function test_Compute_Radial_Distance()
global PTV_CENTER;
global PTV_RADIUS;
% the fourth pencil beam is the one we want
index = 4;
% select the lateral edge of the PTV
p_interst = PTV_CENTER - [0 PTV_RADIUS 0];
radial_distance = Compute_Radial_Distance(p_interst, index);
disp(" ");
fprintf("The radial distance should be %d, and it is: %.2f\n", PTV_RADIUS, radial_distance);
disp(" ");
end

%% Test for Compute_Depth_from_Skin()
function test_Compute_Depth_from_Skin()
global PTV_CENTER;
global PTV_RADIUS;
global ISOCENTER;
beam_structure_arr = Compute_Skin_Entry_Points();
% the fourth pencil beam is the one we want
index = 4;
% select the lateral edge of the PTV
p_interst = PTV_CENTER - [0 PTV_RADIUS 0];
d = Compute_Depth_from_Skin(p_interst, index);
% compute the correct distance to ascertain correctness
d_correct = norm(PTV_CENTER - beam_structure_arr(index, 6:8));
disp(" ");
fprintf("The radial distance should be %.4f, and it is: %.4f\n", d_correct, d);
disp(" ");
end

%% Test for Compute_Point_Dose_from_Beam()
function test_Compute_Point_Dose_from_Beam()
global ISOCENTER;
global HEAD_B;
max_d = HEAD_B * 2;
resolution = 1;
DAF_table = Compute_Depth_Dose(resolution, max_d);

beam_structure_arr = Compute_Skin_Entry_Points();
[N, ~] = size(beam_structure_arr);
true_count = 0;
for index = 1:N
    % find the DAF value at the depth of the isocenter along the beam
    d = round(Compute_Depth_from_Skin(ISOCENTER, index));
    DAF = DAF_table(d + 1, 2);

    % compute the point dose
    pd_value = Compute_Point_Dose_from_Beam(ISOCENTER, index);

    % count the times that pd_value = DAF
    if (pd_value == DAF)
        true_count = true_count + 1;
    end % end if-statement
end % end for-loop

if (true_count == N)
    disp("The point dose value is equal to the DAF value" + ...
        " for all the beam.");
    disp("Test passed!");
else
    disp("Test failed!");
end % end if-statement

end

%% Test for Compute_Point_Dose_from_All_Beams()
function test_Compute_Point_Dose_from_All_Beams()
global ISOCENTER;
global HEAD_B;
max_d = HEAD_B * 2;
resolution = 1;
DAF_table = Compute_Depth_Dose(resolution, max_d);

beam_structure_arr = Compute_Skin_Entry_Points();
[N, ~] = size(beam_structure_arr);
sum_DAF = 0;
for index = 1:N
    % find the DAF value at the depth of the isocenter along the beam
    d = round(Compute_Depth_from_Skin(ISOCENTER, index));
    DAF = DAF_table(d + 1, 2);

    % add every DAF together
    sum_DAF = sum_DAF + DAF;
end

% check to see if sum_DAF is equal to the result computed from
% Compute_Point_Dose_from_All_Beams()
pd_value = Compute_Point_Dose_from_All_Beams(ISOCENTER);

if (sum_DAF == pd_value)
    disp(" ");
    disp("These two results are equal.");
    disp("Test passed!");
    disp(" ");
else
    disp(" ");
    disp("Test failed!");
    disp(" ");
end % end if-statement 
end

%% Test for Compute_Surface_Dose_PTV()
function test_Compute_Surface_Dose_PTV()
Compute_Surface_Dose_PTV();
end

%% Test for Compute_Surface_Dose_OAR()
function test_Compute_Surface_Dose_OAR()
Compute_Surface_Dose_OAR();
end

%% Test for Compute_Volume_Dose_PTV()
function test_Compute_Volume_Dose_PTV()
Compute_Volume_Dose_PTV();
end

%% Test for Compute_Volume_Dose_OAR()
function test_Compute_Volume_Dose_OAR()
Compute_Volume_Dose_OAR();
end