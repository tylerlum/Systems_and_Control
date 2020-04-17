%% MATLAB Assignment Problem 11.4 and 11.5

% Setup transfer functions for different values of alpha
alphaList = [0.9, 1.0, 1.1];
sys1 = getTransferFunction(alphaList(1));
sys2 = getTransferFunction(alphaList(2));
sys3 = getTransferFunction(alphaList(3));

%% 4) Plot poles and zeros for selected alpha values 
fig = figure;
pzmap(sys1, 'r', sys2, 'g', sys3, 'b');
title('11.4 Pole Zero Plot for different values of alpha');
legend(sprintf('alpha = %f', alphaList(1)), sprintf('alpha = %f', alphaList(2)), sprintf('alpha = %f', alphaList(3)));
uiwait(fig);

%% 5) Display performance values for selected alpha values
stepInfo1 = stepinfo(sys1);
stepInfo2 = stepinfo(sys2);
stepInfo3 = stepinfo(sys3);
[y1,t1]=step(sys1);
[y2,t2]=step(sys2);
[y3,t3]=step(sys3);
Ess1 = abs(1-y1(end));
Ess2 = abs(1-y2(end));
Ess3 = abs(1-y3(end));
disp(sprintf('For alpha = %f. T_s: %f. PO: %f. Ess: %f', alphaList(1), stepInfo1.SettlingTime, stepInfo1.Overshoot, Ess1));
disp(sprintf('For alpha = %f. T_s: %f. PO: %f. Ess: %f', alphaList(2), stepInfo2.SettlingTime, stepInfo2.Overshoot, Ess2));
disp(sprintf('For alpha = %f. T_s: %f. PO: %f. Ess: %f', alphaList(3), stepInfo3.SettlingTime, stepInfo3.Overshoot, Ess3));

%% 5) Plot step responses for selected alpha values
fig = figure;
step(sys1, 'r-', sys2, 'g--', sys3, 'b:');
title('11.5 Step Response for different values of alpha');
legend(sprintf('alpha = %f', alphaList(1)), sprintf('alpha = %f', alphaList(2)), sprintf('alpha = %f', alphaList(3)));
uiwait(fig);

function transferFunction = getTransferFunction(alpha)
    num = [1, alpha];
    den = [1, 1+alpha, alpha, 1];
    transferFunction = tf(num, den);
end
