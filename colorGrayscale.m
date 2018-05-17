function image = colorGrayscale(I)
% I.S. Exist an RGB image
% F.S. RGB image turn into Grayscale

image = uint8(.2989 * I(:,:,1) + .5870 * I(:,:,2) + .1140 * I(:,:,3));

end