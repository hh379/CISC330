function [transform] = FrameTransform(a1, b1, c1, a2, b2, c2)

% the orthonormal coordinate system for both triangles is calculated (the
% center of the coordinate system is the center of gravity of the triangle)
[ctr1, orth_v] = generate_orthonormal_frame(a1, b1, c1);
[ctr2, orth_e] = generate_orthonormal_frame(a2, b2, c2);

v1 = orth_v(1, :)';
v2 = orth_v(2, :)';
v3 = orth_v(3, :)';

e1 = orth_e(1, :)';
e2 = orth_e(2, :)';
e3 = orth_e(3, :)';

% procrustes is a built in function that is used to generate the rotation
% matrix from one set of base vectors [v1 v2 v3] to another [e1 e2 e3]
[~,~, trans] = procrustes([e1 e2 e3], [v1 v2 v3]);
rot = trans.T; % trans.T accesses the rotation matrix from the procrustes output
rotCtr1 = rot * ctr1'; % calculate the rotated center of the position 1 triangle
% the translation vector is the difference between the center point of the
% second orthonormal coordinate system and the rotated center point of the
% first orthonormal coordinate system
tlnVec = ctr2' - rotCtr1;
% make the 4x4 rotation matrix
rotMat = vertcat(horzcat(rot,[0;0;0]),[0,0,0,1]);
% make the 4x4 translation matrix
tlnMat = vertcat(horzcat(eye(3),tlnVec),[0,0,0,1]);

% transformation matrix = translation matrix(rotation matrix(scale matrix))
% scale matrix not used so just translation matrix * rotation matrix
transform = tlnMat*rotMat;
end
