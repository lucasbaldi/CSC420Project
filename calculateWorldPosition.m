function [xyz] = calculateWorldPosition(imname);
%world coordinate calculations done by Cong Hua Chen 
%x = (f*X)/Z + px
global1s;

%x - px = f(*X)/Z
%Z(x - px) = f*X

%X = (Z(x - px))/f

data = getData(imname, 'depth');
depth = data.depth;
depth = depth.depth;

[K2 R2 K3 R3] = getCameraMatrices(imname);
f1x = K2(1,1);
f1y = K2(2,2);
px = round(K2(1,3));
py = round(K2(2,3));

[x, y] = meshgrid(1:size(depth, 2), size(depth, 1):-1:1);

X = (depth .*(x-px))./f1x;
Y = (depth .*(y-py))./f1y;

xyz = zeros(size(depth, 1), size(depth, 2), 3);
xyz(:,:,1) = X;
xyz(:,:,2) = Y;
xyz(:,:,3) = depth;
save(fullfile(LOC_DIR, sprintf('%s', imname)), 'xyz');
