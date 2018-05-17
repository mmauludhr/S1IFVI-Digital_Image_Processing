function image = segmentRegionGrowth(I, x_position, y_position)
% I.S. Exist an RGB image and a coordinate
% F.S. Return segmented area using region growth method

threshold = 50;
gray_img = rgb2gray(I);

a = 100;

[height, width] = size(gray_img);
temp_img = zeros(height, width);
check = zeros(height, width);
seed = I(x_position, y_position);

while check ~= 1
    for i = 1 : height
        for j = 1 : width
            if I(i,j)<threshold+seed && check(i,j)~=1
                temp_img(i,j)=a;
                check(i,j)=1;
            end
        end
    end
    a = a + 100;
    for i = 1 : height
        for j = 1 : width
            if check(i,j)~=1
                seed = I(i,j);
                break;
            end
        end
    end
end

image = uint8(temp_img);

end