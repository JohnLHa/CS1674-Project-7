function [bow] = computeBOWRepr(descriptors, means)
    %Computes a bag of words representation

    means = means';

    k = size(means, 1);
    bow = zeros(1, k);

    descriptors = double(descriptors');
    means = means';

    [x,y] = size(descriptors);
    if x==0
        if y ==0
            descriptors = zeros(0,128);
        end
    end
        
    
    dists = dist2(descriptors, means);
    [~, inds] = min(dists, [], 2);
    
    for i = 1:k
        bow(i) = sum(inds == i);
    end
    
    bow = bow / sum(bow);
    
        
        