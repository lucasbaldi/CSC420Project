function data = getData(imname, whatdata)
globals;
data = [];

switch whatdata
    case {'right'}
        imfile = fullfile(RIGHT_DATA_DIR, sprintf('%s.png', imname));
        im = imread(imfile);
        data.im = im;
    case {'left'}
        imfile = fullfile(LEFT_DATA_DIR, sprintf('%s.png', imname));
        im = imread(imfile);
        data.im = im;
    case{'left-test'}
        imfile = fullfile(LEFT_TEST_DIR, sprintf('%s.png', imname));
        im = imread(imfile);
        data.im = im;
    case{'right-test'}
        imfile = fullfile(RIGHT_TEST_DIR, sprintf('%s.png', imname));
        im = imread(imfile);
        data.im = im;
    case {'calib'}
        fid = fopen(fullfile(CALIB_DATA_DIR, [imname '.txt']), 'r+');
        ids = textscan(fid, '%s');
        ids = ids{1};
        fclose(fid);
        data.ids = ids;
    case{'list'}
        fid = fopen('list.txt');
        ids = textscan(fid, '%s');
        ids = ids{1};
        fclose(fid);
        data.ids = ids;
    case{'testlist'}
        fid = fopen('testlist.txt');
        ids = textscan(fid, '%s');
        ids = ids{1};
        fclose(fid);
        data.ids = ids;
    case{'disparity'}
        %disparity = load(fullfile(RESULTS_DIR,'/disparity/', sprintf('%s.mat', imname)));
        disparity = imread(fullfile(DISPARITY_DIR, sprintf('%s_left_disparity.png',imname)));
        disparity = double(disparity)/256;
        data.disp = disparity;
    case{'depth'}
        %depth = imread(fullfile(DEPTH_DIR, sprintf('%s.png', imname)));
        depth = load(fullfile(DEPTH_DIR, sprintf('%s',imname)));
        data.depth = depth.depth;
    case{'location'}
        location = load(fullfile(LOC_DIR, sprintf('%s',imname)));
        data.location = location;
    case{'gt'}
        [prefix, number] = strtok(imname,'0');
        %imnum = strrep(strrep(strrep(txt, 'umm_',''),'uu_',''), 'um_','');
        groundTruth = imread(fullfile(GT_DATA_DIR, sprintf('%sroad_%s.png',prefix, number)));
        data.groundTruth = groundTruth;
    case{'classifier'}
        classifier = load(fullfile(RESULTS_DIR, 'svmStruct.mat'));
        data.classifier = classifier.svmStruct;
    case{'classified'}
        classified = imread(fullfile(RESULTS_DIR, sprintf('%s_classified.png',imname)));
        data.classified = classified;
end;