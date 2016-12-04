function showPointCloud(imname);

location = getData(imname, 'location');
location = location.location;
xyz = location.xyz;
figure;
pcshow(xyz); 
xlabel('X');
ylabel('Y');
zlabel('Z');

im = getData(imname, 'left');
im = im.im;
figure;
imshow(im);