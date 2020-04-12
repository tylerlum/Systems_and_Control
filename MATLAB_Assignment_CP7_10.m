%% MATLAB Assignment CP7.10 b)

% Plot poles and zeros of closed loop with compensation
k = -2;
numerator = [1];
denominator = [1, 2+k, 5, 1];
plotZeroPoles(numerator, denominator, 'CP7.10 b) Pole Zero Plot When k = -2');

function plotZeroPoles(num, den, titleText)
    [zz, pp, kk] = tf2zp(num, den);
    plot = figure;
    pzmap(pp, zz);
    title(titleText);
    uiwait(plot);
end