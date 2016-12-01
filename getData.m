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
end;