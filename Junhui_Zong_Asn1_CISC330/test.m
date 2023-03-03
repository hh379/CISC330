h1 = [1 0 0 1];
h2 = [0 1 0 1];
h3 = [0 0 1 1];
h4 = [0 0 0 2];

[~, h_rm] = rotation_about_frame_axis('z', 45);
v1 = h1 * h_rm;
v2 = h2 * h_rm;
v3 = h3 * h_rm;

H = [h1; h2; h3; h4]
H = H'
