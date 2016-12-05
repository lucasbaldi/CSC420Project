%computing depth - done by Cong Hua Chen
globals;
list = getData('', 'list');
list = list.ids;

for i=1:size(list,1)
    imname = list{i};
    [depth, normDepth] = calculateDepth(imname);
    %save([RESULTS_DIR, '/disparity/',list{i}],'disp_map');
end