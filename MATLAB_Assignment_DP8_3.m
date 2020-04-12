%% MATLAB Assignment DP8.3

%% Plot root locus to show what range of gain values leads to stability
plotRootLocus([5], [1, 7, 12, 10], 'DP8.3 Root Locus');

%% Create Bode Plot for a valid K value
K = 10;
numerator = [K, 5*K];
denominator = [1, 7, 12, 5*K+10];
bodePlot(numerator, denominator, sprintf('DP8.3 Bode Plot for K = %f', K));

% Constants from question
desiredMp = 10^(0.15);
Kmin = -2;
Kmax = 15;

% Plot Mp vs. K
plotMpVsK(Kmin, Kmax, 0.1);

% Search for K with 20logMp = 3 dB
disp('Finding the K such that 20logMp = 3 dB');
[K_best, Mp_best] = findBest(desiredMp, Kmin, Kmax, 1);
[K_best, Mp_best] = findBest(desiredMp, K_best-1, K_best+1, 0.01);
disp(sprintf('Best K: %f. Best Mp (Absolute): %f. Best Mp (db): %f', K_best, Mp_best, 20*log10(Mp_best)));

% Plot bandwidth vs. K
plotBandwidthVsK(Kmin, Kmax, 0.1);

% Display bandwidth at the best K
numerator = [K_best, 5*K_best];
denominator = [1, 7, 12, 5*K_best+10];
thisBandwidth = bandwidth(tf(numerator, denominator));
disp(sprintf('Best K: %f. Bandwidth (rad/s): %f', K_best, thisBandwidth));

function plotMpVsK(Kmin, Kmax, Kdiff)
    KList = Kmin:Kdiff:Kmax;
    MpList = zeros(1, numel(KList));
    for i = 1:numel(KList)
        % Calculate Mp with given K
        K = KList(i);
        numerator = [K, 5*K];
        denominator = [1, 7, 12, 5*K+10];
        Mp = getPeakGain(tf(numerator, denominator));
        MpList(i) = Mp;
    end
    
    plt = figure;
    plot(KList, MpList);
    hold on;
    grid on;
    title('DP8.3 Mp vs. K');
    xlabel('K');
    ylabel('Mp');
    uiwait(plt);
end

function plotBandwidthVsK(Kmin, Kmax, Kdiff)
    KList = Kmin:Kdiff:Kmax;
    bandwidthList = zeros(1, numel(KList));
    for i = 1:numel(KList)
        % Calculate thisBandwidth with given K
        K = KList(i);
        numerator = [K, 5*K];
        denominator = [1, 7, 12, 5*K+10];
        thisBandwidth = bandwidth(tf(numerator, denominator));
        bandwidthList(i) = thisBandwidth;
    end
    
    plt = figure;
    plot(KList, bandwidthList);
    hold on;
    grid on;
    title('DP8.3 Bandwidth vs. K');
    xlabel('K');
    ylabel('Bandwidth');
    uiwait(plt);
end

% Find best K to get desired Mp
function [K_best, Mp_best] = findBest(desiredMp, Kmin, Kmax, Kdiff)
    K_best = Kmin;
    Mp_best = 10000;
    for K = Kmin:Kdiff:Kmax
        % Calculate Mp with given K
        numerator = [K, 5*K];
        denominator = [1, 7, 12, 5*K+10];
        Mp = getPeakGain(tf(numerator, denominator));
        
        % Store K and Pm that is closest to desired
        if abs(Mp_best - desiredMp) > abs(Mp - desiredMp)
            K_best = K;
            Mp_best = Mp;
        end
    end
end

function plotRootLocus(num, den, titleText)
    sys = tf(num, den);
    plot = figure;
    rlocus(sys);
    title(titleText);
    uiwait(plot);
end

function bodePlot(num, den, titleText)
    plot = figure;
    bode(tf(num, den));
    title(titleText);
    uiwait(plot);   
end