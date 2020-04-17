%% MATLAB Assignment DP11.7

%% Setup state space
A = [0 1 0;
     0 0 1;
    -2 -5 -10];

B = [0;
     0;
     1];
 
C = [1 0 0];

D = 0;
sys = ss(A, B, C, D);

%% Select K and L
K = [4818 715 39.2];
L = [120;
    4795;
    51448];

%% Calculate new state space
Nbar = rscale(sys, K);

At = [A-B*K, B*K;
      zeros(size(A)), A-L*C];
Bt = [ B*Nbar;
       zeros(size(B))];
   
Ct = [C, zeros(size(C))];
Dt = 0;

sys = ss(At, Bt, Ct, 0);

%% Calculate performance 
t = 0:0.01:2;
y = step(sys, t);
Ess = abs(1 - y(end));
wb = bandwidth(sys);
[Gm Pm Wg Wp] = margin(sys);
disp(sprintf('This system has step Ess: %f. wb: %f. Gm: %f', Ess, wb, Gm));

%% Plot for step response
fig = figure;
step(sys, t);
title('DP11.7 Step response');
xlabel('Time (sec)');
ylabel('Output');
uiwait(fig);

%% Plot for different initial conditions
x0 = [0.01, 0.5, -5];
x0_est = [0.02, 1.0, -10];
disp(sprintf('Initial conditions x0 = [%f, %f, %f], x0_est = [%f, %f, %f]', x0(1), x0(2), x0(3), x0_est(1), x0_est(2), x0_est(3)));

fig = figure;
lsim(sys, zeros(size(t)) + 1, t, [x0, x0_est]);
[y,t,x] = lsim(sys, zeros(size(t)) + 1, t, [x0, x0_est]);
title('DP11.7 Response to different initial condition and step input');
xlabel('Time (sec)');
ylabel('Output');
Ess = abs(1 - y(end));
disp(sprintf('With differing initial conditions Ess: %f', Ess));
uiwait(fig);



