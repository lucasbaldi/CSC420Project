function classified = classify(imname);

globals;
list = getData('', 'testlist');
list = list.ids;

%for i=1:size(list,1)
 %   imname = list{i};
imleft = getData(imname, 'left-test');
imleft = imleft.im;
hsvim = rgb2hsv(imleft);
    
classifier = getData('', 'classifier');
classifier = classifier.classifier

classified = zeros(size(imleft, 1), size(imleft, 2));
    
rowbound = [26:size(imleft,1)-26];
colbound = [26:size(imleft,2)-26];

for i=rowbound;
    i
    for j=colbound;
        box = [i-25 j-25 i+25 j+25];
        imageSection = imleft(box(1):box(3), box(2):box(4), :);
        glcm = graycomatrix(rgb2gray(imageSection));
        [h1 h2 h3 h4 h5] = haralick(glcm);
        haralicks = [h1 h2 h3 h4 h5];
        haralicks = haralicks./max(haralicks(:));
        feature = [hsvim(i, j, 1) hsvim(i, j, 2) hsvim(i,j, 3) haralicks(1) haralicks(2) haralicks(3) haralicks(4) haralicks(5)];
        group = svmclassify(classifier, feature);
        classified(i, j) = group;
        
    end
end
imshow(classified);