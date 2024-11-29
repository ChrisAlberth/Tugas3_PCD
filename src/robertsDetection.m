function result = robertsDetection(image)
    I = imread(image);
    figure, imshow(I);
    I = im2gray(I);
    Rx = [1 0; 0 -1];
    Ry = [0 1; -1 0];
    Jx = convn(double(I), double(Rx), 'same');
    Jy = convn(double(I), double(Ry), 'same');
    Jedge = sqrt(Jx.^2 + Jy.^2);
    result = uint8(Jedge);
    figure, imshow(result);
end