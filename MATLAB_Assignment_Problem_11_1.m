%% MATLAB Assignment Problem 11.1

% Plot Root Locus as parameter alpha
numerator = [1, 1, 0];
denominator = [1, 1, 0, 1];
plotRootLocus(numerator, denominator, 'Problem 11.1 Root Locus Plot');

function plotRootLocus(num, den, titleText)
    sys = tf(num, den);
    plot = figure;
    rlocus(sys);
    title(titleText);
    uiwait(plot);
end