function morphErotion(I)
% I.S. Exist an RGB image
% F.S. Return morphed image

I = im2bw(I);
ori_img = imcomplement(I);
[height, width]=size(ori_img);
mod_img = double(ori_img);

for i=2 : height-2
    for j=2 : width-2
        if ori_img(i,j)==1
            if mod_img(i,j-1)==0 || mod_img(i,j+1)==0 || mod_img(i-1,j)==0 || mod_img(i+1,j)==0
                mod_img(i,j)=2;
            end
        end
    end
end

image_fix_banget = zeros(height,width);

for i=1 : height
    for j=1 : width
        if mod_img(i,j)==1
            image_fix_banget(i,j)=1;
        end
    end
end

figure('Name', 'Erotion','NumberTitle','off');
subplot(1,2,1), imshow(ori_img);
subplot(1,2,2), imshow(image_fix_banget);

end