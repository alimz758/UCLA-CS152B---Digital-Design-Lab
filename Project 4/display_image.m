new_image = dlmread("up.txt", ',');
l = length(new_image);
%n = length(noisy);
new_image2 = reshape(new_image, [410*3, 361*3]);
new_image2 = transpose(new_image2);
imshow(new_image2,[]);
