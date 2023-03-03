% Q9: Compute Point Dose from Beam

function point_dose_value = Compute_Point_Dose_from_Beam(point_of_interest, beam_index)
% Input:
%       point_of_interest: an arbitrary point of interest
%       beam_index: the index of the pencil beam
% Output:
%       point_dose_value: the dose at a point of interest from a beam

global D_0
global HEAD_B;
max_d = HEAD_B * 2;
resolution = 1;

% get two tables to be used
DAF_table = Compute_Depth_Dose(resolution, max_d);
RDF_table = Compute_Radial_Dose(resolution);

% find "d"
d = round(Compute_Depth_from_Skin(point_of_interest, beam_index));
% find "r"
r = round(Compute_Radial_Distance(point_of_interest, beam_index));

% Get the corresponding values in the tables
% since DAF_table is a matrix and the index starts from '1',
% but d might be rounded down to 0,
% we will add 1 to d to prevent from that case happening.
DAF = DAF_table(d + 1, 2);
% values of the left column of RDF_table starts from -23, therefore we will
% add 24 to r.
if (r <= 23)
    RDF = RDF_table(r + 24, 2);
else
    RDF = 0;
end % end if-statement

% disp("DAF:");
% disp(DAF);
% disp("RDF:");
% disp(RDF);
% compute the value of the dose at a point of interest from a beam
point_dose_value = D_0 * DAF * RDF;

end % end the function