function image = imageCompression(I)
% I.S. Exist an RGB image
% F.S. Return compressed image and write into a new file.

[height, width, colormap] = size(I);
map = double(I);


for k = 1:3
    temp_map = map(:, :, k);
    
    result = zeros(height,width);
    
    for i= 1:height
        for j= 1:width
            if mod(double(temp_map(i,j)),2)==0
                result(i,j)=((double(temp_map(i,j))+1))/2;
            else
                result(i,j) = double(temp_map(i,j))/2;
            end
        end
    end
    mod_img(:,:,k)=result;
end

image = uint8(mod_img);

imwrite(image, 'Compressed_Image.jpg');

end