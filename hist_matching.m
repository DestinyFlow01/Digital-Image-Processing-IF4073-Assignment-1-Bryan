function image_new = hist_matching(image, image_ref, mode) 
    if mode == "Gray Image"
        c = 1;
        %Histogram equalization for image
        image_equalized = image_hist_equalization(image, mode);
        hist_image = histplot_gray(image_equalized);
        hist_image = hist_image/sum(hist_image);
        
        %Histogram equalization for reference image
        image_equalized_ref = image_hist_equalization(image_ref, mode);
        hist_ref = histplot_gray(image_equalized_ref);
        hist_ref = hist_ref/sum(hist_ref);
    elseif mode == "RGB Image"
        c = 3;
        %Histogram equalization for image
        image_equalized = image_hist_equalization(image, mode);
        [hist_image_red, hist_image_green, hist_image_blue] = histplot_rgb(image_equalized);
        hist_image_red = hist_image_red/sum(hist_image_red); 
        hist_image_green = hist_image_green/sum(hist_image_green); 
        hist_image_blue = hist_image_blue/sum(hist_image_blue);
        
        %Histogram equalization for reference image
        image_equalized_ref = image_hist_equalization(image_ref, mode);
        [hist_ref_red, hist_ref_green, hist_ref_blue] = histplot_rgb(image_equalized_ref);
        hist_ref_red = hist_ref_red/sum(hist_ref_red); 
        hist_ref_green = hist_ref_green/sum(hist_ref_green); 
        hist_ref_blue = hist_ref_blue/sum(hist_ref_blue);

    end

    %Obtaining inverse transformation
    Inv_Transform = zeros(256,c);
    
    if mode == "Gray Image"
        for i = 1:256
            minval = abs(hist_image(i) - hist_ref(1));
            minj = 1;
    
            for j = 1:256
                if abs(hist_image(i) - hist_ref(j)) < minval
                    minval = abs(hist_image(i) - hist_ref(j));
                    minj = j;
                end
            end
            Inv_Transform(i) = minj;
        end
    elseif mode == "RGB Image"
        for i = 1:256
            minval_red = abs(hist_image_red(i) - hist_ref_red(1));
            minval_green = abs(hist_image_green(i) - hist_ref_green(1));
            minval_blue = abs(hist_image_blue(i) - hist_ref_blue(1));
            minj_red = 1; minj_green = 1; minj_blue = 1;
    
            for j = 1:256
                if abs(hist_image_red(i) - hist_ref_red(j)) < minval_red
                    minval_red = abs(hist_image_red(i) - hist_ref_red(j));
                    minj_red = j;
                end

                if abs(hist_image_green(i) - hist_ref_green(j)) < minval_green
                    minval_green = abs(hist_image_green(i) - hist_ref_green(j));
                    minj_green = j;
                end

                if abs(hist_image_blue(i) - hist_ref_blue(j)) < minval_blue
                    minval_blue = abs(hist_image_blue(i) - hist_ref_blue(j));
                    minj_blue = j;
                end
            end
            Inv_Transform(i,1) = minj_red;
            Inv_Transform(i,2) = minj_green;
            Inv_Transform(i,3) = minj_blue;
        end
    end
    

    

    %Inverse transformation of mapping
    image_new = image;
    if mode == "Gray Image"
        image_new(:,:) = Inv_Transform(image(:,:) + 1);
    elseif mode == "RGB Image"
        image_new(:,:,1) = Inv_Transform(image(:,:,1) + 1,1);
        image_new(:,:,2) = Inv_Transform(image(:,:,2) + 1,2);
        image_new(:,:,3) = Inv_Transform(image(:,:,3) + 1,3);
    end
end