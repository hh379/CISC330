% Ground truth test 1: pure translation
a11 = [1 0 0];
b11 = [0 2 0];
c11 = [0 0 1];

% The fiducial markers are translated +1 in the z direction
a12 = [1 0 1];
b12 = [0 2 1];
c12 = [0 0 2];
% The resulting 1-by-4 matrix will be added to the first row of the 
% results matrix for this test case (resultsT)
[transform1] = frame(a11,b11,c11,a12,b12,c12);
disp(transform1);