function [image_new, Transform_Mapping] = image_hist_equalization(image, mode)
    %Obtaining histogram
    [a,b,c] = size(image);

    if mode == "Gray Image"
        histogram_gray = histplot_gray(image);
        sum_gray = sum(histogram_gray);
        histogram_gray = histogram_gray/sum_gray;
    elseif mode == "RGB Image"
        [histogram_red, histogram_green, histogram_blue] = histplot_rgb(image);
        sum_red = sum(histogram_red); sum_green = sum(histogram_green); sum_blue = sum(histogram_blue);
        histogram_red = histogram_red/sum_red;
        histogram_green = histogram_green/sum_green;
        histogram_blue = histogram_blue/sum_blue;
    end

    %Defining the corresponding transformation mapping using CDF, assuming 256 levels of gray
    Transform_Mapping = zeros(256,size(image,3));

    if mode == "Gray Image"
        for i = 1:256
            sum_gray = sum(histogram_gray(1:i));
            Transform_Mapping(i) = floor(255*sum_gray);
        end
    elseif mode == "RGB Image"
        for i = 1:256
            sum_red = sum(histogram_red(1:i));
            Transform_Mapping(i,1) = floor(255*sum_red);

            sum_green = sum(histogram_green(1:i));
            Transform_Mapping(i,2) = floor(255*sum_green);

            sum_blue = sum(histogram_blue(1:i));
            Transform_Mapping(i,3) = floor(255*sum_blue);
        end
    end

    %Updating the image with the corresponding transformation
    image_new = image;
    if mode == "Gray Image"
        for i = 1:size(image,1)
            for j = 1:size(image,2)
                image_new(i,j) = Transform_Mapping(image(i,j) + 1);
            end
        end
    elseif mode == "RGB Image"
        for i = 1:size(image,1)
            for j = 1:size(image,2)
                image_new(i,j,1) = Transform_Mapping(image(i,j,1) + 1,1);
                image_new(i,j,2) = Transform_Mapping(image(i,j,2) + 1,2);
                image_new(i,j,3) = Transform_Mapping(image(i,j,3) + 1,3);
            end
        end
        
    end

end