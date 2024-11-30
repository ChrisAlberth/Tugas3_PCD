function outputImage = lineDetection(frame)
    %------------------Reading each frame from Video File------------------
    % figure('Name','Original Image'), imshow(frame);
    frame = imgaussfilt3(frame);
    % figure('Name','Filtered Image'), imshow(frame);
        
    
    % Convert the image to HSV color space
    hsvFrame = rgb2hsv(frame);
    
    % -------------- Define Thresholds for Masking Yellow Color --------------
    
    % ---------------------- Define thresholds for 'Hue' ---------------------
    % Yellow hue is typically around 50 to 60 degrees in HSV color space
    channel1MinY = 0.05;  % Corresponds to ~50° in hue (normalized from 0 to 1)
    channel1MaxY = 0.23;  % Corresponds to ~60° in hue
    
    % ------------------ Define thresholds for 'Saturation' ------------------
    channel2MinY = 0.4;   % Minimum saturation for yellow
    channel2MaxY = 1;     % Maximum saturation for yellow
    
    % --------------------- Define thresholds for 'Value' --------------------
    channel3MinY = 0.5;   % Minimum brightness for yellow
    channel3MaxY = 1;     % Maximum brightness for yellow
    
    % ----------- Create mask based on chosen histogram thresholds -----------
    Yellow = (hsvFrame(:,:,1) >= channel1MinY) & (hsvFrame(:,:,1) <= channel1MaxY) & ...
             (hsvFrame(:,:,2) >= channel2MinY) & (hsvFrame(:,:,2) <= channel2MaxY) & ...
             (hsvFrame(:,:,3) >= channel3MinY) & (hsvFrame(:,:,3) <= channel3MaxY);
         
    %figure('Name','Yellow Mask'), imshow(Yellow);
    
    % -------------- Define Thresholds for Masking White Color --------------
    
    % ---------------------- Define thresholds for 'Hue' ---------------------
    % Hue for white doesn't matter, so you can set it to any value.
    channel1MinW = 0;     % White can have any hue (from 0 to 1)
    channel1MaxW = 1;     % White can have any hue (from 0 to 1)
    
    % ------------------ Define thresholds for 'Saturation' ------------------
    channel2MinW = 0;     % White has low saturation (close to 0)
    channel2MaxW = 0.15;   % Saturation close to 0 (white is desaturated)
    
    % --------------------- Define thresholds for 'Value' --------------------
    channel3MinW = 0.7;   % White has high brightness (value close to 1)
    channel3MaxW = 1;     % Maximum brightness for white
    
    % ----------- Create mask based on chosen histogram thresholds -----------
    White = (hsvFrame(:,:,1) >= channel1MinW) & (hsvFrame(:,:,1) <= channel1MaxW) & ...
            (hsvFrame(:,:,2) >= channel2MinW) & (hsvFrame(:,:,2) <= channel2MaxW) & ...
            (hsvFrame(:,:,3) >= channel3MinW) & (hsvFrame(:,:,3) <= channel3MaxW);
        
    %figure('Name','White Mask'), imshow(White);
    
    
    %imshow(White | Yellow)
    
    E = edge(White | Yellow, 'canny', 0.2);  % Edge detection with adjusted thresholds
    % Get the size of the image
    [rows, cols] = size(E);
    
    % Create a mask to ignore the upper half of the image
    mask = false(rows, cols);
    mask(floor(rows*4/7):end, :) = true;  % Lower half is set to true
    
    % Apply the mask to keep only the lower half
    E = E & mask;
    %figure('Name','Edge'), imshow(E)
    [H, T, R] = hough(E);  % Hough Transform
    % Calculate NHoodSize as half of the Hough matrix dimensions, ensuring it's odd
    [rows, cols] = size(H);
    nhoodRows = 2 * floor(rows / 8) + 1; % Half of rows (rounded down and made odd)
    nhoodCols = 2 * floor(cols / 8) + 1; % Half of cols (rounded down and made odd)
    nhoodSize = [nhoodRows, nhoodCols];
    
    % Find Hough Peaks
    P = houghpeaks(H, 3, "Threshold", ceil(0.3 * max(H(:))), "NHoodSize", nhoodSize);  % Detect peaks
    
    % Hough lines detection
    lines = houghlines(E, T, R, P, 'FillGap', 30, 'MinLength', 20);
    
    % Display results
    fig = figure('visible', 'off');
    imshow(frame), hold on;
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];  % Corrected field names
        plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'green');  % Adjust line width
    end
    
    frameCapture = getframe(fig);
    outputImage = frameCapture.cdata;
    
    % Close the hidden figure
    close(fig);
end