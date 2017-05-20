%**************************************************************************
% This function is a part of a Medical Imaging Project about BIRADS
% compution. You need PRTools 5.2 to use our full code.
%
% This function loads a breast from a database to used in the training part
% of the code.
%
% Code by Savinien Bonheur & Thomas Drevet, VIBOT 11, Universitat de Girona
%**************************************************************************

function [dcm_img, result] = load_breast(number)

path = 'Vibot_challenge_data/';

% Extracting the folders name list
list_files = dir(path);
list_folders = list_files([list_files.isdir]==1);
name_folders = [];
for i = 3:size(list_folders, 1)
    name_folders = [name_folders; list_folders(i).name];
end
birads_level = zeros([size(name_folders, 1), 1]);

i = int32(rand(1) * 16);
if nargin == 1
    i = number;
end

% Search in the sub-folder the dicom file and open it
new_path = (strcat(path, name_folders(i, :)));
dcm_lists = ls(new_path);
if isunix == 0
    dcm_list = dcm_lists(3, :);
end
dcm_path = (strcat(new_path, '/', dcm_lists));
dcm_img = dicomread(dcm_path);

result = [3; 3; 3; 4; 4; 2; 4; 3; 1; 4; 2; 2; 2; 1; 1; 1];
result = result(i);
end

