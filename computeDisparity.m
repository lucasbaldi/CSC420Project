globals;
list = getData('', 'list');
list = list.ids;

for i=1:size(list,1)
    imname = list{i};
    disp_map = StereoDisparityMap(imname);
    save(['./results/disparity/',list{i}],'disp_map');
end