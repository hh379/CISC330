% This main.m is for calling and testing all of other files or functions.

% All points or vectors in this file is in the format of [A B C].

%% call testinng functions to do tests, uncommennt them to do relevant tests

% Test_DistanceOfPointFromLine();     % Q1 test
 
% Test_IntersectTwoLines();           % Q2 test

% Test_IntersectLineAndPlane();       % Q3 test

% Test_IntersectLineAndEllipsoid();   % Q4 test

% Test_IntersectSphereAndCylinder();  % Q5 test

% Test_sphereReconstruct();           % Q6 test
  
% Test_GenerateRandomUnitVector();    % Q7 test
 
% Test_LineReconstruct();             % Q8 test

% Test_GenerateOrthonormalFrame();    % Q9 test

% Test_RotationAboutFrameAxis();      % Q10 test

Test_frame_transformation_to_home();% Q11 test

%% Tests for Q1
function Test_DistanceOfPointFromLine()
    % test#1
    p1 = [0 0 0];
    v1 = [0 1 0];
    a1 = [0 0 1];
    d1 = distance_of_point_from_line(p1, v1, a1);
    disp('The distance of the point from the line is: ');
    disp(d1);
    disp(" ");
    % test#2
    p2 = [0 0 0];
    v2 = [1 1 1];
    a2 = [5 5 5];
    d2 = distance_of_point_from_line(p2, v2, a2);
    disp('The distance of the point from the line is: ');
    disp(d2);
    disp(" ");
    % test#3
    p3 = [0 0 1];
    v3 = [1 1 0];
    a3 = [1 0 1];
    d3 = distance_of_point_from_line(p3, v3, a3);
    disp('The distance of the point from the line is: ');
    disp(d3);
    disp(" ");
end

%% Tests for Q2

function Test_IntersectTwoLines()
    % test#1 - intersecting
    p1_1 = [0 0 0];
    v1_1 = [1 1 1];
    p2_1 = [0 0 0];
    v2_1 = [0 0 1];
    [M1, REM1] = intersect_two_lines(p1_1, v1_1, p2_1, v2_1);
    disp("The number of intersections in this case:");
    disp(M1);
    disp("REM: ");
    disp(REM1);
    % test#2 - non-intersecting
    p1_2 = [1 0 0];
    v1_2 = [0 1 1];
    p2_2 = [0 0 0];
    v2_2 = [0 0 1];
    [M2, REM2] = intersect_two_lines(p1_2, v1_2, p2_2, v2_2);
    disp("The number of intersections in this case:");
    disp(M2);
    disp("REM: ");
    disp(REM2);
    % test#3 - parallel
    p1_3 = [1 1 1];
    v1_2 = [-1 1 0];
    p2_3 = [1 0 0];
    v2_3 = [-1 1 0];
    [M3, REM3] = intersect_two_lines(p1_3, v1_2, p2_3, v2_3);
    disp("These two lines are parallel to each other," + ...
        " so there is no intersection in this case.");
    disp(' ');
    disp("REM: ");
    disp(REM3);
end

%% Tests for Q3

function Test_IntersectLineAndPlane()
    % test#1 - parallel - n1 is perpendicular to v1
    a1 = [0 0 0];
    n1 = [0 0 1];
    p1 = [2 2 1];
    v1 = [0 1 0];
    [point1] = intersect_line_and_plane(a1, n1, p1, v1);
    disp('The line is parallel to the plane, so there is no intersection in this case.');
    disp(" ");
    % test#2 
    a2 = [0 0 0];
    n2 = [0 0 1];
    p2 = [1 0 0];
    v2 = [-1 1 1];
    [point2] = intersect_line_and_plane(a2, n2, p2, v2);
    disp('The intersection of the line and the plane is: ');
    disp(point2);
    % test#3 - perpendicular
    a3 = [0 0 0];
    n3 = [0 0 1];
    p3 = [1 2 2];
    v3 = [0 0 1];
    [point3] = intersect_line_and_plane(a3, n3, p3, v3);
    disp('The intersection of the line and the plane is: ');
    disp(point3);
end

%% Tests for Q4

