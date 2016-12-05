%Using SPS stereo to create disparity images
%done by Cong Hua Chen
globals;
list = getData('', 'list');
list = list.ids;

for i=1:size(list,1)
    imname = list{i};
    disp_map = StereoDisparityMap(imname);
    save([RESULTS_DIR, '/disparity/',list{i}],'disp_map');
end