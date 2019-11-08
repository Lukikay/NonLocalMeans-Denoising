function [offsetsRows, offsetsCols, distances] = templateMatchingNaive(image, row, col,...
    patchSize, searchWindowSize)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)
% offsetsRows(1) = -1;
% offsetsCols(1) = -1;
% distances(1) = 0.125;

% The distance is simply the SSD over patches of size patchSize between the
% 'template' patch centred at row and col and a patch shifted by the
% current offset

%REPLACE THIS

%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
image = double(imread('images/alleyNoisy_sigma20.png'));
row = 2;
col = 2;
patchSize = 5;
searchWindowSize = 9;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%}

if mod(searchWindowSize, 2) ~= 0
    offsetBound = ceil(searchWindowSize/2); % odd
else
    offsetBound = searchWindowSize/2+1; % even
end

% patch size
if mod(patchSize, 2) ~= 0 % odd
    d = 0;
else
    d = 1; % even
end

pB = floor(patchSize/2); % patchBound
sWB = floor(searchWindowSize/2); % searchWindowBound

distances = zeros(searchWindowSize, searchWindowSize, 3);

image = padarray(image,[pB pB],'replicate'); % or symmetric
image = padarray(image,[sWB sWB]);

for y = 1: searchWindowSize
    for x = 1: searchWindowSize
        centrePatch = image(row+sWB: row+sWB+2*pB-d, col+sWB: col+sWB+2*pB-d, :);
        otherPatch = image(row+(y-1): row+(y-1)+2*pB-d, col+(x-1): col+(x-1)+2*pB-d, :);
        distances(y, x, :) = sum(sum((centrePatch - otherPatch).^2)); % SSD
    end
end

distances = sum(distances, 3)/(3*patchSize^2);

[offsetsCols, offsetsRows] = meshgrid(1:searchWindowSize, 1:searchWindowSize);
offsetsCols = offsetsCols - offsetBound;
offsetsRows = offsetsRows - offsetBound;

end


%{
No pad array:

for y = 1: searchWindowSize
    for x = 1: searchWindowSize
        centrePatch = image(row-pB: row+pB, col-pB: col+pB, :);
        otherPatch = image(row+(y-1)-sWB-pB: row+(y-1)-sWB+pB, col+(x-1)-sWB-pB: col+(x-1)-sWB+pB, :);
        distances(y, x,:) = sum(sum((centrePatch - otherPatch).^2)); % SSD
    end
end
%}