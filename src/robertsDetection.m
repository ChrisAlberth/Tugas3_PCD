function result = robertsDetection(image)
    I = im2gray(image);
    Rx = [1 0; 0 -1];
    Ry = [0 1; -1 0];
    Jx = convn(double(I), double(Rx), 'same');
    Jy = convn(double(I), double(Ry), 'same');
    Jedge = sqrt(Jx.^2 + Jy.^2);
    result = uint8(Jedge);
end