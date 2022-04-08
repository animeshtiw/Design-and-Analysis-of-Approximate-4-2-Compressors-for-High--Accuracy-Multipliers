lena = imread('lena.tif');
camera = imread('cameraman.tif');

result = (0.3)*lena + (0.7)*camera;


imshow(mat2gray(result));