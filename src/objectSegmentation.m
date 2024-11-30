function result = objectSegmentation(image, image_edge)
    % Change border color to black
    image_edge(1, :, :) = 0;
    image_edge(end, :, :) = 0;
    image_edge(:, 1, :) = 0;
    image_edge(:, end, :) = 0;
    
    % Change from grayscale to binary
    binarized_edge = imbinarize(image_edge);
    
    % Removing small pixel (not the object)
    binarized_edge = bwareaopen(binarized_edge, 12);
    binarized_edge = imopen(binarized_edge, ones(1, 1));
    
    % Close the edge of the object
    closed_edge = imclose(binarized_edge, strel('disk', 22));
    
    % Fill the object segment
    totalPixel = numel(closed_edge);
    whitePixel = sum(closed_edge(:));
    if (whitePixel/totalPixel) > 0.73
        filled_segment = imcomplement(closed_edge);
    else
        filled_segment = imfill(closed_edge, "holes");
    end
    
    % Remove small pixel again
    open_segment = imopen(filled_segment, strel('disk', 5));
    removed_bw = bwareaopen(open_segment, 1000);
    
    if size(image, 3) == 3
        red_channel = image(:,:,1).*uint8(removed_bw);
        green_channel = image(:,:,2).*uint8(removed_bw);
        blue_channel = image(:,:,3).*uint8(removed_bw);

        result = cat(3, red_channel, green_channel, blue_channel);
    else
        result = image.*uint8(removed_bw);
    end
end