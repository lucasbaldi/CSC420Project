function [depth, normDepth] = calculateDepth(imname);
%depth calculations done by Cong Hua Chen 
globals;
baseline = 0.54;
disparity = getData(imname, 'disparity');
disparity = disparity.disp;


[K2 R2 K3 R3] = getCameraMatrices(imname);
f1x = K2(1,1);
f1y = K3(2,2);
%depth = zeros(size(disparity,1), size(disparity,2));
depth = (f1x * baseline) ./ disparity;
depth(depth>300) = 300;
depth(depth<eps) = 0;


%depth(depth==300) = 0;

normDepth = depth./300;
%imwrite(depth, fullfile(DEPTH_DIR, sprintf('%s.png', imname) ) );
save(fullfile(DEPTH_DIR, sprintf('%s', imname)), 'depth');
