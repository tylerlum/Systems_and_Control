%% MATLAB Assignment CP10.4

% a) Setup loop transfer function for uncompensated system
disp('***************************************');
disp('Show Bode Plot for uncompensated system');
numerator = (-10)*(-10)*conv([1, 1], [1, 0.01]);
denominator = conv([1, 10], conv([1, 2, 2], [1, 0.02, 0.0101]));
marginPlot(numerator, denominator);

% a) Find required phase margin
% Plot Phase Margin vs. Damping Ratio
disp('***************************************');
disp('Plot Phase Margin vs. Damping Ratio to select desired phase margin');
E = 0:0.01:1;
Pm = radtodeg(atan(2.*E./(-2*E.^2+(1+4.*E.^2).^0.5).^0.5));
fig = figure;
plot(E, Pm);
hold on;
grid on;
minE = zeros(1, numel(Pm)) + 0.6;
plot(minE, Pm);
title('CP10.4 Phase Margin vs. Damping Ratio');
xlabel('Damping Ratio');
ylabel('Phase Margin (degrees)');
legend('Phase Margin', 'Minimum Damping Ratio');
uiwait(fig);

% Select Phase Margin 60 degrees, find corresponding damping ratio
desiredPm = 60;
disp('***************************************');
disp(sprintf('Selected phase margin %f degrees. Finding corresponding damping ratio.', desiredPm));
for i = 1:numel(Pm)
    thisPm = Pm(i);
    if thisPm > desiredPm
        desiredE = E(i);
        break;
    end
end
disp(sprintf('Found corresponding damping ratio: %f.', desiredE));

% Find wm such that the uncompenstated system magnitude = -10log(alpha)
alpha = 10.84;
desiredMagnitude = -10*log10(alpha);
disp('***************************************');
disp(sprintf('Find wm such that the uncompenstated system magnitude = -10log(alpha) = %f', desiredMagnitude));
numerator = (-10)*(-10)*conv([1, 1], [1, 0.01]);
denominator = conv([1, 10], conv([1, 2, 2], [1, 0.02, 0.0101]));
[mag,phase,wout] = bode(tf(numerator, denominator));
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
numerator = (-10)*(-10)*conv([1, 1], [1, 0.01]);
denominator = conv([1, 10], conv([1, 2, 2], [1, 0.02, 0.0101]));
[mag,phase,wout] = bode(tf(numerator, denominator), wList);
for i = 1:numel(mag)
    if 20*log10(mag(i)) < desiredMagnitude
        wm = wout(i);
        thisMag = 20*log10(mag(i));
        thisI = i;
        break;
    end 
end

disp(sprintf('Found closest wm: %f. Magnitude: %f dB', wm, thisMag));

%% Show Bode Plot for compensated system
disp('***************************************');
disp('Show Bode Plot for compensated system');
tau = 1/wm * sqrt(1/alpha);

for K = 0.001:0.01:1
    numerator = (-10)*(-10)*conv([1, 1], [1, 0.01]);
    denominator = conv([1, 10], conv([1, 2, 2], [1, 0.02, 0.0101]));
    newNumerator = conv(numerator, [alpha*tau, 1]) * K;
    newDenominator = conv(denominator, [tau, 1]);

    disp(K);
    marginPlot(newNumerator, newDenominator);
end

%% Show step function for compensated system
K = 6;
numerator = (-10)*(-10)*conv([1, 1], [1, 0.01]);
denominator = conv([1, 10], conv([1, 2, 2], [1, 0.02, 0.0101]));
sysg = tf(numerator, denominator);
numeratorc = K*[1, 2];
denominatorc = [1, 22];
sysc = tf(numeratorc, denominatorc);
sys_o = series(sysc, sysg);
sys_cl = feedback(sys_o, [1]);
t=[0:0.01:5];
f=10*pi/180;
[y,t,x]=step(f*sys_cl,t);
plot(t,y*180/pi), grid

stepInfo = stepinfo(f*sys_cl);
Ess = abs(1-y(end));

% Show performance values
disp(sprintf('T_s: %f. PO: %f. Ess: %f', stepInfo.SettlingTime, stepInfo.Overshoot, Ess));

function marginPlot(num, den)
    plot = figure;
    margin(tf(num, den));
    uiwait(plot);   
end