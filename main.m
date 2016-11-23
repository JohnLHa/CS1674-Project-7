scenes_dir = 'C:\Users\John Ha\Documents\MATLAB\HW7P\scenes';

%training percentage
training_pct = .5;

[train, test] = get_data(scenes_dir, training_pct);
k=3;
for i=1:size(train)
    im = imread(train(i).path);
    if size(im, 3) == 3
        im = rgb2gray(im);
    end
    [frames, descriptors] = vl_sift(single(im));
    if i==1
        totalDesc =  descriptors;
    else
        totalDesc = [totalDesc, descriptors];
    end
end


[membership,means,rms] = kmeansML(k,double(totalDesc));


for i=1:size(train)
   im = imread(train(i).path);
   if size(im, 3) == 3
        im = rgb2gray(im);
   end
   trainingPyramid = computeSPMHistogram(im, means);
end

for i=1:size(test)
   im = imread(test(i).path);
   if size(im, 3) == 3
        im = rgb2gray(im);
   end
   testingPyramid = computeSPMHistogram(im, means);
end
trainingPyramid = trainingPyramid';
testingPyramid = testingPyramid';

%From here down, code doesn't work due to syntax. Please check
%theory behind pseudocode
labels_train(:) =train(1:size(train)).category;
trueLabels(:) =test(1:size(test)).category;

%From here calculates labels and accuracy for each k 1, 5, 25, 125
labels = findLabelsKNN(trainingPyramid, testingPyramid, labels_train, 1);
computeAccuracy(trueLabels, labels);

labels = findLabelsKNN(trainingPyramid, testingPyramid, labels_train, 5);
computeAccuracy(trueLabels, labels);

labels = findLabelsKNN(trainingPyramid, testingPyramid, labels_train, 25);
computeAccuracy(trueLabels, labels);

labels = findLabelsKNN(trainingPyramid, testingPyramid, labels_train, 125);
computeAccuracy(trueLabels, labels);
