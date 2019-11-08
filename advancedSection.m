%% Some parameters to set - make sure that your code works at image borders!
patchSize = 3;
sigma = 20; % standard deviation (different for each image!)
h = 0.78; %decay parameter
windowSize = 11;

%TODO - Read an image (note that we provide you with smaller ones for
%debug in the subfolder 'debug' int the 'image' folder);
%Also unless you are feeling adventurous, stick with non-colour
%images for now.
%NOTE: for each image, please also read its CORRESPONDING 'clean' or
%reference image. We will need this later to do some analysis
%NOTE2: the noise level is different for each image (it is 20, 10, and 5 as
%indicated in the image file names)

%REPLACE THIS
imageNoisy = imread('images/alleyNoisy_sigma20.png');
imageReference = imread('images/alleyReference.png');

%imageNoisy = imread('images/townNoisy_sigma5.png');
%imageReference = imread('images/townReference.png');

%imageNoisy = imread('images/treesNoisy_sigma10.png');
%imageReference = imread('images/treesReference.png');

tic;
%TODO - Implement the non-local means function
filtered = nonLocalMeans_integral(imageNoisy, sigma, h, patchSize, windowSize);
%filtered = nonLocalMeans_naive(imageNoisy, sigma, h, patchSize, windowSize);
toc

%% Let's show your results!

subplot(2,2,1), imshow(imageReference), title('Image Reference');
subplot(2,2,2), imshow(imageNoisy), title('Image Noisy');

%Show the denoised image
subplot(2,2,3), imshow(filtered), title('NL-Means Denoised Image');
% imwrite(filtered, 'alleyDenoised.jpg');

%Show difference image
diff_image = abs(double(imageNoisy) - double(filtered));
diff_image = diff_image ./max(max((diff_image)));
subplot(2,2,4), imshow(diff_image), title('Difference Image');


%Print some statistics ((Peak) Signal-To-Noise Ratio)
disp('For Noisy Input');
[peakSNR, SNR] = psnr(imageNoisy, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

disp('For Denoised Result');
[peakSNR, SNR] = psnr(filtered, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

%Feel free (if you like only :)) to use some other metrics (Root
%Mean-Square Error (RMSE), Structural Similarity Index (SSI) etc.)
