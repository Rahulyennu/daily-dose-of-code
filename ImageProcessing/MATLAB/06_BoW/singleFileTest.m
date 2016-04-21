% Try the classifier on single test images ================================

op = '';

while ~strcmp(op, 'N')
    prompt = '[Category/filename] of test image? ';
    str = input(prompt, 's');

    filename = fullfile(datasetFolderRoot, str);

    if exist(filename, 'file') == 2
        img = imread(filename);

        % score is the negated average binary loss per class
        [labelIdx, score] = predict(categoryClassifier, img);

        [score]

        imshow(img); title(strcat('PREDICTED: ', categoryClassifier.Labels(labelIdx)));
    else
        fprintf('>>> File does not exist!\n');
    end

    prompt = '\nTry again? [y/n] ';
    op = input(prompt, 's');

    if strcmp(op, 'n')
        op = 'N';
    end
end
