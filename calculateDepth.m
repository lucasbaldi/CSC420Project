function depth = calculateDepth(imname);
baseline = 0.54;
% disparity = getData(imname, 'disparity');
disparity = StereoDisparityMap(imname);
figure;
imshow(disparity);
title('un-normalized disparity');
[K2 R2 K3 R3] = getCameraMatrices(imname)
f1x = K2(2,2);
f2x = K3(2,2);

depth = (f1x * baseline) ./ disparity;
depth(depth==inf) = 591;
depth(depth<eps) = 0;


%depth(depth==300) = 0;

normDepth = depth./591;

'mean'
mean(normDepth(:))

figure;
imshow(normDepth);
title('normDepth');

figure;
imshow(depth);
title('depth');

'max'
max(normDepth(:))