%Classify a single test image using our rbf kernel svm classifier 
% Implemented by Lucas Baldi

function classified = classify(imname);

globals;
list = getData('', 'testlist');
list = list.ids;

%Get the image to test
imleft = getData(imname, 'left-test');
imleft = imleft.im;
hsvim = rgb2hsv(imleft);

%Load the classifier
classifier = getData('', 'classifier');
classifier = classifier.classifier

%Initialize the classified image matrix
classified = zeros(size(imleft, 1), size(imleft, 2));
    
% classification needs sample patch of 50 px, 
% Can't classify the pixels within 25 pixels of the edge
% as our patch would overlap the edge of he image
rowbound = [26:size(imleft,1)-26];
colbound = [26:size(imleft,2)-26];

for i=rowbound;
    for j=colbound;
        
        %Create the sample patch around pixel (i, j)
        box = [i-25 j-25 i+25 j+25];
        imageSection = imleft(box(1):box(3), box(2):box(4), :);
        
        %Create a gray level covariance matrix from the patch
        glcm = graycomatrix(rgb2gray(imageSection));
        
        %Calculate haralick features from the GLCM from the patch
        [h1 h2 h3 h4 h5] = haralick(glcm);
        
        %Normalize the haralick features
        haralicks = [h1 h2 h3 h4 h5];
        haralicks = haralicks./max(haralicks(:));
        
        %Create the 8 dimensional feature vector for this pixel
        feature = [hsvim(i, j, 1) hsvim(i, j, 2) hsvim(i,j, 3) haralicks(1) haralicks(2) haralicks(3) haralicks(4) haralicks(5)];
        
        %Classify this pixel and save it into the matrix
        group = svmclassify(classifier, feature);
        classified(i, j) = group;
        
    end
end