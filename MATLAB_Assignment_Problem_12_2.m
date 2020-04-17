%% MATLAB Assignment Problem 12 2

%% a) Root Locus Plot with Gc
G = tf([2], conv([1,0], conv([1,1],[1,4])));
P = tf([1, 2], [1]) * G;
plotRootLocus(P, 'Problem 12.2a) Root Locus Plot'); 

%% b) Find K so that desired settling time is reached
Ts_desired = 4;
real_part_desired = -4/Ts_desired;

k = 2:0.1:4;
r = rlocus(P, k);
current_best_diff = 10000;
for i = 1:numel(k)
   diff1 = abs(real(r(3*(i-1)+1)) - real_part_desired);
   diff2 = abs(real(r(3*(i-1)+2)) - real_part_desired);
   diff3 = abs(real(r(3*(i-1)+3)) - real_part_desired);
   best_diff = min([diff1, diff2, diff3]);
   if current_best_diff > best_diff
       current_best_diff = best_diff;
       bestK = k(i);
   end
end

bestR = rlocus(P, bestK);
disp(sprintf('Found that best K is %f, which results in roots: %f, %f, %f', bestK, bestR(1), bestR(2), bestR(3)));


%% c) Plot step response
Gc = tf(bestK*[1,2], [1]);

%% Systems for R(s) = 1/s, D(s) = 0
sys1 = feedback(G*Gc, [1]);

% Display performance values
stepInfo = stepinfo(sys1);
[y,t]=step(sys1);
Ess = abs(1-y(end));
disp('Performance for R(s) = 1/s, D(s) = 0');
disp(sprintf('For K = %f. T_s: %f. PO: %f. Ess: %f', bestK, stepInfo.SettlingTime, stepInfo.Overshoot, Ess));

% Plot stable
fig = figure;
step(sys1, 'r-.');
title('Problem 12.2c) R(s) = 1/s. D(s) = 0');
legend(sprintf('K = %f', bestK));
uiwait(fig);

%% Systems for R(s) = 0, D(s) = 1/s
sys2 = feedback(G, Gc);

% Display performance values
stepInfo = stepinfo(sys2);
[y,t]=step(sys2);
Ess = abs(0-y(end));
disp('Performance for R(s) = 0, D(s) = 1/s');
disp(sprintf('For K = %f. T_s: %f. PO: %f. Ess: %f', bestK, stepInfo.SettlingTime, stepInfo.Overshoot, Ess));

% Plot stable
fig = figure;
step(sys2, 'r-.');
title('Problem 12.2c) R(s) = 0, D(s) = 1/s');
legend(sprintf('K = %f', bestK));
uiwait(fig);

%% Systems for R(s) = 1/s, D(s) = 1/s
sys3 = sys1 + sys2;

% Display performance values
stepInfo = stepinfo(sys3);
[y,t]=step(sys3);
Ess = abs(1-y(end));
disp('Performance for R(s) = 1/s, D(s) = 1/s');
disp(sprintf('For K = %f. T_s: %f. PO: %f. Ess: %f', bestK, stepInfo.SettlingTime, stepInfo.Overshoot, Ess));

% Plot stable
fig = figure;
step(sys3, 'r-.');
title('Problem 12.2c) R(s) = 1/s, D(s) = 1/s');
legend(sprintf('K = %f', bestK));
uiwait(fig);

%% d) Show Bode Plot
bodePlot(sys1, sprintf('Problem 12.2d) Closed Loop Bode Plot R(s) = 1/s, D(s) = 0, K_a = %f', bestK));
bodePlot(sys2, sprintf('Problem 12.2d) Closed Loop Bode Plot R(s) = 0, D(s) = 1/s, K_a = %f', bestK));
bodePlot(Gc*G, sprintf('Problem 12.2d) Open Loop Bode Plot R(s) = 1/s, D(s) = 0, K_a = %f', bestK));

function bodePlot(transfer_function, titleText)
    plot = figure;
    bode(transfer_function);
    title(titleText);
    uiwait(plot);   
end

function plotRootLocus(transfer_function, titleText)
    plot = figure;
    rlocus(transfer_function);
    title(titleText);
    uiwait(plot);
end