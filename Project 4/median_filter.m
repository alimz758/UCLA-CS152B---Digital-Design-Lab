function [ median_filtered ] = median_filter( noisy_image )
    %READ AN 2D IMAGE
    image = imread(noisy_image);
    title('Image before Median Filtering');
    figure;imshow(noisy_image);
    %PAD THE MATRIX WITH ZEROS ON ALL SIDES
    noisy_image_padded = zeros(size(noisy_image)+2);
    median_filtered = zeros(size(noisy_image));

    %COPY THE ORIGINAL IMAGE MATRIX TO THE PADDED MATRIX
    for x=1:size(noisy_image, 1)
        for y=1:size(noisy_image, 2)
            noisy_image_padded(x+1, y+1) = noisy_image(x,y);
        end
    end
       
    for i=1:size(noisy_image_padded, 1) - 2
        for j=1:size(noisy_image_padded, 2) - 2
            window = zeros(9,1);
            window_counter = 1;
            for x=1:3
                for y=1:3
                    window(window_counter) = noisy_image_padded(i+x-1, j+y-1);
                    window_counter = window_counter+1;
                end
            end
            med = sort(window);
            median_filtered(i,j) = med(5);
        end
    end
    median_filtered = uint8(median_filtered);
    title('Image after Median Filtering');
    figure;imshow(median_filtered);
end