% Create a matrix to signifiy the road pixels vs not road pixels in the
% training image, calculated from the ground truth
% implemented by Lucas Baldi
function [road, notRoad] = getRoad(imname);

%Load the ground truth from the training set
gt = getData(imname, 'gt');
%Third channel is all 255 where the road is
road = gt.groundTruth(:,:,3);

%Not road is negation of road
notRoad = ~road;
