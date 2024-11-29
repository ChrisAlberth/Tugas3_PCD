function result = laplaceDetection(image)
    I = imread(image);
    figure, imshow(I);
    H = [1 1 1; 1 -8 1; 1 1 1];
    I = im2gray(I);
    result = uint8(convn(double(I), double(H)));
    figure, imshow(result);
end