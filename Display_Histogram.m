function Display_Histogram(image, mode)
    %Displaying histogram
    if mode == "Gray Image"
        hist_result = histplot_gray(image);
        figure;
        for i = 1:size(hist_result,1)
            x = [i-1, i-1];
            y = [0, hist_result(i)];
            line(x,y, 'Color', 'blue');
        end
        title('Histogram for grayscale image');
        xlim([0 255])
    elseif mode == "RGB Image"
        [hist_red, hist_green, hist_blue] = histplot_rgb(image);

        figure;
        for i = 1:size(hist_red,1)
            x = [i-1, i-1];
            y = [0, hist_red(i)];
            line(x,y, 'Color', 'blue');
        end
        title('Histogram for RGB image : Red');
        xlim([0 255])
    
        figure;
        for i = 1:size(hist_green,1)
            x = [i-1, i-1];
            y = [0, hist_green(i)];
            line(x,y, 'Color', 'blue');
        end
        title('Histogram for RGB image : Green');
        xlim([0 255])
        
        figure;
        for i = 1:size(hist_blue,1)
            x = [i-1, i-1];
            y = [0, hist_blue(i)];
            line(x,y, 'Color', 'blue');
        end
        title('Histogram for RGB image : Blue');
        xlim([0 255])
    end
end