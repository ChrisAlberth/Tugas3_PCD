function result = logDetection(image)
    I = im2gray(image);

    % LoG mask
    h = fspecial('log');

    % Convolution with mask
    result = uint8(conv2(double(I), double(h)));

    % Remove extra pixels to match original size
    result = result(3:end-2, 3:end-2);
end