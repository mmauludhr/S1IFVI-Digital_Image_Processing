function image = toolFlipHorizontal(I)
% I.S. Exist an RGB image
% F.S. Flip the image horizontally

[height, width, colormap]=size(I);
temp_img=uint8(zeros(height,width,colormap));

for i = height : -1 : 1
    for j = width : -1 : 1
        temp_img(height-i+1, width-j+1,:) = I(i, width-j+1, :);
    end
end

image = temp_img;

end