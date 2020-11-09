function [ noise_image ] = add_noise( image , black , white , range )
    % Detailed explanation goes here
    g_image = rgb2gray(image); %balck and white the image
    imwrite(g_image , '../grey_image.jpeg');
    [ y , x ] = size(g_image); % create a matrix of size image
    random_value = randi(y , x , [0 range]);
    noise_image = g_image;
    for i = 1 : y
        for j = 1 : x
            if ( random_value(i , j) <= black )
                noise_image(i , j) = 0;
            end
            if ( random_value(i , j) >= white )
                noise_image (i , j) = range;
            end
        end
    end
    nn_image = noise_image';
    n_image = nn_image(:)';
    figure(1); imshow(noise_image);
    imwrite(noise_image , '../noisy_image.jpeg');
    nn_image = reshape(n_image , [ 1 , 410*361]); 
    dlmwrite('../noisy_image.text' , nn_image);
end