function image = noiseFilterMean(I)
% I.S. Exist an RGB image and kernel filter
% F.S. Return filtered image using mean method

[height, width, colormap]=size(I);
temp_image = double(I);

for i=2 : height-2
    for j=2 : width-2
        result=temp_image(i-1,j-1,:)+temp_image(i,j-1,:)...
            +temp_image(i+1,j-1,:)+temp_image(i-1,j,:)...
            +temp_image(i,j,:)+temp_image(i+1,j,:)...
            +temp_image(i-1,j+1,:)+temp_image(i,j+1,:)...
            +temp_image(i+1,j+1,:);
        mod_img(i-1,j-1,:) = floor(result/9);
    end
end

image = uint8(mod_img);

end