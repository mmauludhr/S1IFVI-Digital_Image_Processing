function image = noiseFilterModus(I)
% I.S. Exist an RGB image and kernel filter
% F.S. Return filtered image using modus method

[height, width, colormap]=size(I);
temp_img=double(I);

for i=2 : height-2
    for j=2 : width-2
        for k=1 : 3
            list(1) = temp_img(i-1,j-1,k);
            list(2) = temp_img(i,j-1,k);
            list(3) = temp_img(i+1,j-1,k);
            list(4) = temp_img(i-1,j,k);
            list(5) = temp_img(i,j,k);
            list(6) = temp_img(i+1,j,k);
            list(7) = temp_img(i-1,j+1,k);
            list(8) = temp_img(i,j+1,k);
            list(9) = temp_img(i+1,j+1,k);
            mod_img(i-1,j-1,k)=mode(list);
        end
    end
end

image = uint8(mod_img);

end