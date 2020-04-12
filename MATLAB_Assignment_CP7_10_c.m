%% MATLAB Assignment CP7.10 c)

% Plot Root Locus
k = -2;
numerator = [1, 0, 0];
denominator = [1, 2, 5, 1];
plotRootLocus(numerator, denominator, 'CP7.10 c) Root Locus Plot');

function plotRootLocus(num, den, titleText)
    sys = tf(num, den);
    plot = figure;
    rlocus(sys);
    title(titleText);
    uiwait(plot);
end