function Test_IntersectLineAndEllipsoid()
    % test#1 - no intersection
    p1 = [3 0 0];
    v1 = [0 1 0];
    a1 = 2;
    b1 = 2;
    c1 = 1;
    [num1, intersection1] = intersect_line_and_ellipsoid(p1, v1, a1, b1, c1);    
    disp('The number of intersections of the line and this ellipsoid is:');
    disp(num1);
    disp(' ');
    % test#2 - 1 intersection
    p2 = [2 0 0];
    v2 = [0 0 1];
    a2 = 2;
    b2 = 2;
    c2 = 1;
    [num2, intersection2] = intersect_line_and_ellipsoid(p2, v2, a2, b2, c2);
    disp('The number of intersections of the line and this ellipsoid is:');
    disp(num2);
    disp("The intersection(s) of the line and this ellipsoid: ");
    disp(intersection2);
    disp(' ');
    % test#3 - 2 intersections
    p3 = [0 0 0];
    v3 = [0 0 1];
    a3 = 2;
    b3 = 2;
    c3 = 1;
    [num3, intersection3] = intersect_line_and_ellipsoid(p3, v3, a3, b3, c3);
    disp('The number of intersections of the line and this ellipsoid is:');
    disp(num3);
    disp("The intersection(s) of the line and this ellipsoid: ");
    disp(intersection3);
    disp(' ');
end

%% Tests for Q5
function Test_IntersectSphereAndCylinder()
    % test#1 - no intersection
    C1 = [6 0 0];
    R1 = 3;
    r1 = 2;
    P1 = [0 0 0];
    v1 = [0 0 1];
    [num1] = intersect_sphere_and_cylinder(C1, R1, r1, P1, v1);
    disp(" The number of intersections in this case:");
    disp(num1);
    disp(" ");
    % test#2 - 1 intersection - tangent
    C2 = [5 0 0];
    R2 = 3;
    r2 = 2;
    P2 = [0 0 0];
    v2 = [0 0 1];
    [num2] = intersect_sphere_and_cylinder(C2, R2, r2, P2, v2);
    disp(" The number of intersections in this case:");
    disp(num2);
    disp(" ");
    % test#3 - infinite intersections
    C3 = [2 0 0];
    R3 = 3;
    r3 = 2;
    P3 = [0 0 0];
    v3 = [0 0 1];
    [num3] = intersect_sphere_and_cylinder(C3, R3, r3, P3, v3);
    disp(" The number of intersections in this case:");
    disp(num3);
    disp(" ");
end

%% Tests for Q6

function Test_sphereReconstruct()
    % generate a set of 3D points with some noise
    err = 0.1;
    pointCount = 50;
    R = 20;
    theta = 2*pi*rand(pointCount, 1);
    phi = pi*rand(pointCount, 1);
    deltaR = -err + 2 * err * rand(pointCount, 1);
    x = (R + deltaR) .* sin(phi) .* cos(theta);
    y = (R + deltaR) .* sin(phi) .* sin(theta);
    z = (R + deltaR) .* cos(phi);
    % plot all of the points
    plot3(x, y, z, 'ro');

    hold on;
    % Perform a spherical least squares fit
    ponits_in = [x, y, z];
    [C, R] = sphere_reconstruct(ponits_in);
    % use 20x20 surface
    [xx, yy, zz] = sphere(20);
    xx = R * xx + C(1);
    yy = R * yy + C(2);
    zz = R * zz + C(3);
    h = surf(xx, yy, zz);
    set(h, 'FaceAlpha', 0.2, 'MeshStyle', 'none');
    xlabel('X', 'FontSize', 10);
    ylabel('Y', 'FontSize', 10);
    zlabel('Z', 'FontSize', 10);
    axis equal;
end

