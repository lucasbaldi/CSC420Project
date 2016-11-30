im_left = getData('um_000000', 'left');
im_right = getData('um_000000', 'right');
im_left = im_left.im;
im_right = im_right.im;

disp_map = StereoDisp(im_left, im_right);
imshow(disp_map);