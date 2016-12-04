function test;

location = getData('um_000000', 'location');
location = location.location;
xyz = location.xyz;
figure;
pcshow(xyz); 
xlabel('X');
ylabel('Y');
zlabel('Z');