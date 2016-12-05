% Simple show point cloud implementation by Lucas Baldi

function showPointCloud(imname);

%Get the 3 location for each pixel in the image
location = getData(imname, 'location');
location = location.location;
xyz = location.xyz;

%Display the 3d point cloud for those locations
figure;
pcshow(xyz); 
xlabel('X');
ylabel('Y');
zlabel('Z');

%Display the original image
im = getData(imname, 'left');
im = im.im;
figure;
imshow(im);