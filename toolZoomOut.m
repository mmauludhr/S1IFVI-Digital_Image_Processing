function toolZoomOut(I)
% I.S. Exist an RGB image
% F.S. Decrease the image size by 2 times

[height, width, colormap] = size(I);
temp_height = floor(height/2);
temp_width = floor(width/2);
image = uint8(zeros(temp_height, temp_width, colormap));
i = 1;
j = 1;

for k = 1  : 2 : height
    for l = 1 : 2 : width
        image(i, j, :) = I(k, l, :);
        j = j+1;
    end
    i = i+1;
    j = 1;
end

figure('Name', 'Zoom-Out','NumberTitle','off');
imshow(image);

end