function [result] = computeWeighting(d, h, sigma, patchSize)
    %Implement weighting function from the slides
    %Be careful to normalise/scale correctly!
    
    %REPLACE THIS
    
    distances = d/(3*patchSize^2);
    
    result = exp(-max(distances - 2*sigma, 0)/((sigma*h)^2));
end



