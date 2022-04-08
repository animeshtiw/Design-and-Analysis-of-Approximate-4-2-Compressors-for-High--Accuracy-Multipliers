lena = imread('lena.tif');
camera = imread('cameraman.tif');

blended = zeros(256,256);

for i=1:256
    for j=1:256
        blended(i,j) = multiplier(7, lena(i,j))/10 + multiplier(3, camera(i,j))/10; 
    end
end

%imshow(mat2gray(blended));

result = (0.7)*lena + (0.3)*camera;

squaredErrorImage = (double(result) - double(blended)) .^ 2;
mse = sum(sum(squaredErrorImage)) / (256 * 256);
PSNR = 10 * log10( 256^2 / mse);