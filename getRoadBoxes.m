% Algorithmically find patches of road and not road, using the road and not
% road pixels calculated from the ground truth
% Implemented bu 

function [roadBox, notroadBox] = getRoadBoxes(imname);

%Size of sample patches
boxsize = 50;

%Get the road and not road matrices
[road, notRoad] = getRoad(imname);

%Find the pixels where the road and not-road lie
[roadpxrow, roadpxcol] = find(road == 255);
[notRoadpxrow, notRoadpxcol] = find(road == 0);

%Get the medians for those pixels
rowMedian = round(median(roadpxrow(:)));
colMedian = round(median(roadpxcol(:)));

notroadrowMedian = round(median(notRoadpxrow(:)));
notroadcolMedian = round(median(notRoadpxcol(:)));

%i acts as our shift offset, we start off in the median, and shift
% up and to the left searching for boxes that are entirely road or not road

for i=0:10:50
    %Median's for road might be top left pixel, or bottom right pixel
    % Check for bounds error and offset appropriately 
    if(rowMedian < 50)
       rowMedian = rowMedian + 50;
    elseif(rowMedian + boxsize > size(road,1))
      rowMedian = rowMedian - 50;
    end
    
    if(colMedian < 50)
        colMedian = colMedian + 50;
    elseif(colMedian + boxsize < size(road, 2))
        colMedian = colMedian - 50;

    end
    
    %Get the bounding box corners (top left and bottom right)
    roadtopleft = road(rowMedian-i, colMedian-i);
    roadbottomright = road(rowMedian - i + boxsize, colMedian - i + boxsize);
    
    %Check to see if both corners are on the road
    if (roadtopleft == 255 && roadbottomright == 255)
       %We have a box that contains road
       
       roadBox = [rowMedian-i, colMedian-i, rowMedian-i+boxsize, colMedian-i+boxsize];
    end
    
    %Median's for not road might be top left pixel, or bottom right pixel
    % Check for bounds error and offset appropriately 
    if(notroadrowMedian < 50)
       notroadrowMedian = notroadrowMedian + 50;
    elseif(notroadrowMedian + boxsize > size(road,1))
      notroadrowMedian = notroadrowMedian - 50;
    end
    
    if(notroadcolMedian < 50)
        notroadcolMedian = notroadcolMedian + 50;
    elseif(notroadcolMedian + boxsize < size(road, 2))
        notroadcolMedian = notroadcolMedian - 50;

    end
    
    %Get the bounding box corners (top left and bottom right)
    notRoadtopleft = notRoad(notroadrowMedian - i, notroadcolMedian - i);
    notRoadbottomright = notRoad(notroadrowMedian - i + boxsize, notroadcolMedian - i + boxsize);
    
    %Check to see if both corners are not on the road
    if(notRoadtopleft == 1 && notRoadbottomright == 1)
        %We have a box that contains not road
        
       notroadBox =  [notroadrowMedian-i, notroadcolMedian-i, notroadrowMedian-i+boxsize, notroadcolMedian-i+boxsize];
    end
end

