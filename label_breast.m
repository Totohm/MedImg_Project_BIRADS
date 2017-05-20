%**************************************************************************
% This function is a part of a Medical Imaging Project about BIRADS
% compution. You need PRTools 5.2 to use our full code.
%
% This function feeds the 4 features previously extracted to a classifier
% to label a breast according to the BIRADS classification.
%
% Code by Savinien Bonheur & Thomas Drevet, VIBOT 11, Universitat de Girona
%**************************************************************************

function [label_estimated, label_conf] = label_breast(im)

warning('off');
prwarning(0);

C = load('classifiers_Drevet_Bonheur.mat');
C = C.C;
 
power = 9;
thresh = 0.55;

% Pass the test image to the classifier
descTest = features_extraction(im, power, thresh);
CR = descTest * C;

% Store the result
label_estimated = CR * labeld;
label_conf = max(getdata(CR));

end

