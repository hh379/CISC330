% Q1: Draw 3D Scene

function Draw_3D_Scene()
% This function is to draw the 3D scene with Head, PTV, 
% OAR, isocenter, and the coordinate axes.
% INPUT:
%       None
% OUTPUT:
%       None

% declare some needed global variables 
global HEAD_CENTER;
global HEAD_A;
global HEAD_B;
global HEAD_C;
global PTV_RADIUS;
global PTV_CENTER;
global OAR_A;
global OAR_B;
global OAR_C;
global OAR_CENTER;
global DOSE_BOX;
DOSE_BOX = Compute_Dose_Box(PTV_RADIUS, PTV_CENTER, OAR_A, OAR_B, OAR_C, OAR_CENTER);

figure(1);

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
title("3D Scene")

% plot PTV sphere
X_PTV = X * PTV_RADIUS + PTV_CENTER(1);
Y_PTV = Y * PTV_RADIUS + PTV_CENTER(2);
Z_PTV = Z * PTV_RADIUS + PTV_CENTER(3);
% color of PTV
PTV_color = [0.4660 0.6740 0.1880];
% plot sphere
PTV_h = surf(X_PTV, Y_PTV, Z_PTV);
set(PTV_h, 'FaceAlpha', 0.2, 'EdgeColor', PTV_color, 'EdgeAlpha', 0.2);
text(PTV_CENTER(1), PTV_CENTER(2)-20, PTV_CENTER(3), "PTV");

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

% plot DOSE_BOX
% plot 12 edges between 8 points
A1 = DOSE_BOX(1:3);
A2 = DOSE_BOX(4:6);
plot3([A1(1), A1(1)],[A1(2), A2(2)],[A1(3), A1(3)], 'm');
plot3([A1(1), A1(1)],[A1(2), A1(2)],[A1(3), A2(3)], 'm');
plot3([A1(1), A2(1)],[A1(2), A1(2)],[A1(3), A1(3)], 'm');
plot3([A1(1), A1(1)],[A2(2), A2(2)],[A1(3), A2(3)], 'm');
plot3([A1(1), A1(1)],[A1(2), A2(2)],[A2(3), A2(3)], 'm');
plot3([A1(1), A2(1)],[A2(2), A2(2)],[A1(3), A1(3)], 'm');
plot3([A2(1), A2(1)],[A1(2), A2(2)],[A1(3), A1(3)], 'm');
plot3([A2(1), A2(1)],[A1(2), A1(2)],[A1(3), A2(3)], 'm');
plot3([A1(1), A2(1)],[A1(2), A1(2)],[A2(3), A2(3)], 'm');
plot3([A1(1), A2(1)],[A2(2), A2(2)],[A2(3), A2(3)], 'm');
plot3([A2(1), A2(1)],[A1(2), A2(2)],[A2(3), A2(3)], 'm');
plot3([A2(1), A2(1)],[A2(2), A2(2)],[A1(3), A2(3)], 'm');
text(A2(1), A2(2), A2(3), "DOSE BOX");

% plot ISOCENTER
plot3(PTV_CENTER(1), PTV_CENTER(2), PTV_CENTER(3), 'k.', 'MarkerSize', 15);
text(PTV_CENTER(1)+13,PTV_CENTER(2)+3, PTV_CENTER(3)+3, "ISOCENTER");

hold off;

end % end the function