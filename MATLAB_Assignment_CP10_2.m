%% MATLAB Assignment CP10.2

% Constant
Pm_desired = 40;

% Find best K value to reach Pm_desired
[K_best, Pm_best] = findBest(Pm_desired, 1, 100, 1);
[K_best, Pm_best] = findBest(Pm_desired, K_best-1, K_best+1, 0.01);

disp(sprintf('Best K: %f. Best Pm: %f', K_best, Pm_best));

% Show plot displaying the phase margin
numerator = [24.2*K_best];
denominator = [1, 8, 24.2];
marginPlot(numerator, denominator);

function [K_best, Pm_best] = findBest(desiredPm, Kmin, Kmax, Kdiff)
    K_best = Kmin;
    Pm_best = 10000;
    for K = Kmin:Kdiff:Kmax
        % Calculate Pm with given K
        numerator = [24.2*K];
        denominator = [1, 8, 24.2];
        [Gm,Pm,Wcg,Wcp] = margin(tf(numerator, denominator));
        
        % Store K and Pm that is closest to desired
        if abs(Pm_best - desiredPm) > abs(Pm - desiredPm)
            K_best = K;
            Pm_best = Pm;
        end
    end
end

function marginPlot(num, den)
    plot = figure;
    sys = tf(num, den);
    margin(sys);
    uiwait(plot);   
end