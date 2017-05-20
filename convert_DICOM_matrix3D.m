%**************************************************************************
% This function is a part of a Medical Imaging Project about BIRADS
% compution.
%
% This function will convert our DICOM files used in the project into a
% simpler 3 dimensions matrix
%
% Code by Savinien Bonheur & Thomas Drevet, VIBOT 11, Universitat de Girona
%**************************************************************************

function breast_area = convert_DICOM_matrix3D(dicom_image)

%Get the size of the dicom image
dicom_size = size(dicom_image);

%Create the output matrix containing the map of the breast region
breast_area = zeros(dicom_size(1), dicom_size(2), dicom_size(4));
for i = 1:dicom_size(4)
    breast_area(:, :, i) = dicom_image(:, :, 1, i);
end