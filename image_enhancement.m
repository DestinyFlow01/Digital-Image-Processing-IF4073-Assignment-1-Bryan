function [image_new] = image_enhancement(image, mode, image_mode)
    %Assuming 8 bit image 
    image_new = image;
    if mode == "Image brightening"
        fprintf('Image brightening is requested with transformation s = ar + b\n');
        a = input('Value for a = ');
        b = input('Value for b = ');
        fprintf('Input value for a is %.3f\n', a);
        fprintf('Input value for b is %.3f\n', b);

        image_new = b + a*image;
    elseif mode == "Negative Image"
        fprintf('Negative image is requested\n');
        
        if image_mode == "RGB Image"
            image_new(:,:,1) = 255 - image(:,:,1);
            image_new(:,:,2) = 255 - image(:,:,2);
            image_new(:,:,3) = 255 - image(:,:,3);
        elseif image_mode == "Gray Image"
            image_new = 255 - image;
        end

    elseif mode == "Log Transformation"
        fprintf('Log transformation is requested with transformation s = c log(l+r)\n');
        c = input('Value for c = ');
        fprintf('Input value for c is %.3f\n', c);

        image = im2double(image);
        image_new = c*log(image + 1);
    elseif mode == "Power Transformation"
        fprintf('Power transformation is requested with transformation s = cr^b\n');
        c = input('Value for c = ');
        b = input('Value for b = ');
        fprintf('Input value for c is %.3f\n', c);
        fprintf('Input value for b is %.3f\n', b);

        image = im2double(image);
        image_new = c*image.^b;
    elseif mode == "Contrast Stretching"
        fprintf('Contrast stretching is requested\n');
        rmin = min(min(image)); rmax = max(max(image));

        %Applying contrast stretching for each color :
        if image_mode == "Gray Image"
            image_new = (image - rmin).*(255/(rmax - rmin));
        elseif image_mode == "RGB Image"
            for i = 1:size(image, 3)
                image_new(:,:,i) = (image(:,:,i) - rmin(:,:,i)).*(255/(rmax(:,:,i) - rmin(:,:,i)));
            end
        end        
    end
    
    
end