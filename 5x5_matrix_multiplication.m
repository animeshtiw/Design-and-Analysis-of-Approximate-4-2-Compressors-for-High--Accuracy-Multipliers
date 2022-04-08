clc;
clear all;
%a = de2bi(5,8,'right-msb');
%b = de2bi(1,8,'right-msb');
%pp4 = multiplier(a,b);

lena = imread('lena.tif');
lena_resize = imresize(lena, 0.5);
%mat1_dec = [1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;21,22,23,24,25];
%mat1_bin = de2bi(lena,8,'right-msb');
%mat2_dec = [1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;21,22,23,24,25];
%mat2_bin = de2bi(camera,8,'right-msb');
camera = imread('cameraman.tif');
camera_resize = imresize(camera, 0.5);
for i=1:128
    for j=1:128
        mul(i,j)=0;
        for k=1:128
            mul(i,j) = mul(i,j) + multiplier(lena_resize(i,k), camera_resize(k,j));
        end
    end
end
