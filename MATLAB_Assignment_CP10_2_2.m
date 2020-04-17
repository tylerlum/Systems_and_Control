

%% Setup transfer function
G = tf(100*conv([1,1], [1,0.01]), conv([1,10], conv([1,2,2],[1,0.02,0.0101])));
G_c = tf(4*[1, 2], [1, 22]);
%G_lag = tf([1, 0.09], [1, 0.022]);
%loop_tf = G * G_lead * G_lag;
loop_tf = G * G_c;
closed_loop_tf = feedback(loop_tf, [1]);

%% Calculate step response performance
stepInfo = stepinfo(closed_loop_tf);

[y,t] = step(closed_loop_tf);

Ess = abs(1-y(end));

disp(sprintf('Step Response performance: T_s: %f. PO: %f. Ess: %f', stepInfo.SettlingTime, stepInfo.Overshoot, Ess));

%% Plot step response
fig = figure;
step(closed_loop_tf);
uiwait(fig);
