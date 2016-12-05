%Get the P Camera matrix from the training data calibration folder
% And decompose it into the k [R|T]matrices
% Implemented by Lucas Baldi

function [K2 R2 K3 R3] = getCameraMatrices(imname);

globals;

data = getData(imname, 'calib');
calibCell = str2double(data.ids);

% Hardcoded cell entries for camera matrices P2 and P3
% Which represent the Left and Right colour cameras respectively
calib2 = calibCell(28:39);
calib3 = calibCell(41:52);

%Format the data from the cells into a 3x4 matrix
P2 = [calib2(1:4)'; calib2(5:8)'; calib2(9:12)'];
P3 = [calib3(1:4)'; calib3(5:8)'; calib3(9:12)'];

%Decompose the P into k and [R|T] matrices
[K2 R2] = cameraMatrixDecompose(P2);
[K3 R3] = cameraMatrixDecompose(P3);
