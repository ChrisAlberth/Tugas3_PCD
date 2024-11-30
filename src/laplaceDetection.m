function result = laplaceDetection(image)
    H = [1 1 1; 1 -8 1; 1 1 1];
    I = im2gray(image);
    result = uint8(convn(double(I), double(H)));
    result = result(2:end-1, 2:end-1);
end