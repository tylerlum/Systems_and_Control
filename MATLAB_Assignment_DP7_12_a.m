%% MATLAB Assignment DP7.12 a)

% Plot Root Locus
numerator = [1, 3];
denominator = [1, 15, 70, 120, 64];
plotRootLocus(numerator, denominator, 'DP7.12 a) Root Locus Plot');

% Find roots for K = 100, 300, 600
for K = [100, 300, 600]
    polynomial = [1, 15, 70, (120+K), (64 + 3*K)];
    title = sprintf('DP7.12 a) Roots for K = %f', K);
    plotRoots(polynomial, title);
end

function plotRootLocus(num, den, titleText)
    sys = tf(num, den);
    plot = figure;
    rlocus(sys);
    title(titleText);
    uiwait(plot);
end

function plotRoots(den, titleText)
    [zz, pp, kk] = tf2zp([1], den);

    plot = figure;
    pzmap(pp, zz);
    title(titleText);
    uiwait(plot);
end
