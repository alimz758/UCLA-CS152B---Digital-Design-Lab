function [ high_pass ] = low_pass_filter( image )
    % Detailed explanation goes here
    image_matrix = imread(image);
    title('Image before High-pass Filtering');
    figure;imshow(image);
    image_matrix = double(rgb2gray(image_matrix));
    sigma = 9;
    sizei = 101;
    [x,y] = meshgrid(-sizei/2:sizei/2, -sizei/2:sizei/2);
    constant = 1/(2*pi*sigma*sigma);
    kernel = constant*exp( -(y.^2 + x.^2 )/(2 * sigma * sigma));
    % Normalize
    kernel = kernel/sum(kernel(:));
    image_matrix_low = conv2(image_matrix, kernel, 'same');
    F = fft2(image_matrix_low);
    image_matrix2 = fft2(image_matrix);   
    image_matrix2_high = image_matrix2 - F;
    high_pass = ifft2(image_matrix2_high);
    title('Image after High-pass Filtering');
    figure; imshow(high_pass, []);
end

 % used https://stackoverflow.com/questions/48260691/creating-a-high-pass-filter-in-matlab