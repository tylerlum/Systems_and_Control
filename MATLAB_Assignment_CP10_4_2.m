%% MATLAB Assignment CP10.4

%% SELECT DESIGN PARAMETERS
desiredPhaseMargins = [53, 60, 65, 70, 75, 80];
% minPo = 1000;
for desiredPhaseMargin = desiredPhaseMargins
    % Requirements
    minDamp = 0.6; % From PO requirement
    minimumPhaseMargin = radtodeg(atan(2.*minDamp./(-2*minDamp.^2+(1+4.*minDamp.^2).^0.5).^0.5));

    % Setup system
    numerator = (-10)*(-10)*conv([1, 1], [1, 0.01]);
    denominator = conv([1, 10], conv([1, 2, 2], [1, 0.02, 0.0101]));
    G = tf(numerator, denominator);

    if desiredPhaseMargin < minimumPhaseMargin
       % error(sprintf('Selected phase margin %f is too small. Needs to be greater than %f', desiredPhaseMargin, minimumPhaseMargin)); 
    end

    % Calculate alpha and magnitude
    [ Gm , Pm , Wcg , Wcp ] = margin(G);
    requiredAdditionalPhaseMargin = desiredPhaseMargin - Pm;
    alpha = (1 + sin(degtorad(requiredAdditionalPhaseMargin))) / (1 - sin(degtorad(requiredAdditionalPhaseMargin)));
    GcMag = 10 * log10(alpha);

    % Find wm such that the uncompenstated system magnitude = -10log(alpha)
    desiredMagnitude = -GcMag;
    disp('***************************************');
    disp(sprintf('Find wm such that the uncompenstated system magnitude = -10log(alpha) = %f', desiredMagnitude));

    [mag,phase,wout] = bode(G);
    disp(sprintf('Searching for wm in range %f to %f', wout(1), wout(end)));
    for i = 1:numel(mag)
        if 20*log10(mag(i)) < desiredMagnitude
            wm = wout(i);
            thisMag = 20*log10(mag(i));
            thisI = i;
            break;
        end 
    end
    disp(sprintf('Found closest wm: %f. Magnitude: %f dB', wm, thisMag));
    disp('***************************************');

    wmin = wout(thisI - 1);
    wmax = wout(thisI);
    wList = wmin:0.0001:wmax;
    disp(sprintf('Searching for wm in smaller range %f to %f', wmin, wmax));
    [mag,phase,wout] = bode(G, wList);
    for i = 1:numel(mag)
        if 20*log10(mag(i)) < desiredMagnitude
            wm = wout(i);
            thisMag = 20*log10(mag(i));
            thisI = i;
            break;
        end 
    end

    disp(sprintf('Found closest wm: %f. Magnitude: %f dB', wm, thisMag));

    %% Formulate Gc
    z = wm / sqrt(alpha);
    p = alpha*z;
    Gc = tf([1/z, 1], [1/p, 1]);
    L = Gc*G;

    %% Show margin 
    fig = figure;
    margin(L);
    uiwait(fig);

    %% Display performance values
    sys = feedback(L, [1]);
    stepInfo = stepinfo(sys);
    t = 0:0.01:450;
    [y,t]=step(sys, t);
    Ess = abs(1-y(end));
    disp(sprintf('For desiredPm = %f: T_s: %f. PO: %f. Ess: %f', desiredPhaseMargin, stepInfo.SettlingTime, stepInfo.Overshoot, Ess));

%     if stepInfo.Overshoot < minPo
%         disp('----------------FOUND');
%         disp(minPo);
%         minPo = stepInfo.Overshoot;
%         disp(minPo);
%     end

    %% Show step response
    fig = figure;
    t = 0:0.01:450;
    step(sys, t);
    uiwait(fig);
end