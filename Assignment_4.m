%% Assignment 4 Problem 2

% b)
% Constants from question
E = 0.42;
Ts = 2;
wn = 4 / (E * Ts);
wf = 0.22 * wn;

% Open Loop Bode Plot
numerator = [wn^2];
denominator = [1, 2*wn*E, wn^2];
bodePlot(numerator, denominator, '2b) Open Loop Bode Plot');

% Compensated System Bode Plot
numerator = [wn^2];
denominator = [1, 2*wn*E, wn^2, 0];
bodePlot(numerator, denominator, '2b) Compensated System Bode Plot');

% Plot poles and zeros of closed loop with compensation
numerator = [wn^2];
denominator = [1, 2*wn*E, wn^2, wn^2];
plotZeroPoles(numerator, denominator, '2d) Closed Loop Compensated System Pole Zero Plot');

function plotZeroPoles(num, den, titleText)
    [zz, pp, kk] = tf2zp(num, den);
    plot = figure;
    pzmap(pp, zz);
    title(titleText);
    uiwait(plot);
end

function bodePlot(num, den, titleText)
    plot = figure;
    bode(tf(num, den));
    title(titleText);
    uiwait(plot);   
end
