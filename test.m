%[K2 R2 K3 R3] = getCameraMatrices('um_000000');

%baseline = 0.54;
function depth = test;
depth = calculateDepth('um_000000');
