function disp_map = StereoDisparityMap(imName);
im_left = getData(imName, 'left');
im_right = getData(imName, 'right');
im_left = rgb2gray(im_left.im);
im_right = rgb2gray(im_right.im);

disp_map = disparity(im_left, im_right);
disp_map = disp_map/max(disp_map(:));
disp_map = imfill(disp_map);