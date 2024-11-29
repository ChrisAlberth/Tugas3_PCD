function result = cannyDetection(image)
    I = imread(image);
    imshow(I);

    result = edge(im2gray(I), 'canny');
    figure, imshow(result);
end