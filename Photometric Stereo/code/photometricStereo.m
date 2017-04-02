function [albedoImage, surfaceNormals] = photometricStereo(imArray, lightDirs)
% PHOTOMETRICSTEREO compute intrinsic image decomposition from images
%   [ALBEDOIMAGE, SURFACENORMALS] = PHOTOMETRICSTEREO(IMARRAY, LIGHTDIRS)
%   comptutes the ALBEDOIMAGE and SURFACENORMALS from an array of images
%   with their lighting directions. The surface is assumed to be perfectly
%   lambertian so that the measured intensity is proportional to the albedo
%   times the dot product between the surface normal and lighting
%   direction. The lights are assumed to be of unit intensity.
%
%   Input:
%       IMARRAY - [h w n] array of images, i.e., n images of size [h w]
%       LIGHTDIRS - [n 3] array of unit normals for the light directions
%
%   Output:
%        ALBEDOIMAGE - [h w] image specifying albedos
%        SURFACENORMALS - [h w 3] array of unit normals for each pixel
%
% Author: Subhransu Maji
%
% Acknowledgement: Based on a similar homework by Lana Lazebnik

%%% implement this %% 
[h, w, n] = size(imArray);

g = zeros(3,1);

imPixels = zeros(n, 1);
I = zeros(n, n);
albedoImage = zeros(h, w);
sum = 0;sum_surface = 0;
for i = 1:h
   for j = 1:w
       for k = 1:n
          imPixels(k) = imArray(i,j,k);
            I(k,k) = imArray(i,j,k);
       end
       g = (lightDirs)\(imPixels);
       g = reshape(g, [1 1 3]);
       surfaceNormals(i,j,:) = g;
   end
end

for i = 1:3
    sum = surfaceNormals(:,:,i).^2;
    sum_surface = sum_surface + sum;
end

albedoImage = sum_surface.^0.5;


surfaceNormals = surfaceNormals./albedoImage;



