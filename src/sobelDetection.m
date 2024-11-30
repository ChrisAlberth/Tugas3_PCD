function result = sobelDetection(image)
    I = im2gray(image);

    % Sobel mask
    Sx = [-1 0 1; -2 0 2; -1 0 1];
    Sy = [1 2 1; 0 0 0; -1 -2 -1];

    % Convolution with mask
    Jx = conv2(double(I), double(Sx), 'same');
    Jy = conv2(double(I), double(Sy), 'same');

    % Build image edge from convolution result
    Jedge = sqrt(Jx.^2 + Jy.^2);
    result = uint8(Jedge);
end