%% Tests for Q7
function Test_GenerateRandomUnitVector()
    % test - 2D
    v_2d = generate_random_unit_vector(2);
    disp(v_2d);
    figure(1);
    hold on;
    th = 0:pi/50:2*pi;
    xunit = 1 * cos(th);
    yunit = 1 * sin(th);
    x_2d = v_2d(1);
    y_2d = v_2d(2);
    plot(0, 0, '.');
    %plot([0, x_2d],[0, y_2d], 'b');
    plot(x_2d, y_2d, 'o');
    h = plot(xunit, yunit);
    xlabel('X', 'FontSize', 10);
    ylabel('Y', 'FontSize', 10);
    axis equal
    hold off;

    % test - 3D
    v_3d = generate_random_unit_vector(3);
    disp(v_3d);
    x_3d = v_3d(1);
    y_3d = v_3d(2);
    z_3d = v_3d(3);
    figure(2);
    plot3(x_3d, y_3d, z_3d, 'o');
    hold on;
    r = 1;
    [xx, yy, zz] = sphere(20);
    xx = r * xx;
    yy = r * yy;
    zz = r * zz;
    h = surf(xx, yy, zz);
    set(h, 'FaceAlpha', 0.2, 'MeshStyle', 'none');
    xlabel('X', 'FontSize', 10);
    ylabel('Y', 'FontSize', 10);
    zlabel('Z', 'FontSize', 10);
    axis equal;
end

%% Test for Q8
function Test_LineReconstruct()
%     % Ground truth test
    T = [70 0 0];
    points = [];
    for ix = 1:11
        points(ix, :) = [(ix-1)*5 0 0];
    end
    [p1, v1] = line_reconstruct(points);
    disp('In the ground truth test ----');
    disp(' ');
    disp('The fix point is:');
    disp(p1);
    disp('The direction vector is:');
    disp(v1);
    
    % Error simulation
    % A interval between two consecutive points is 5mm,
    % so it means length of 1 in this coordinate sysytem is 1mm
    scalor = 1;
    increment = 0.5;
    flag = true;
    while flag
        % update the error
        err = increment * scalor;

        % Create a vector to store the status, 
        % whether the distance for this round is greater than 2.5 or not.
        % d <= 2.5 - record a '1'
        % otherwise, record a '-1'
        hit_or_not = [];

        M = 1;
        while flag && M < 11 

            % to each point add the random measurement error vector
            new_points = [];
            for ix1 = 1:11
                % generate a unit vector
                unit_v = generate_random_unit_vector(3);
    
                % by multiplying the unit vector(unit_v) by the error('err')
                % to get a random measurement error vector
                err_v = unit_v * err;
    
                new_points(ix1, :) = points(ix1, :) + err_v;
            end

            % call line_reconstruct to 
            % find the fix point and the direction vector
            [p_e, v_e] = line_reconstruct(new_points);
            % compute the distance of the target point(T) from the reconstructed needle path
            d = distance_of_point_from_line(p_e, v_e, T);
%             disp(d);
            % compare the distance(d) with the upperbound 2.5
            % d <= 2.5 - record the status of this round in hit_or_not as 1
            % otherwise, record the status of this round in hit_or_not as -1
            if d <= 2.5
                hit_or_not(M) = 1;
            else
                hit_or_not(M) = -1;
            end

            % use hit_or_not to determine if there are consecutive failures of the test
            if M > 1
                if (hit_or_not(M - 1) == -1 ...
                        && hit_or_not(M) == hit_or_not(M - 1))
                    disp('When the error is:');
                    disp(err);
                    disp("I should stop the simulation since there are consecutive failures.");
                    disp(" ");
                    flag = false;
                end
            end
            % update M
            M = M + 1;
        end
%         disp(hit_or_not);
        % update the scalor
        scalor = scalor + 1;
    end
end

%% Test for Q9
function Test_GenerateOrthonormalFrame()
    % test#1
    a1 = [0 0 0];
    b1 = [1 0 0];
    c1 = [0 1 0];
    [Oe1, base_v1] = generate_orthonormal_frame(a1, b1, c1);
    disp("Oe:");
    disp(Oe1);
    disp("The base vectors are:");
    disp(base_v1);
    % test#2
    a2 = [0 1 0];
    b2 = [1 1 0];
    c2 = [0 1 1];
    [Oe2, base_v2] = generate_orthonormal_frame(a2, b2, c2);
    disp("Oe:");
    disp(Oe2);
    disp("The base vectors are:");
    disp(base_v2);
    % test#3
    a3 = [0 0 0];
    b3 = [1 1 1];
    c3 = [3 3 3];
    [Oe3, base_v3] = generate_orthonormal_frame(a3, b3, c3);
    disp("Oe:");
    disp(Oe3);
    disp("The base vectors are:");
    disp(base_v3);
