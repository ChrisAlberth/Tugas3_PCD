function result = cannyDetection(image)
    % Get image edge with default Canny
    image_edge = edge(im2gray(image), 'canny');

    % Convert image type
    result = uint8(image_edge) * 255;
end