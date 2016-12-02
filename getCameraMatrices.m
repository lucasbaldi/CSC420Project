function [K2 R2 K3 R3] = getCameraMatrices(imname);

globals;

data = getData(imname, 'calib');
calibCell = str2double(data.ids);
% Hardcoded cell entries for camera matrices P2 and P3
% Which represent the Left and Right colour cameras respectively
calib2 = calibCell(28:39);
calib3 = calibCell(41:52);


P2 = [calib2(1:4)'; calib2(5:8)'; calib2(9:12)'];
P3 = [calib3(1:4)'; calib3(5:8)'; calib3(9:12)'];

[K2 R2] = cameraMatrixDecompose(P2);

[K3 R3] = cameraMatrixDecompose(P3);


% k3 = K3(:,2:4);


% make diagonal of K2 positive
% T2 = diag(sign(diag(k2)));
% 
% K2 = k2 * T2
% R2 = [T2 zeros(3,1);zeros(1,4)] * R2 % (T is its own inverse)