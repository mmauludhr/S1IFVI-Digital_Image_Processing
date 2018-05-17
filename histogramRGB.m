function [x, y_red, y_green, y_blue] = histogramRGB(I)
% Exist RGB Image
% Return constant x value. Return y value for each colormap

x = 0:255;
count_red = zeros(256,1);
count_green = zeros(256,1);
count_blue = zeros(256,1);
[height, width, colormap]=size(I);

for j = 1 : height
    for k = 1 : width
        count_red(I(j,k,1)+1)=count_red(I(j,k,1)+1)+1;
        count_green(I(j,k,2)+1)=count_green(I(j,k,2)+1)+1;
        count_blue(I(j,k,3)+1)=count_blue(I(j,k,3)+1)+1;
    end
end

y_red = count_red;
y_green = count_green;
y_blue = count_blue;

end