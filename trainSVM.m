
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
        roadhsv = rgb2hsv(roadSection./256);
        roadgrey = rgb2gray(roadSection);
        roadGLCM = graycomatrix(roadgrey);

        greyVals = unique(roadGLCM);
        %To compute the first 5 haralick features we need
        %p_x(i) p_y(i) (helper function below)
        %mu, mu_x, mu_y
        %sig_x sig_y

        
        mu_x = 0;
        for i=1:size(roadGLCM,1)
            mu_x = mu_x + i * px(i, roadGLCM);
        end
        
        mu_y = 0;
        for i=1:size(roadGLCM,1)
            mu_y = mu_y + i * py(i, roadGLCM);
        end
        
        mu = (mu_x + mu_y)/2;
        
        sig_x = 0;
        for i=1:size(roadGLCM,1)
            sig_x = sig_x + (px(i, roadGLCM) * (i-mu_x)^2);
        end
        sig_x = sqrt(sig_x);
        
        sig_y = 0;
        for i=1:size(roadGLCM,1)
            sig_y = sig_y + (py(i, roadGLCM) * (i-mu_y)^2);
        end
        sig_y = sqrt(sig_y);
        
        %Haralick features expressed as functions
        %http://journals.tubitak.gov.tr/elektrik/issues/elk-11-19-1/elk-19-1-8-0906-27.pdf
        
        haralick1 = sum(roadGLCM(:).^2);
        
        haralick2 = 0;
        for n=0:(size(roadGLCM,1)-1)
           inner = 0;
           for i=1:size(roadGLCM,1)
               for j=1:size(roadGLCM,1)
                  if(abs(i-j) == n)
                      inner = roadGLCM(i,j);
                      
                  end
               end
           end
           haralick2 = haralick2 + (n^2 * inner);
        end

        haralick3 = 0;
        
        for i=1:size(roadGLCM,1)
            for j=1:size(roadGLCM,1)
                
                inner = ((i-mu_x)*(i - mu_y)*roadGLCM(i,j)) / (sig_x * sig_y);
                haralick3 = haralick3 + inner;
            end
        end
        
        haralick4 = 0;
        for i=1:size(roadGLCM,1)
            for j=1:size(roadGLCM,1)
                haralick4 = haralick4 + ((i-mu)^2 * roadGLCM(i,j));
            end
        end
        
        haralick5 = 0;
        for i=1:size(roadGLCM,1)
            for j=1:size(roadGLCM,1)
                inner = (1/(1+(i-j)^2)) * roadGLCM(i,j); 
                haralick5 = haralick5 + inner;
                
            end
        end
        
        %8 dimensional feature vector, 
        % first 3 are the hsv colour values at the middle of the box
        % last 5 are the first 5 haralick features of the 50x50 pixel
        % bounding box
        feature = [roadhsv(25, 25, 1) roadhsv(25, 25, 2) roadhsv(25, 25,3)  haralick1 haralick2 haralick3 haralick4 haralick5];
        data(2*i-1,:) = feature;
        group(2*i-1) = 1;
        

        %notroadbox = [topleftrow, topleftcol, bottomrightrow, bottomrightcol]
        topleftrow = notroadbox(1);
        topleftcol = notroadbox(2);
        bottomrightrow = notroadbox(3);
        bottomrightcol = notroadbox(4);

        notRoadSection = leftim(topleftrow:bottomrightrow, topleftcol:bottomrightcol,:);
        notRoadhsv = rgb2hsv(notRoadSection./256);
        notRoadgrey = rgb2gray(notRoadSection);
        notRoadGLCM = graycomatrix(notRoadgrey);
        
         
        mu_x = 0;
        for i=1:size(notRoadGLCM,1)
            mu_x = mu_x + i * px(i, notRoadGLCM);
        end
        
        mu_y = 0;
        for i=1:size(notRoadGLCM,1)
            mu_y = mu_y + i * py(i, notRoadGLCM);
        end
        
        mu = (mu_x + mu_y)/2;
        
        sig_x = 0;
        for i=1:size(notRoadGLCM,1)
            sig_x = sig_x + (px(i, notRoadGLCM) * (i-mu_x)^2);
        end
        sig_x = sqrt(sig_x);
        
        sig_y = 0;
        for i=1:size(notRoadGLCM,1)
            sig_y = sig_y + (py(i, notRoadGLCM) * (i-mu_y)^2);
        end
        sig_y = sqrt(sig_y);
        
        %Haralick features expressed as functions
        %http://journals.tubitak.gov.tr/elektrik/issues/elk-11-19-1/elk-19-1-8-0906-27.pdf
        
        haralick1 = sum(notRoadGLCM(:).^2);
        
        haralick2 = 0;
        for n=0:(size(notRoadGLCM,1)-1)
           inner = 0;
           for i=1:size(notRoadGLCM,1)
               for j=1:size(notRoadGLCM,1)
                  if(abs(i-j) == n)
                      inner = notRoadGLCM(i,j);
                      
                  end
               end
           end
           haralick2 = haralick2 + (n^2 * inner);
        end

        haralick3 = 0;
        
        for i=1:size(notRoadGLCM,1)
            for j=1:size(notRoadGLCM,1)
                
                inner = ((i-mu_x)*(i - mu_y)*notRoadGLCM(i,j)) / (sig_x * sig_y);
                haralick3 = haralick3 + inner;
            end
        end
        
        haralick4 = 0;
        for i=1:size(notRoadGLCM,1)
            for j=1:size(notRoadGLCM,1)
                haralick4 = haralick4 + ((i-mu)^2 * notRoadGLCM(i,j));
            end
        end
        
        haralick5 = 0;
        for i=1:size(notRoadGLCM,1)
            for j=1:size(notRoadGLCM,1)
                inner = (1/(1+(i-j)^2)) * notRoadGLCM(i,j); 
                haralick5 = haralick5 + inner;     
            end
        end
        
        feature = [notRoadhsv(25, 25, 1) notRoadhsv(25, 25, 2) notRoadhsv(25, 25,3)  haralick1 haralick2 haralick3 haralick4 haralick5];
        data(2*i,:) = feature;
        group(2*i) = 0;

        if(~roadbox)
            'missing roadbox'
        end
        if(~notroadbox)
            'missing notroadbox'
        end
    end
    
    svmStruct = svmtrain(data, group, 'ShowPlot', true);
    
    
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
