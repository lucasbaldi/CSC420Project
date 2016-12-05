function postProcess;

globals;

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

%for i=1:size(testlist,1)  
    imname = %testlist(i);
    data = getData(char(imname),'classified');
    im = data.classified;
    figure;imshow(im);
    conv = imgaussfilt(im, 4);
    conv(conv<200) = 0;
    %figure;imshow(conv);
    [RESULTS_DIR, '/', imname, '_classified_thresholded.png']
    imwrite(conv, fullfile(RESULTS_DIR, sprintf( '%s_classified_thresholded.png', char(imname))));

%end