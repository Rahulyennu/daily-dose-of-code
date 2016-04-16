clear; clc;

nImages = 70; % Should not be changed
fileId = fopen('trainingset.txt', 'r');

labels = cell(nImages, 1);
means = zeros(4, 4, 70);

i = 1;

while ~feof(fileId)
    line = fgets(fileId);                % Read image filename from fileId
    [path, name, ext] = fileparts(line); % Break filename into parts for future use

    labels{i} = strcat(name);

    img = imread(strcat(line));
    img = imresize(img, [64 64]);

    [rows, cols, chnls] = size(img);
    ca = mat2cell(img, [16 16 16 16], [16 16 16 16], chnls);

    for p = 1:size(ca, 1)
        for q = 1:size(ca, 2)
            tmpCell = ca(p, q); % One cell containing 16x16x3 matrix
            mat = [tmpCell{1}]; % mat becomes a 16x16x3 matrix

            % We need to determine mean for all 3 channels
            for r = 1:chnls
                Y = mat(:, :, r); % Every k-th dimension is a 16x16 matrix

                m(r) = mean(mean(Y));
            end
            means(p, q, i) = mean(m(:));
        end
    end

    i = i + 1;
end

fclose(fileId);
