%**************************************************************************
% This function is a part of a Medical Imaging Project about BIRADS
% compution. You need PRTools 5.2 to use our full code.
% 
% This file tests with a leave out strategy the classification precision
% of our algorithm.
%
% Code by Savinien Bonheur & Thomas Drevet, VIBOT 11, Universitat de Girona
%**************************************************************************

warning('off');
prwarning(0);

true_label = [3 1; 3 2; 3 3; 4 4; 4 5; 2 6; 4 7; 3 8; 1 9; 4 10; 2 11; 2 12; 2 13; 1 14; 1 15; 1 16];   
true_label = sortrows(true_label, 1);

prec = [];
power = 9;
thresh = 0.55;
features = zeros(16, 4);
for breast_num = 1:16
    im = load_breast(true_label(breast_num, 2));
    features(breast_num, :) = features_extraction(im, power, thresh);
end

label_estimated = [];
for train_num = 1 : 16
    
    % Copy the features and the results
    descTrain = features;
    labTrain = true_label(:, 1);
    % Remove the testing breast from the training set
    descTrain(train_num, :) = [];
    labTrain(train_num) = [];
    
    % Train the classifier
    Atr = prdataset(descTrain, labTrain);
    [U,G] = meancov(Atr);
    C = classc(nbayesc(U, G));
    
    % Pass the test image to the classifier
    descTest = features(train_num, :);
    Atest = prdataset(descTest, true_label(train_num, 1));
    CR = Atest * C;
    
    % Store the result
    label_estimated = [label_estimated; CR * classc];
       
end

% Print out the result
confmat(label_estimated);
precision = testc(label_estimated,'sensitivity')
