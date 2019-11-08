function [result] = nonLocalMeans_naive(image, sigma, h, patchSize, searchWindowSize)

%REPLACE THIS

image = double(image);
shape = size(image);

if mod(patchSize, 2) ~= 0 % odd
    d = 0;
else
    d = 1; % even
end

pB = floor(patchSize/2); % patchBound
sWB = floor(searchWindowSize/2); % searchWindowBound

% Replicate edge pixels with patch radius, 
% and pad white pixels for serarch window, to penalize if searching patch outside the image
image = padarray(image,[pB pB],'replicate'); % or symmetric
image = padarray(image,[sWB sWB]);

% initialise distances (1 * searchWindowSize^2)
distances = zeros(1, searchWindowSize*searchWindowSize);

result = zeros(shape);

for Y = 1: shape(1)
    for X = 1: shape(2)
        
        n = 1;
        for x = 1: searchWindowSize
            for y = 1: searchWindowSize
                centrePatch = image(Y+sWB: Y+sWB+2*pB-d, X+sWB: X+sWB+2*pB-d, :);
                otherPatch = image(Y+(y-1): Y+(y-1)+2*pB-d, X+(x-1): X+(x-1)+2*pB-d, :);
                
                % (1 * searchWindowSize^2), SSD
                distances(1, n) = sum(sum(sum((centrePatch - otherPatch).^2)));
                n = n+1;
            end
        end
        
        % (1 * searchWindowSize^2)
        weights = computeWeighting(distances, h, sigma, patchSize);
        sumWeights = sum(weights);
        
        % (searchWindowSize^2 * 1)
        currentWin = image(Y+pB: Y+pB+searchWindowSize-1, X+pB: X+pB+searchWindowSize-1, :);
        currentWin = reshape(currentWin, [searchWindowSize*searchWindowSize, 3]);
        
        for k = 1: 3           
            result(Y, X, k) = weights*currentWin(:, k)/sumWeights;
        end
        
    end
end

result = uint8(result);

end