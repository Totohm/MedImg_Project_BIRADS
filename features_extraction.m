%**************************************************************************
% This function is a part of a Medical Imaging Project about BIRADS
% compution. You need PRTools 5.2 to use our full code.
%
% This function is extracting 4 features from a Breast 3D DBT after  
% transforming into a 2D DBT.
%
% Code by Savinien Bonheur & Thomas Drevet, VIBOT 11, Universitat de Girona
%**************************************************************************

function [ features ] = features_extraction(im, power, thresh)

% Project the image on a 2d plane
im = double(sum(im, 4));
im = im ./ norm(im, 1) * 255;

% Delete the breast border (skins)
st = strel('square', 20);
im_temp = double(imerode((im > 0), st));
im2 = im .* im_temp;

% Crop the images
[~, c] = find(im2 ~= 0);
im2 = (im2(:, 1:max(c)));

% Calcul the mean intensity of the image with and without histeq
features(1) = mean2(histeq(im2));
features(2) = mean2(im2(im2 ~= 0));

% Enhance the contrast
im2 = im2 .^ power;
im2 = im2 ./ norm(im2, 1) * 255;

% Segment the image
E = (entropyfilt(im2));
Eim = mat2gray(E);
BW1 = imbinarize(Eim, thresh);

% Extract the dense regions and the reduce noise
breast_mask = (im2 == 0);
BW1 = BW1 + breast_mask;
st = strel('square', 4);
BW1 = double(imerode((BW1 == 0), st));

features(3) = mean2(im2 .* BW1 / (im2 .* E));
features(4) = numel(find((BW1 == 1))) / numel(find((im2 ~= 0)));

end

