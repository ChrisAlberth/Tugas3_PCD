function result = cannyDetection(image)
    image_edge = edge(im2gray(image), 'canny');
    result = uint8(image_edge) * 255;
end