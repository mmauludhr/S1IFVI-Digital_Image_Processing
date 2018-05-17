function image = toolCrop(I)
% I.S. Exist an RGB image
% F.S. Return a cropped image

[height, width, colormap]=size(I);
temp_height = floor(height*(0.5));
temp_width = floor(width*(0.5));
mod_img = uint8(zeros(temp_height,temp_width,colormap));

for i = 1 : temp_height
    for j = 1 : temp_width
        mod_img(i,j,:) = I(i,j,:);
    end
end

image = mod_img;

end