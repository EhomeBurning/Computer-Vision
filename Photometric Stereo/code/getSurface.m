function  heightMap = getSurface(surfaceNormals, method)
% GETSURFACE computes the surface depth from normals
%   HEIGHTMAP = GETSURFACE(SURFACENORMALS, IMAGESIZE, METHOD) computes
%   HEIGHTMAP from the SURFACENORMALS using various METHODs. 
%  
% Input:
%   SURFACENORMALS: height x width x 3 array of unit surface normals
%   METHOD: the intergration method to be used
%
% Output:
%   HEIGHTMAP: height map of object

switch method
    case 'column'
        %%% implement this %%%
        
        [imageHeight, imageWidth] = size(surfaceNormals(:,:,1));
        heightMap = zeros(imageHeight, imageWidth);
        fx = -bsxfun(@rdivide, surfaceNormals(:,:,1), surfaceNormals(:,:,3));
        fy = -bsxfun(@rdivide, surfaceNormals(:,:,2), surfaceNormals(:,:,3));
%         x1 = x(1:imageHeight,1:imageWidth);
%         y1 = y(1:imageHeight,1:imageWidth);
%         sum_x = cumsum(x1,2);
%         sum_y = cumsum(y1,1);
%         heightMap = sum_x + sum_y; 
        heightMap = [cumsum(fx(:,1)) fy(1:end,2:end)];
        heightMap = cumsum(heightMap,2);
    case 'row'  
        %%% implement this %%%
        
        [imageHeight, imageWidth] = size(surfaceNormals(:,:,1));
        heightMap = zeros(imageHeight, imageWidth);
        fx = -bsxfun(@rdivide, surfaceNormals(:,:,1), surfaceNormals(:,:,3));
        fy = -bsxfun(@rdivide, surfaceNormals(:,:,2), surfaceNormals(:,:,3));
%         x1 = x(1:imageHeight,1:imageWidth);
%         y1 = y(1:imageHeight,1:imageWidth);
%         sum_x = cumsum(x1,1);
%         sum_y = cumsum(y1,2);
%         heightMap = sum_x + sum_y; 
        heightMap = [cumsum(fy(1,:), 2); fx(2:end,1:end)];
        heightMap = cumsum(heightMap);
    case 'average'
        %%% implement this %%%
        
        [imageHeight, imageWidth] = size(surfaceNormals(:,:,1));
        heightMap = zeros(imageHeight, imageWidth);
        x = -bsxfun(@rdivide, surfaceNormals(:,:,1), surfaceNormals(:,:,3));
        y = -bsxfun(@rdivide, surfaceNormals(:,:,2), surfaceNormals(:,:,3));
        for i = 1:imageHeight
            for j = 1:imageWidth
                x1 = x(1:i, 1:j);
                y1 = y(1:i, 1:j);
                sum_x = sum(x1,2);
                sum_x1 = sum_x(i);
                sum_x2 = sum_x(1);
                sum_y = sum(y1,1);
                sum_y1 = sum_y(1);
                sum_y2 = sum_y(j);
                heightMap(i,j) = (sum_x1 + sum_y1 + sum_x2 + sum_y2)/2;
            end
        end
     case 'random'
        %%% implement this %%%
        tic;
        [imageHeight, imageWidth] = size(surfaceNormals(:,:,1));
        heightMap = zeros(imageHeight, imageWidth);
        x = -bsxfun(@rdivide, surfaceNormals(:,:,1), surfaceNormals(:,:,3));
        y = -bsxfun(@rdivide, surfaceNormals(:,:,2), surfaceNormals(:,:,3));
        for i = 1:imageHeight
            for j = 1:imageWidth
                m = randi([1,i],1,1);
                n = randi([1,j],1,1);
                x1 = x(1:i, 1:j);
                y1 = y(1:i, 1:j);
                sum_x = sum(x1,2);
                sum_x1 = sum_x(i);
                sum_x2 = sum_x(m);
                sum_y = sum(y1,1);
                sum_y1 = sum_y(n);
                sum_y2 = sum_y(j);
                heightMap(i,j) = (sum_x1 + sum_y1 + sum_x2 + sum_y2)/2;
            end
        end   
end
