%% MATLAB Example 10.2

num = [40];
den = [1, 2, 0];
G = tf(num, den);

margin(G);

requiredAdditionalPhaseMargin = 30;
alpha = (1+sin(deg2rad(requiredAdditionalPhaseMargin))) / (1 - sin(deg2rad(requiredAdditionalPhaseMargin)));
desiredMagnitude = -10*log10(alpha);

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
z = wm / sqrt(alpha);
p = alpha*z;

Gc = tf([1/z, 1], [1/p, 1]);  %% NOTE DO NOT ADD 1/alpha factor. Just assume that is added. Keep is as (s/z+1)/(s/p+1)
L = Gc*G;

margin(L);

sys = feedback(L, [1]);

% Display performance values
stepInfo = stepinfo(sys);
[y,t]=step(sys);
Ess = abs(1-y(end));
disp(sprintf('T_s: %f. PO: %f. Ess: %f', stepInfo.SettlingTime, stepInfo.Overshoot, Ess));

%step(sys);