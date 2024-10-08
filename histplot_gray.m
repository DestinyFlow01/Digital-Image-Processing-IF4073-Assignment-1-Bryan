function hist_result = histplot_gray(image) 
    [a,b,c] = size(image);
    %Keeping numbers for histogram :
    image_new = uint8(floor(image));
    hist_result = zeros(256,1);         %From 0 to 255, assumed it to be 8-bit image
    
    for i = 1:a
        for j = 1:b
            hist_result(image_new(i,j,1)+1) = hist_result(image_new(i,j,1)+1) + 1;
        end
    end
end