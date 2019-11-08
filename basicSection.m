%% Some parameters to set - make sure that your code works at image borders!

% Row and column of the pixel for which we wish to find all similar patches 
% NOTE: For this section, we pick only one patch
row = 2;
col = 2;

% Patchsize - make sure your code works for different values
patchSize = 3;

% Search window size - make sure your code works for different values
searchWindowSize = 9;


%% Implementation of work required in your basic section-------------------

% TODO - Load Image
image = double(imread('images/alleyNoisy_sigma20.png'));

% TODO - Fill out this function
image_ii = computeIntegralImage(image);

% TODO - Display the normalised Integral Image
% NOTE: This is for display only, not for template matching yet!
figure('name', 'Normalised Integral Image');
normalIntegral = (image_ii-min(min(image_ii)))./(max(max(image_ii))-min(min(image_ii)));
imshow(normalIntegral);

tic
% TODO - Template matching for naive SSD (i.e. just loop and sum)
[offsetsRows_naive, offsetsCols_naive, distances_naive] = templateMatchingNaive(image, row, col,...
    patchSize, searchWindowSize);
toc

tic
% TODO - Template matching using integral images
[offsetsRows_ii, offsetsCols_ii, distances_ii] = templateMatchingIntegralImage(image, row, col,...
    patchSize, searchWindowSize);
toc

%% Let's print out your results--------------------------------------------

% NOTE: Your results for the naive and the integral image method should be
% the same!
for i=1:length(offsetsRows_naive)
    for j=1:length(offsetsRows_naive)
    disp(['offset rows: ', num2str(offsetsRows_naive(i,j)), '; offset cols: ',...
        num2str(offsetsCols_naive(i,j)), '; Naive Distance = ', num2str(distances_naive(i,j),10),...
        '; Integral Im Distance = ', num2str(distances_ii(i,j),10)]);
    end
end