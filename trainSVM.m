
function svmStruct = trainSVM;

    globals;
    list = getData('', 'list');
    list = list.ids;
    
    %Initialize data and group variables to be used in training
    data = zeros( (2*size(list,1)), 8);
    group = zeros(2*size(list,1),1);

    for i=1:size(list,1)
        imname = list{i}
        
        %Get the samples we find algorithmically
        [roadbox, notroadbox] = getRoadBoxes(imname);
        %roadbox = [topleftrow, topleftcol, bottomrightrow, bottomrightcol]
        topleftrow = roadbox(1);
        topleftcol = roadbox(2);
        bottomrightrow = roadbox(3);
        bottomrightcol = roadbox(4);

        %Get the image we are going to train on
        leftim = getData(imname, 'left');
        leftim = leftim.im;

        %Take the sample road patch from the image
        roadSection = leftim(topleftrow:bottomrightrow, topleftcol:bottomrightcol,:);
        
        %Caclulate the HSV colour values for the patch
        roadhsv = rgb2hsv(roadSection);
        
        %Calculate the grey level covariance matrix
        roadgrey = rgb2gray(roadSection);
        roadGLCM = graycomatrix(roadgrey);

        %Calculate the haralick featyre from the grey level covariance
        %matrix
        [haralick1 haralick2 haralick3 haralick4 haralick5] = haralick(roadGLCM);
        
        %Normalize the haralick features to be all from [0,1]
        haralicks = [haralick1 haralick2 haralick3 haralick4 haralick5];
        haralicks = haralicks./max(haralicks(:));
        
        %8 dimensional feature vector, 
        % first 3 are the hsv colour values at the middle of the box
        % last 5 are the first 5 haralick features of the 50x50 pixel
        % bounding box
        feature = [roadhsv(25, 25, 1) roadhsv(25, 25, 2) roadhsv(25, 25,3)  haralicks(1) haralicks(2) haralicks(3) haralicks(4) haralicks(5)];
        data(2*i-1,:) = feature;
        group(2*i-1) = 1;
        

        %notroadbox = [topleftrow, topleftcol, bottomrightrow, bottomrightcol]
        topleftrow = notroadbox(1);
        topleftcol = notroadbox(2);
        bottomrightrow = notroadbox(3);
        bottomrightcol = notroadbox(4);
    
        %take the sample not road patch from the image
        notRoadSection = leftim(topleftrow:bottomrightrow, topleftcol:bottomrightcol,:);
        
        %Calculate the HSV colour values for the patch
        notRoadhsv = rgb2hsv(notRoadSection);
        
        %Calculate the grey level covariance matrix
        notRoadgrey = rgb2gray(notRoadSection);
        notRoadGLCM = graycomatrix(notRoadgrey);
        
        %Calculate the haralick feature 
        [haralick1 haralick2 haralick3 haralick4 haralick5] = haralick(notRoadGLCM);
        
        %Normalize the haralick features to be all from [0,1]
        haralicks = [haralick1 haralick2 haralick3 haralick4 haralick5];
        haralicks = haralicks./max(haralicks(:));
        
        %8 dimensional feature vector, 
        % first 3 are the hsv colour values at the middle of the box
        % last 5 are the first 5 haralick features of the 50x50 pixel
        % bounding box
        feature = [notRoadhsv(25, 25, 1) notRoadhsv(25, 25, 2) notRoadhsv(25, 25,3)  haralicks(1) haralicks(2) haralicks(3) haralicks(4) haralicks(5)];
        data(2*i,:) = feature;
        group(2*i) = 0;

        if(~roadbox)
            'missing roadbox'
        end
        if(~notroadbox)
            'missing notroadbox'
        end
    end
    
    %Save the svm struct for future use
    svmStruct = svmtrain(data, group, 'kernel_function','rbf');
    save(fullfile(RESULTS_DIR,'svmStruct.mat'), 'svmStruct');
    
end