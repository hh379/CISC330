% Q12: Compute Surface Dose on OAR

function Compute_Surface_Dose_OAR()
% This function is to compute the dose on the surface of OAR.
% INPUT:
%       None
% OUTPUT:
%       None

global OAR_A;
global OAR_B;
global OAR_C;
global OAR_CENTER;

d = OAR_A * 2;
[X, Y, Z] = sphere(d);
X = X * OAR_A + OAR_CENTER(1); 
Y = Y * OAR_B + OAR_CENTER(2); 
Z = Z * OAR_C + OAR_CENTER(3); 

hottest_dose = [0 0 0 0];
% select a value that is big enough
coldest_dose = [0 0 0 100];
% initialize a matrix to store the value of color
C = zeros(d+1, d+1);
% compute surface patches
for i = 1:(d+1)
    for j = 1:(d+1)
        p_interest = [X(i, j), Y(i, j), Z(i, j)];
        % compute dose in surface points
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
text(hottest_dose(1)+5, hottest_dose(2), hottest_dose(3), sprintf("hottest point: %.2f", hottest_dose(4)));
plot3(coldest_dose(1), coldest_dose(2), coldest_dose(3), 'b.', 'MarkerSize', 15);
text(coldest_dose(1)+2, coldest_dose(2), coldest_dose(3), sprintf("coldest point: %.2f", coldest_dose(4)));
hold off

% print the result
fprintf("The hottest point is at [%.0f %.0f %.0f] and receives dose of %.2f.\n", hottest_dose(1), hottest_dose(2), hottest_dose(3), hottest_dose(4));
fprintf("The coldest point is at [%.0f %.0f %.0f] and receives dose of %.2f.\n", coldest_dose(1), coldest_dose(2), coldest_dose(3), coldest_dose(4));

end % end the function