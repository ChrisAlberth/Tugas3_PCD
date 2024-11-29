function result = objectSegmentation(image, image_edge)
    I = imread(image);

    closed_edge = imclose(image_edge, strel('line', 15, 0));
    figure, imshow(closed_edge);
    
    filled_segment = imfill(closed_edge, "holes");
    figure, imshow(filled_segment);

    open_segment = imopen(filled_segment, strel(ones(4, 4)));
    figure, imshow(open_segment);
    
    removed_bw = bwareaopen(open_segment, 5000);
    figure, imshow(removed_bw);

    red_channel = I(:,:,1).*uint8(removed_bw);
    green_channel = I(:,:,2).*uint8(removed_bw);
    blue_channel = I(:,:,3).*uint8(removed_bw);

    result = cat(3, red_channel, green_channel, blue_channel);
    figure, imshow(result);
end