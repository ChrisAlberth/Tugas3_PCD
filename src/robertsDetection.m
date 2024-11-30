function result = robertsDetection(image)
    I = im2gray(image);

    % Roberts mask
    Rx = [1 0; 0 -1];
    Ry = [0 1; -1 0];

    % Convolution with mask
    Jx = conv2(double(I), double(Rx), 'same');
    Jy = conv2(double(I), double(Ry), 'same');

    % Build image edge from convolution result
    Jedge = sqrt(Jx.^2 + Jy.^2);
    result = uint8(Jedge);
end