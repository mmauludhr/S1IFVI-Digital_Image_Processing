function image = toolFlipVertical(I)
% I.S. Exist an RGB image
% F.S. Flip the image vertically

[height, width, colomap]=size(I);
temp_img=uint8(zeros(height, width, colomap));

for i = height : -1 : 1
    for j=width : -1 : 1
        temp_img(height-i+1,width-j+1,:)=I(height-i+1,j,:);
    end
end

image = temp_img;

end