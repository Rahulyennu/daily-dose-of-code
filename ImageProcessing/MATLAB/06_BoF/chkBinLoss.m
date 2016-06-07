% Check average binary losses per image set ===============================

% Defining path and loading dataset =======================================

imagesets_unknown = [imageSet(fullfile(datasetFolderRoot, 'chair')), ...
    imageSet(fullfile(datasetFolderRoot, 'bass')), ...
    imageSet(fullfile(datasetFolderRoot, 'okapi')), ...
    imageSet(fullfile(datasetFolderRoot, 'cannon')) ...
    imageSet(fullfile(datasetFolderRoot, 'electric_guitar')), ...
    imageSet(fullfile(datasetFolderRoot, 'lotus')), ...
    imageSet(fullfile(datasetFolderRoot, 'pyramid')), ...
    imageSet(fullfile(datasetFolderRoot, 'brain'))];

fprintf('Checking for binary losses...\n\n');

fprintf('Looking at known image sets...\n\n');
minloss1 = binLoss(categoryClassifier, validationSets, 8);

fprintf('\nLooking at unknown image sets...\n\n');
minloss2 = binLoss(categoryClassifier, imagesets_unknown, 8);