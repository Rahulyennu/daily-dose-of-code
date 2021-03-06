function [all_desc_mean all_desc_sample] = trainingFeatures(trainingset, offsets)
    all_desc_sample = {};
    all_desc_mean   = [];

    for i = 1:size(trainingset, 1)
        tmp = [];

        for j = 1:size(trainingset, 2)
            img  = imread(char(trainingset(i, j)));

            properties = glcmProperties(img, offsets);

            all_desc_sample = cat(2, all_desc_sample, properties);
            tmp = cat(1, tmp, properties);
        end

        all_desc_mean = cat(1, all_desc_mean, mean(tmp));
    end
end
