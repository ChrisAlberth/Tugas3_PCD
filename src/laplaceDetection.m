function result = laplaceDetection(image)
    % Laplace mask
    H = [1 1 1; 1 -8 1; 1 1 1];
    I = im2gray(image);

    % Convolution with mask
    result = uint8(conv2(double(I), double(H)));
    
    % Remove extra pixels to match original size
    result = result(2:end-1, 2:end-1);
end