end
%% Test for Q10
function Test_RotationAboutFrameAxis()
    % test#1 - x-axis
    axis1 = 'x';
    angle1 = 90;
    disp('Rotation is around:');
    disp(axis1);
    disp(" ");
    disp('The angle is:');
    disp(angle1);
    [rm1, h_rm1] = rotation_about_frame_axis(axis1, angle1);
    disp("The rotation matrix is: ");
    disp(rm1);
    disp("The homogeneous rotation matrix is: ");
    disp(h_rm1);
    disp(" ");
    % test#2 - y-axis
    axis2 = 'y';
    angle2 = 90;
    disp('Rotation is around:');
    disp(axis2);
    disp(" ");
    disp('The angle is:');
    disp(angle2);
    [rm2, h_rm2] = rotation_about_frame_axis(axis2, angle2);
    disp("The rotation matrix is: ");
    disp(rm2);
    disp("The homogeneous rotation matrix is: ");
    disp(h_rm2);
    disp(" ");
    % test#3 - z-axis
    axis3 = 'z';
    angle3 = 45;
    disp('Rotation is around:');
    disp(axis3);
    disp(" ");
    disp('The angle is:');
    disp(angle3);
    [rm3, h_rm3] = rotation_about_frame_axis(axis3, angle3);
    disp("The rotation matrix is: ");
    disp(rm3);
    disp("The homogeneous rotation matrix is: ");
    disp(h_rm3);
    disp(" ");
end

%% Test for Q11
function Test_frame_transformation_to_home()
    % test#1 - pure translation
    Ov1 = [1/3 4/3 1/3];
    base_v1 = [
                [1 2 0]
                [0 3 0]
                [0 2 1]
                ];
    [hm1] =  frame_transformation_to_home(Ov1, base_v1);
    disp("The homogeneous matrix is:");
    disp(hm1);
    a = hm1 * [0 3 0 1]'
%     % test#2 - pure translation
%     Ov2 = [0 0 0];
%     base_v2 = [
%                 [-1 -3 -4]
%                 [-2 -2 -4]
%                 [-2 -3 -3]
%                 ];
%     [hm2] =  frame_transformation_to_home(Ov2, base_v2);
%     disp("The homogeneous matrix is:");
%     disp(hm2);
%     a2 = hm2 * [-1 -3 -4 1]';
%     % test#3 - pure rotation
%     Ov3 = [0 0 0];
%     base_v3 = [
%                 [sqrt(2)/2 -sqrt(2)/2   0]
%                 [sqrt(2)/2 sqrt(2)/2  0]
%                 [    0          0      1]
%                 ];
%     [hm3] =  frame_transformation_to_home(Ov3, base_v3);
%     disp("The homogeneous matrix is:");
%     disp(hm3);
%     a3 = hm3 * [sqrt(2)/2 -sqrt(2)/2 0 1]'
%     % test#4 - pure rotation
%     Ov4 = [0 0 0];
%     base_v4 = [
%                 [sqrt(2)/2 sqrt(2)/2   0]
%                 [-sqrt(2)/2 sqrt(2)/2  0]
%                 [    0          0      1]
%                 ];
%     [hm4] =  frame_transformation_to_home(Ov4, base_v4);
%     disp("The homogeneous matrix is:");
%     disp(hm4);
%     % test#5 - rotation and transaltion
%     Ov5 = [3 2 3];
%     base_v5 = [
%                 [ sqrt(2)/2+3  sqrt(2)/2+2  3]
%                 [-sqrt(2)/2+3  sqrt(2)/2+2  3]
%                 [     3            2        4]
%                 ];
%     [hm5] =  frame_transformation_to_home(Ov5, base_v5);
%     disp("The homogeneous matrix is:");
%     disp(hm5);
%     % test#6 - rotation and transaltion
%     Ov6 = [-1 3 -2];
%     base_v6 = [
%                 [sqrt(2)/2-1  -sqrt(2)/2+3  -2]
%                 [sqrt(2)/2-1   sqrt(2)/2+3  -2]
%                 [     -1            3       -1]
%                 ];
%     [hm6] =  frame_transformation_to_home(Ov6, base_v6);
%     disp("The homogeneous matrix is:");
%     disp(hm6);
end













