%% MATLAB Assignment DP10.1 TESTING

%% Setup transfer function
K = 500;
G = tf([20], [1, 2, 0]);
G_lead = tf(K .* [1, 1], [1, 20]);
G_lag = tf([1, 0.1], [1, 0.022]);
loop_tf = G * G_lead;
closed_loop_tf = feedback(loop_tf, [1]);

%% Calculate step response performance
stepInfo = stepinfo(closed_loop_tf / tf([1, 0], [1]));

[y,t] = step(closed_loop_tf / tf([1, 0], [1]));

Ess = abs(t(end)-y(end));

disp(sprintf('Selected design parameters: damping: %f. wn: %f. K: %f', damping, wn, K));
disp(sprintf('Resulting z and p: z: %f. p: %f', z, p));
disp(sprintf('Design performance: T_s: %f. PO: %f. Ess: %f', stepInfo.SettlingTime, stepInfo.Overshoot, Ess));

%% Plot step response
step(closed_loop_tf / tf([1, 0], [1]));

% pzmap(closed_loop_tf);

