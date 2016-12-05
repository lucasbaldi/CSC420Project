function ds = detectCars;
% detecting cars using dpm based off of the models we used for a4 -
% Catherine (Cong Hua) Chen 

data = getData1([], 'detector-car');
model = data.model;
col = 'r';

imdata = getData1('000038', 'left');
im = imdata.im;
f = 1.5;
imr = imresize(im,f);
globals1;
fprintf('running the detector, may take a few seconds...\n');
tic;
[ds, bs] = imgdetect(imr, model, model.thresh + 0.32); 
% you may need to reduce the threshold if you want more detections
e = toc;
fprintf('finished! (took: %0.4f seconds)\n', e);
nms_thresh = 0.2; %reduce to decrease number of overlaps
top = nms(ds, nms_thresh);
if model.type == model_types.Grammar
  bs = [ds(:,1:4) bs];
end
if ~isempty(ds)
    % resize back
    ds(:, 1:end-2) = ds(:, 1:end-2)/f;
    bs(:, 1:end-2) = bs(:, 1:end-2)/f;
end;

showboxesMy(im, reduceboxes(model, bs(top,:)), col);
fprintf('detections:\n');
ds = ds(top, :);





end

