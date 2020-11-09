function [ low_pass ] = low_pass_filter( image )
    % Detailed explanation goes here
    low_pass = imread(image)
    title('Image before Low-pass Filtering');
    figure,imshow(image);
    for i=2:r-1
        for j=2:c-1
            flt = [low_pass(i-1, j-1), low_pass(i-1, j), low_pass(i-1, j+1),
            low_pass(i, j-1), low_pass(i, j), low_pass(i, j+1),
            low_pass(i+1, j-1), low_pass(i+1, j),low_pass(i+1, j+1)];
            low_pass(i,j) = median(flt);
        end
    end
    title('Image After Low-pass Filtering');
    figure,imshow(low_pass);
end