function result = logDetection(image)
    I = imread(image);
    figure, imshow(I);
    I = im2gray(I);
    h = fspecial('log');
    result = uint8(convn(double(I), double(h)));
    figure, imshow(result);
end