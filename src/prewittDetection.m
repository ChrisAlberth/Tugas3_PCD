function result = prewittDetection(image)
    I = imread(image);
    figure, imshow(I);
    I = im2gray(I);
    Sx = [-1 0 1; -1 0 1; -1 0 1];
    Sy = [-1 -1 -1; 0 0 0; 1 1 1];
    Jx = convn(double(I), double(Sx), 'same');
    Jy = convn(double(I), double(Sy), 'same');
    Jedge = sqrt(Jx.^2 + Jy.^2);
    result = uint8(Jedge);
    figure, imshow(result);
end