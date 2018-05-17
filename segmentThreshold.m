function image = segmentThreshold(I, bot_r, bot_g, bot_b, top_r, top_g, top_b)
% Exist an RGB image
% Return a new segmented image using threshold

[height, width, colormap] = size(I);
temp_img = zeros(height,width,colormap);

for i=1 : height
    for j=1 : width
        if I(i,j,1)>top_r && I(i,j,1)<bot_r && I(i,j,2)>top_g && I(i,j,2)<bot_g && I(i,j,3)>top_b && I(i,j,3)<bot_b
            temp_img(i,j,:)=I(i,j,:);
        end
    end
end

image = uint8(temp_img);

end