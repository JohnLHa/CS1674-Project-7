function [ labels ] = findLabelsKNN( pyramids_train, pyramids_test, labels_train, k )
%FINDLABELSKNN Summary of this function goes here
%   Finds the labels


%finds all distances from testing point and sorts them
for i=1:size(pyramids_test)
    for j=1:size(pyramids_train)
        distances = dist2(pyramids_test(i), pyramids_train(j));
    end
    [distances, indices] = sort(distances, 'ascend');
    
    %takes shortest distance k points and saves labels
    for b=1:k
        foundLabels(b) = labels_train(indices);
    end

    %assigns the most found label
    labels(i) = mode(foundLabels);

end
