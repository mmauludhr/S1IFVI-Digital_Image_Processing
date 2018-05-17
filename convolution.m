function image = convolution(I, kernel)
% I.S. Exist an RGB image and kernel filter
% F.S. Return convolved image with kernel

[height, width, colormap] = size(I);
temp_img = double(I);

for i=2 : height-2
    for j=2 : width-2
        result=temp_img(i-1, j-1, :)*kernel(1, 1, :)+temp_img(i, j-1, :)*kernel(2, 1, :)...
            + temp_img(i+1, j-1, :)*kernel(3, 1, :)+temp_img(i-1 ,j, :)*kernel(1, 2, :)...
            + temp_img(i, j, :)*kernel(2, 2, :)+temp_img(i+1 ,j, :)*kernel(3, 2, :)...
            +temp_img(i-1, j+1, :)*kernel(1, 3, :)+temp_img(i, j+1, :)*kernel(2, 3, :)...
            +temp_img(i+1, j+1, :)*kernel(3, 3, :);
        mod_img(i-1,j-1, :)=result;
    end
end

image = uint8(mod_img);

end