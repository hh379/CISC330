% Q11: Compute Surface Dose on PTV

function Compute_Surface_Dose_PTV()
% This function is to compute the dose on the surface of PTV.
% INPUT:
%       None
% OUTPUT:
%       None

global PTV_RADIUS;
global PTV_CENTER;
global D_0;

d = PTV_RADIUS * 2;
[X, Y, Z] = sphere(d);
X = X * PTV_RADIUS + PTV_CENTER(1); 
Y = Y * PTV_RADIUS + PTV_CENTER(2); 
Z = Z * PTV_RADIUS + PTV_CENTER(3); 
beam_structure_arr = Compute_Skin_Entry_Points();
[N, ~] = size(beam_structure_arr);

hottest_dose = [0 0 0 0];
% select a value that is big enough
coldest_dose = [0 0 0 N * D_0];
% initialize a matrix to store the value of color
C = zeros(d+1, d+1);
% compute surface patches
for i = 1:(d+1)
    for j = 1:(d+1)
        p_interest = [X(i, j), Y(i, j), Z(i, j)];
        % compute dose in surface point
        C(i, j) = Compute_Point_Dose_from_All_Beams(p_interest);
        % find the hottest point
        if C(i, j) > hottest_dose(4)
            hottest_dose = [X(i, j), Y(i, j), Z(i, j) C(i, j)];
        end % end if-statement
        % find the coldest point
        if C(i, j) < coldest_dose(4)
            coldest_dose = [X(i, j), Y(i, j), Z(i, j) C(i, j)];
        end % end if-statement
    end % end inner for-loop
end % end outer for-loop

% plot the surface dose
surf(X, Y, Z, C);
axis equal
hold on
% colormap turbo;
shading interp
xlabel("X-axis")
ylabel("Y-axis")
zlabel("Z-axis")
title("PTV Surface Dose")
colorbar
% plot the hottest and the coldest points
plot3(hottest_dose(1), hottest_dose(2), hottest_dose(3), 'r.', 'MarkerSize', 15);
text(hottest_dose(1)-4, hottest_dose(2), hottest_dose(3)+3, sprintf("hottest point: %.2f", hottest_dose(4)));
plot3(coldest_dose(1), coldest_dose(2), coldest_dose(3), 'b.', 'MarkerSize', 15);
text(coldest_dose(1)+0.5, coldest_dose(2), coldest_dose(3), sprintf("coldest point: %.2f", coldest_dose(4)));
hold off

% print the result
fprintf("The hottest point is at [%.0f %.0f %.0f] and receives dose of %.2f.\n", hottest_dose(1), hottest_dose(2), hottest_dose(3), hottest_dose(4));
fprintf("The coldest point is at [%.0f %.0f %.0f] and receives dose of %.2f.\n", coldest_dose(1), coldest_dose(2), coldest_dose(3), coldest_dose(4));

end % end the function