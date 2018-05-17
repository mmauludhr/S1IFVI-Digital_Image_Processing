function toolZoomIn(I)
% I.S. Exist an RGB image
% F.S. Enlarge the image size by 2 times

[height, width, colormap] = size(I);
temp_height = height*2;
temp_width = width*2;
image = uint8(zeros(temp_height, temp_width, colormap));

for i = 1 : height
    for j = 1 : width
        temp1 = I(i,j,1);
        temp2 = I(i,j,2);
        temp3 = I(i,j,3);
        for k = 1 : 2
            for l = 1 : 2
                temp_b=((i-1)*2 + k);
                temp_k=((j-1)*2 + l);
                image(temp_b,temp_k,1)=temp1;
                image(temp_b,temp_k,2)=temp2;
                image(temp_b,temp_k,3)=temp3;
            end
        end
    end
end

figure('Name', 'Zoom-In','NumberTitle','off');
imshow(image);


end