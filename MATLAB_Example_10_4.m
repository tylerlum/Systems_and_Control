%% MATLAB Example 10.4


%% Calculate p and z for phase lead network
% Constants
open_loop_pole_1 = 0;
open_loop_pole_2 = -2;

% Requirements
Ts_max = 1;
PO_max = 15;
ess_ramp_max = 0.05;

% SET DESIGN PARAMETERS
damping = 0.45;
wn = 10;

% Check that Ts requirement met
Ts_estimate = 4 / (damping * wn);
if Ts_max < Ts_estimate
   error(sprintf('Ts requirement not met. Ts_max = %f. Ts_estimate = %f', Ts_max, Ts_estimate));
   return
end

% Calculate desired poles
desired_pole_1 = -damping*wn + wn*sqrt(1 - damping^2) * i;
desired_pole_2 = conj(desired_pole_1);

% Calculate z and p for phase lead compensator
z = real(desired_pole_1);
theta0 = rad2deg(atan2(imag(desired_pole_1) - imag(open_loop_pole_1), real(desired_pole_1) - real(open_loop_pole_1))); 
theta1 = rad2deg(atan2(imag(desired_pole_1) - imag(open_loop_pole_2), real(desired_pole_1) - real(open_loop_pole_2))); 
theta2 = rad2deg(atan2(imag(desired_pole_1) - imag(z), real(desired_pole_1) - real(z))); 

phi = -theta0 - theta1 + theta2;
theta_p = 180 + phi;
l = imag(desired_pole_1) / tan(deg2rad(theta_p));
p = z - l;

%% Setup transfer function
K = abs(open_loop_pole_1 - desired_pole_1) * abs(open_loop_pole_2 - desired_pole_1) * abs(p - desired_pole_1) / abs(z - desired_pole_1);
G = tf([K], [1, 2, 0]);
G_lead = tf(K*[1, -z], [1, -p]);
%G_lag = tf([1, 0.09], [1, 0.022]);
%loop_tf = G * G_lead * G_lag;
loop_tf = G * G_lead;
closed_loop_tf = feedback(loop_tf, [1]);

%% Calculate step response performance
stepInfo = stepinfo(closed_loop_tf);

[y,t] = step(closed_loop_tf);

Ess = abs(1-y(end));

disp(sprintf('Selected design parameters: damping: %f. wn: %f. K: %f', damping, wn, K));
disp(sprintf('Resulting z and p: z: %f. p: %f', z, p));
disp(sprintf('Step Response performance: T_s: %f. PO: %f. Ess: %f', stepInfo.SettlingTime, stepInfo.Overshoot, Ess));

%% Plot step response
fig = figure;
step(closed_loop_tf);
uiwait(fig);

%% Calculate ramp response performance
stepInfo = stepinfo(closed_loop_tf / tf([1,0], [1]));

[y,t] = step(closed_loop_tf / tf([1,0], [1]));

Ess = abs(t(end)-y(end));

disp(sprintf('Ramp Response performance: T_s: %f. PO: %f. Ess: %f', stepInfo.SettlingTime, stepInfo.Overshoot, Ess));

%% Plot ramp response
fig = figure;
step(closed_loop_tf / tf([1,0], [1]));
hold on;
plot(t, t, 'r--');
title('Ramp Response');
uiwait(fig);

%% Plot zeros and poles
fig = figure;
pzmap(closed_loop_tf);
uiwait(fig);


