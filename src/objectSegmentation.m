function result = objectSegmentation(image, image_edge)
    image_edge(1, :, :) = 0;
    image_edge(end, :, :) = 0;
    image_edge(:, 1, :) = 0;
    image_edge(:, end, :) = 0;

    closed_edge = imclose(image_edge, strel('line', 5, 0));
    %disp(closed_edge);
    %figure, imshow(closed_edge);

    filled_segment = imfill(closed_edge, "holes");
    %figure, imshow(filled_segment);

    open_segment = imopen(closed_edge, strel(ones(2, 2)));
    %figure, imshow(open_segment);
    
    removed_bw = bwareaopen(closed_edge, 5000);
    %figure, imshow(removed_bw);

    red_channel = image(:,:,1).*uint8(removed_bw);
    green_channel = image(:,:,2).*uint8(removed_bw);
    blue_channel = image(:,:,3).*uint8(removed_bw);

    result = cat(3, red_channel, green_channel, blue_channel);
    %figure, imshow(result);
end