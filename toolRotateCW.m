function image = toolRotateCW(I)
% I.S. Exist an RGB image
% F.S. Rotate image 90 degree clockwise

[height, width, colomap] = size(I);

for i=1 : height
    for j=1 : width
        temp(i,j,:) = I(i,j,:);
    end
end

for i=1 : height
    for j=1 : width
        temp_img(j,height+1-i,:) = temp(i,j,:);
    end
end

image = temp_img;

end