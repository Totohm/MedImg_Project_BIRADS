%**************************************************************************
% This function is a part of a Medical Imaging Project about BIRADS
% compution. You need PRTools 5.2 to use our full code.
% 
% This file is the main part of the code that will search for all the MRI
% images (DICOM files), convert them into a 3D matrix, compute the BIRADS
% level and return a text file containing the results.
%
% Code by Savinien Bonheur & Thomas Drevet, VIBOT 11, Universitat de Girona
%**************************************************************************

%% Initialization
close all; clear all;
path = 'Vibot_challenge_data/';

%% Extracting the folders name list

list_files = dir(path);
list_folders = list_files([list_files.isdir]==1);
name_folders = [];
for i = 3:size(list_folders, 1)
    name_folders = [name_folders; list_folders(i).name];
end
birads_level = zeros([size(name_folders, 1), 1]);

%% Main function applied to all the folders (search DICOM, convert it, label it)

for i = 1 : size(name_folders, 1)
    
    %Search in the sub-folder the dicom file and open it
    new_path = (strcat(path, name_folders(i, :)));
    dcm_lists = ls(new_path);
    if isunix==0
        dcm_list=dcm_lists(3, :);
    end
    dcm_path = (strcat(new_path, '/', dcm_lists(3, :)));
    dcm_img = dicomread(dcm_path);
    
    %Convert the DICOM image into a simpler 3D matrix
    inter_img = convert_DICOM_matrix3D(dcm_img);
    
    %Compute the BIRADS level   
    birads_level(i) = label_breast(inter_img);
end

%% Write the results in a text file
fid = fopen(strcat(path, 'birads_results.txt'), 'wt');
for i = 1:(size(name_folders, 1))
    text=strcat('The breast from the file ', 32, name_folders(i,:),' has a BIRADS level of ', 32, num2str(birads_level(i)),'.');
    fprintf( fid, text);
    fprintf( fid, '\n');
end