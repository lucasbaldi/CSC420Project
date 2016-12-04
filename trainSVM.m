
function svmStruct = trainSVM;

    globals;
    list = getData('', 'list');
    list = list.ids;
    data = zeros( (2*size(list,1)), 8);
    group = zeros(2*size(list,1),1);

    for i=1:size(list,1)
        imname = list{i}
        [roadbox, notroadbox] = getRoadBoxes(imname);
        %roadbox = [topleftrow, topleftcol, bottomrightrow, bottomrightcol]
        topleftrow = roadbox(1);
        topleftcol = roadbox(2);
        bottomrightrow = roadbox(3);
        bottomrightcol = roadbox(4);

        leftim = getData(imname, 'left');
        leftim = leftim.im;

        roadSection = leftim(topleftrow:bottomrightrow, topleftcol:bottomrightcol,:);
        roadhsv = rgb2hsv(roadSection);
        roadgrey = rgb2gray(roadSection);
        roadGLCM = graycomatrix(roadgrey);

    
        
        
        [haralick1 haralick2 haralick3 haralick4 haralick5] = haralick(roadGLCM);
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

        notRoadSection = leftim(topleftrow:bottomrightrow, topleftcol:bottomrightcol,:);
        notRoadhsv = rgb2hsv(notRoadSection);
        notRoadgrey = rgb2gray(notRoadSection);
        notRoadGLCM = graycomatrix(notRoadgrey);

         
        [haralick1 haralick2 haralick3 haralick4 haralick5] = haralick(notRoadGLCM);
        haralicks = [haralick1 haralick2 haralick3 haralick4 haralick5];
        haralicks = haralicks./max(haralicks(:));
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
    group
    svmStruct = svmtrain(data, group, 'kernel_function','rbf');
    save(fullfile(RESULTS_DIR,'svmStruct.mat'), 'svmStruct');
    
end

function p_x = px(i, glcm);
    p_x = 0; 
    for j=1:size(glcm, 1)
       p_x = p_x + glcm(i,j);
    end
end

function p_y = py(j, glcm);
    p_y = 0; 
    for i=1:size(glcm, 1)
       p_y = p_y + glcm(i,j);
    end
end
