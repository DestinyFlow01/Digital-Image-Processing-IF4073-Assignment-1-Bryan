function [hist_red, hist_green, hist_blue] = histplot_rgb(image) 
    [a,b,c] = size(image);
    %Keeping numbers for histogram :
    image_new = uint8(floor(image));
    hist_red = zeros(256,1);            %From 0 to 255, assumed it to be 8-bit image
    hist_green = zeros(256,1);          %From 0 to 255, assumed it to be 8-bit image
    hist_blue = zeros(256,1);           %From 0 to 255, assumed it to be 8-bit image

    
    for i = 1:a
        for j = 1:b
            hist_red(image_new(i,j,1)+1) = hist_red(image_new(i,j,1)+1) + 1;
            hist_green(image_new(i,j,2)+1) = hist_green(image_new(i,j,2)+1) + 1;
            hist_blue(image_new(i,j,3)+1) = hist_blue(image_new(i,j,3)+1) + 1;
        end
    end
end