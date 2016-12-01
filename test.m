globals;
data = getData('um_000000', 'calib');
calibCell = str2double(data.ids)
calib = calibCell(15:26)

P = [calib(1:4) calib(5:8) calib(9:12)] 