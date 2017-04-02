function blobs = detectBlobsScaleFilter(im)
% DETECTBLOBS detects blobs in an image
%   BLOBS = DETECTBLOBSSCALEFILTER(IM, PARAM) detects multi-scale blobs in IM.
%   The method uses the Laplacian of Gaussian filter to find blobs across
%   scale space. This version of the code scales the filter and keeps the
%   image same which is slow for big filters. 
% 
% Input:
%   IM - input image
%
% Ouput:
%   BLOBS - n x 4 array with blob in each row in (x, y, radius, score)
%
% This code is part of:
%
%   CMPSCI 670: Computer Vision, Fall 2014
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 3: Blob detector


% Dummy - returns a blob at the center of the image
% blobs = round([size(im,2)*0.5 size(im,1)*0.5 0.25*min(size(im,1), size(im,2)) 1]);
im = rgb2gray(im); im = im2double(im);
[h,w,n] = size(im);
scaleSpace = zeros(h, w, n);
template = zeros(h, w, n);
max_candi = zeros(h, w, n);
blobs = zeros(1,4);
% initial the scale 
scale = 1;

for i = 1:11
    k = 2*(scale^i);
    Hsize = 6*ceil(k);
    H = k^2 * fspecial('log', Hsize, k);
    scaleSpace(:,:,i) = imfilter(im, H, 'replicate');
    scaleSpace(:,:,i) = abs(scaleSpace(:,:,i));
    
    template(:,:,i) = ordfilt2(scaleSpace(:,:,i), 25, ones(5));
    %template(:,:,i+1) = ordfilt2(scaleSpace(:,:,i+1), (2*ceil(0.3*(i+1))+1)^2, ones(2*ceil(0.3*(i+1))+1));
    
    maxCandiTem = template(:,:,i);
    maxCandiTem(template(:,:,i) ~= scaleSpace(:,:,i)) = 0;
    max_candi(:,:,i) = maxCandiTem;
    
    scale = scale + 0.02;
end


NumBlobs = 0;
for i = 0:10
    [MaxPosition_row, MaxPosition_col] = find(max_candi(:,:,i+1)>0);
    for j=1:size(MaxPosition_row)
        candidate = max_candi(MaxPosition_row(j), MaxPosition_col(j), i+1);
        if(candidate ~= max(template(MaxPosition_row(j), MaxPosition_col(j),:)) )
            continue;
        end
        
        if(candidate > 0.05 )
            NumBlobs = NumBlobs + 1;
            blobs(NumBlobs, :) = [MaxPosition_col(j), MaxPosition_row(j),1.414*2*((1+0.0231*i)^i), candidate];
        end  
    end
end

        
