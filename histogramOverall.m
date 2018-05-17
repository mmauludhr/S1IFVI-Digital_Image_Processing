function [x, y] = histogramOverall(I)
% Exist RGB image
% Return x and y to generate graph

I = rgb2gray(I);

[height, width] = size(I);
x = 0:255;
y = 1:256;

count_y = 0;

for z = 1:256
    for i = 1:height
        for j = 1:width
            if I(i,j) == z-1
                count_y = count_y+1;
            end
        end
    end
    y(z) = count_y;
    count_y = 0;
end

end