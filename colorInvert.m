function [image] = colorInvert(I)
% I.S. Exist an RGB I
% F.S. Invert the RGB color of the I

image = uint8(255-I(:,:,:));

end