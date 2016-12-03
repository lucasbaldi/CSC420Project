%[K2 R2 K3 R3] = getCameraMatrices('um_000000');

%baseline = 0.54;
function [roadBox, notroadBox] = getRoadBoxes(imname);

boxsize = 50;

[road, notRoad] = getRoad(imname);
[roadpxrow, roadpxcol] = find(road == 255);
[notRoadpxrow, notRoadpxcol] = find(road == 0);

rowMedian = median(roadpxrow(:));
colMedian = median(roadpxcol(:));

notroadrowMedian = median(notRoadpxrow(:));
notroadcolMedian = median(notRoadpxcol(:));
notRoad(:);
for i=0:10:50
    
    roadtopleft = road(rowMedian-i, colMedian-i);
    roadbottomright = road(rowMedian - i + boxsize, colMedian - i + boxsize);
    
    if (roadtopleft == 255 && roadbottomright == 255)
       %We have a box that contains road
       
       roadBox = [rowMedian-i, colMedian-i, rowMedian-i+boxsize, colMedian-i+boxsize];
    end
    
    %Median's for not road might be top left pixel, or bottom right pixel
    % Check for bounds error and offset appropriately 
    % I don't do this for road because road is more likely to be in the
    % middle of the image
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
    
    notRoadtopleft = notRoad(notroadrowMedian - i, notroadcolMedian - i);
    notRoadbottomright = notRoad(notroadrowMedian - i + boxsize, notroadcolMedian - i + boxsize);
    
    if(notRoadtopleft == 1 && notRoadbottomright == 1)
        %We have a box that contains not road
        
       notroadBox =  [notroadrowMedian-i, notroadcolMedian-i, notroadrowMedian-i+boxsize, notroadcolMedian-i+boxsize];
    end
end

