%% ========================================================================
%% Extract SURF features from images.
%% NOTE: Requires OpenSURF_version1c/ to be in current path.
%%
%% Parameters:
%%      image_set      - Holds paths to images. M*N cell array, M = Number of
%%                       image categories, N = Samples per category.
%%
%% Returns:
%%      all_des        - All the SURF descriptors: m*64.
%%      all_des_sample - All the SURF descriptors per sample: 1*n cell.
%%      class_label    - Class label for each surf descriptor: m*1.
%% ========================================================================

function [all_des all_des_sample class_label] = extractFeatures(image_set)
    all_des = [];
    all_des_sample = {};
    class_label = [];

    K = 64;                     % SURF descriptor dimension
    Options.upright = false;    % Rotation invariant
    Options.tresh   = 0.0002;   % Hessian response threshold

    % Add OpenSURF_version1c/ to Octave path
    currentfile = 'extractFeatures.m';
    _pwd = which(currentfile);
    _pwd = _pwd(1:(end - length(currentfile)));
    addpath([_pwd 'OpenSURF_version1c']);

    k = 0;

    fprintf('Calculating SURF descriptors for input samples..'); fflush(stdout);

    for i = 1:size(image_set, 1)
        k = k + 1;

        for j = 1:size(image_set, 2)
            str = char(image_set(i, j));
            img = imread(str);
            pts = OpenSurf(img, Options);
            D   = (reshape([pts.descriptor], K, []))';  % Landmark descriptors

            all_des = cat(1, all_des, D);
            all_des_sample = cat(2, all_des_sample, D);

            tmp = ones(size(D, 1), 1) * k;
            class_label = cat(1, class_label, tmp);
        end
    end

    fprintf('Done\n\n'); fflush(stdout);
end
