function [road, notRoad] = getRoad(imname);

gt = getData(imname, 'gt');
road = gt.groundTruth(:,:,3);

notRoad = zeros(size(road,1), size(road,2));
notRoad = notRoad + 255;
size(road);
size(notRoad);

notRoad = ~road;

% figure;
% imshow(road);
% figure;
% imshow(notRoad);