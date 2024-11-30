function result = sobelDetection(image)
    I = im2gray(image);
    Sx = [-1 0 1; -2 0 2; -1 0 1];
    Sy = [1 2 1; 0 0 0; -1 -2 -1];
    Jx = convn(double(I), double(Sx), 'same');
    Jy = convn(double(I), double(Sy), 'same');
    Jedge = sqrt(Jx.^2 + Jy.^2);
    result = uint8(Jedge);
end