function test;

globals;
list = getData('', 'testlist');
list = list.ids;
%list = cell2mat(list);
testlist = ['um_000000 ',
            'um_000021 ',
            'um_000032 '
            'um_000043 ',
            'um_000054 ',
            'uu_000000 ',
            'uu_000021 ',
            'uu_000032 ',
            'uu_000043 ',
            'uu_000054 ',
            'umm_000000',
            'umm_000021',
            'umm_000032',
            'umm_000043',
            'umm_000054'];
testlist =  cellstr(testlist);

for i=1:size(testlist,1)    
    imname = testlist{i};
    im = getData(imname,'left-test');
    im = im.im;
    if(i==4)
       figure; imshow(im); 
       classified = classify(imname);
       imwrite(classified, [RESULTS_DIR, '/', testlist{i}, '_classified.png']);
    end
    
    %save([REULTS_DIR, testlist{i},''
    %[xyz] = calculateWorldPosition(imname);
    %save([RESULTS_DIR, '/disparity/',list{i}],'disp_map');
end