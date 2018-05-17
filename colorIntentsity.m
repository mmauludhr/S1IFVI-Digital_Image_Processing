function image = colorIntentsity(I, value, type)
% I.S. Exist an RGB I
% F.S. Calculation of the RGB color intensity based on calculation type and the value number

if strcmp(type, "Plus")
    image = uint8(I(:,:,:) + value);
elseif strcmp(type, "Minus")
    image = uint8(I(:,:,:) - value);
elseif strcmp(type, "Multiply")
    image = uint8(I(:,:,:) * value);
elseif strcmp(type, "Divide")
    image = uint8(I(:,:,:) / value);
end

end