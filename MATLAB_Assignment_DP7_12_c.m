%% MATLAB Assignment DP7.12 c)

% Plot step responses for different values of K
for K = [100, 300, 600]
    numerator = [K, 3*K];
    denominator = [1, 15, 70, 120+K, 64+3*K];
    title = sprintf('DP7.12 c) Step Response for K = %f', K);
    plotStepResponse(numerator, denominator, title);
end

function plotStepResponse(num, den, titleText)
    % Create system
    sys = tf(num, den);
    
    % Get relevant performance values
    [y,t]=step(sys);
    Ess = abs(1-y(end));
    stepInfo = stepinfo(sys);
    
    % Plot
    plot = figure;
    step(sys);
    title(titleText);
    
    % Show performance values
    text(1, 0.1, sprintf('T_s: %f. PO: %f. Ess: %f', stepInfo.SettlingTime, stepInfo.Overshoot, Ess));
    uiwait(plot);
end

