%% MATLAB Assignment CP8.6

% a) Setup loop transfer function
numerator = [40];
denominator = [1, 4, 44, 80];
title = 'CP8.6 Bode Plot of Loop Transfer Function';
bodePlot(numerator, denominator, title);

% b) Setup closed loop transfer function
numerator = [40];
denominator = [1, 4, 44, 120];
title = 'CP8.6 Bode Plot of Closed Loop Transfer Function';
bodePlot(numerator, denominator, title);

function bodePlot(num, den, titleText)
    plot = figure;
    bode(tf(num, den));
    title(titleText);
    uiwait(plot);   
end