function result = logDetection(image)
    I = im2gray(image);
    h = fspecial('log');
    result = uint8(convn(double(I), double(h)));
    result = result(3:end-2, 3:end-2);
end