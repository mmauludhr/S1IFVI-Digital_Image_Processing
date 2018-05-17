function morphDilation(I)
% I.S. Exist an RGB image
% F.S. Return morphed image

I = im2bw(I);
ori_img = imcomplement(I);
[height, width]=size(ori_img);
mod_img = ori_img;

for i=2 : height-2
    for j=2 : width-2
        if ori_img(i,j)==1
            mod_img(i,j-1) = 1;
            mod_img(i,j)   = 1;
            mod_img(i,j+1) = 1;
            mod_img(i-1,j) = 1;
            mod_img(i+1,j) = 1;
        end
    end
end

figure('Name', 'Dilation','NumberTitle','off');
subplot(1,2,1), imshow(ori_img);
subplot(1,2,2), imshow(mod_img);

end