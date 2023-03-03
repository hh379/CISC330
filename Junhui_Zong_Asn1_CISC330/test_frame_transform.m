% % test#1 - pure translation
% Ov1 = [1/3 4/3 1/3];
% base_v1 = [
%             [1 2 0]
%             [0 3 0]
%             [0 2 1]
%             ];
% [hm1] =  frame_transformation_to_home(Ov1, base_v1);
% disp("The homogeneous matrix is:");
% disp(hm1);
% a = hm1 * [0 3 0 1]';
% % test#2 - pure translation
% Ov2 = [0 0 0];
% base_v2 = [
%             [-1 -3 -4]
%             [-2 -2 -4]
%             [-2 -3 -3]
%             ];
% [hm2] =  frame_transformation_to_home(Ov2, base_v2);
% disp("The homogeneous matrix is:");
% disp(hm2);
% a2 = hm2 * [-1 -3 -4 1]';
% % test#3 - pure rotation
% Ov3 = [0 0 0];
% base_v3 = [
%             [sqrt(2)/2 -sqrt(2)/2   0]
%             [sqrt(2)/2 sqrt(2)/2  0]
%             [    0          0      1]
%             ];
% [hm3] =  frame_transformation_to_home(Ov3, base_v3);
% disp("The homogeneous matrix is:");
% disp(hm3);
% a3 = hm3 * [sqrt(2)/2 -sqrt(2)/2 0 1]';
% test#4 - pure rotation
Ov4 = [0 0 0];
base_v4 = [
            [sqrt(2)/2 sqrt(2)/2   0]
            [-sqrt(2)/2 sqrt(2)/2  0]
            [    0          0      1]
            ];
[hm4] =  frame_transformation_to_home(Ov4, base_v4);
disp("The homogeneous matrix is:");
disp(hm4);
a4 = hm4 * [sqrt(2)/2 sqrt(2)/2 0 1]';
% % test#5 - rotation and transaltion
% Ov5 = [3 2 3];
% base_v5 = [
%             [ sqrt(2)/2+3  sqrt(2)/2+2  3]
%             [-sqrt(2)/2+3  sqrt(2)/2+2  3]
%             [     3            2        4]
%             ];
% [hm5] =  frame_transformation_to_home(Ov5, base_v5);
% disp("The homogeneous matrix is:");
% disp(hm5);
% % test#6 - rotation and transaltion
% Ov6 = [-1 3 -2];
% base_v6 = [
%             [sqrt(2)/2-1  -sqrt(2)/2+3  -2]
%             [sqrt(2)/2-1   sqrt(2)/2+3  -2]
%             [     -1            3       -1]
%             ];
% [hm6] =  frame_transformation_to_home(Ov6, base_v6);
% disp("The homogeneous matrix is:");
% disp(hm6);