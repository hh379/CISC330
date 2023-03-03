% This function is to compute the dose box 
% properly covers the PTV and OAR

function dose_box = Compute_Dose_Box(ptv_radius, ptv_center, oar_a, oar_b, oar_c, oar_center)
% INPUT:
%       ptv_rad: radius of PTV sphere
%       ptv_ctr: centre of PTV sphere
%       oar_a, oar_b, oar_c: three half lengths of OAR ellipsoid
%       oar_ctr - centre of OAR ellipsoid
% OUTPUT:
%       dose_box - the computed dose box defined by two opposite corner
%       points

% calculate all possible min and max x,y,z values for PTV and OAR
% so that we can define how big the box is
DOSE_X = [ptv_center(1) - ptv_radius; ptv_center(1) + ptv_radius; oar_center(1) - oar_a; oar_center(1) + oar_a];
DOSE_Y = [ptv_center(2) - ptv_radius; ptv_center(2) + ptv_radius; oar_center(2) - oar_b; oar_center(2) + oar_b];
DOSE_Z = [ptv_center(3) - ptv_radius; ptv_center(3) + ptv_radius; oar_center(3) - oar_c; oar_center(3) + oar_c];

% find min and max of each to compute the box
dose_box = [min(DOSE_X), min(DOSE_Y), min(DOSE_Z), max(DOSE_X), max(DOSE_Y), max(DOSE_Z)];

end