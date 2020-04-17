%% Control Tutorial
% Link to tutorial http://ctms.engin.umich.edu/CTMS/index.php?example=Introduction&section=ControlStateSpace

%% Setup an unstable system
% Setup state space for controlling height of magnetic ball
A = [0, 1, 0;
    980 0 -2.8;
    0,  0, -100];

B = [0;
     0;
     100];
 
C = [1, 0, 0];
D = 0;

% Show unstable poles
poles = eig(A)

% Plot unstable system with initial condition and no input
t = 0:0.01:2;
u = zeros(size(t));
x0 = [0.01, 0, 0];
sys = ss(A, B, C, D);
[y,t,x] = lsim(sys, u, t, x0);
fig = figure;
plot(t,y);
title('Open-Loop Response to Non-Zero Initial Condition')
xlabel('Time (sec)')
ylabel('Ball Position (m)')
uiwait(fig);

% Check controllability and observability
rank(ctrb(sys))
rank(obsv(sys))

%% Control design with pole placement
% Want Ts < 0.5s and PO < 5%. 
% Try to place at -10 +/- 10i and at -50
p1 = -10 + 10i;
p2 = conj(p1);
p3 = -50;

K = place(A, B, [p1, p2, p3]);
sys_cl = ss(A-B*K, B, C, D);

fig = figure;
lsim(sys_cl, u, t, x0);
xlabel('Time (sec)');
ylabel('Ball Position (m)');
uiwait(fig);

% Overshoot is too large. Try pushing the poles further left
p1 = 2*p1;
p2 = 2*p2;
p3 = 2*p3;

K = place(A, B, [p1, p2, p3]);
sys_cl = ss(A-B*K, B, C, D);

fig = figure;
lsim(sys_cl, u, t, x0);
xlabel('Time (sec)');
ylabel('Ball Position (m)');
uiwait(fig);

% Overshoot is smaller. Note: The farther left the poles are, the more
% control effort that is needed. (u is larger)

%% Introducing reference input
t = 0:0.01:2;
u = 0.001*ones(size(t));
sys_cl = ss(A-B*K, B, C, D);
fig = figure;
lsim(sys_cl, u, t);
xlabel('TIme (sec)');
ylabel('Ball Position (m)');
axis([0, 2, -4E-6, 0]);
uiwait(fig);

% System fails to track the step well. Moves in the wrong direction.
% From schematic, we don't compare the output to the reference. Instead, we
% measure all states, multiply by gain K and then subtract this result from
% reference. There is not reason why Kx will be the same as desired output
% To solve this problem, we can scale the reference input to make it equal
% to Kx in steady state. 

Nbar = rscale(sys, K);

fig = figure;
lsim(sys_cl, Nbar*u, t);
title('Linear Simulation Results (with Nbar)');
xlabel('Time (sec)');
ylabel('Ball Position (m)');
axis([0, 2, 0, 1.2*10^-3]);
uiwait(fig);


% Now the step tracks well. Note: we need good model to scale the input
% correctly.

%% Observer Design
% Used when you can't measure all the state variables.
% Observer can estimate state variables and measure only output y = Cx
% Add 3 estimated state variables
% Observer is basically a copy of the plant, with same input and almost
% same ODE. The extra term compares the actual meaured output y with
% estiamted output y_hat = Cx_hat. This will cause it to approach x
% asymptotically.

% Need to set observer gain L. We want the dynamics of observer to be much
% faster than system, so place poles 5x farther away.
op1 = -100;
op2 = -101;
op3 = -102;

% Duality btwn controllability and observability 
L = place(A', C', [op1, op2, op3])';

% Commonly write the combined equations as e = x - x_hat, instead of x_hat
% directly. We use the estimated state for feedback, so u = -Kx_hat

At = [A-B*K, B*K;
      zeros(size(A)), A-L*C];
Bt = [ B*Nbar;
       zeros(size(B))];
   
Ct = [C, zeros(size(C))];
Dt = 0;

sys = ss(At, Bt, Ct, 0);
fig = figure;
lsim(sys, zeros(size(t)), t, [x0, x0]);
title('Linear Simulation Results (with observer)');
xlabel('Time (sec)');
ylabel('Ball Position (m)');
uiwait(fig);


%% Show both estimated and real state variables
t = 0:1E-6:0.1;
x0 = [0.01, 0.5, -5];
[y,t,x] = lsim(sys, zeros(size(t)), t, [x0, x0]);
n = 3;
e = x(:, n+1:end);
x = x(:, 1:n);
x_est = x - e;

h = x(:, 1); h_dot = x(:, 2); i = x(:, 3);
h_est = x_est(:,1); h_dot_est = x_est(:, 2); i_est = x_est(:, 3);

fig = figure;
plot(t, h, '-r', t, h_est, ':r', t, h_dot, '-b', t, h_dot_est, ':b', t, i, '-g', t, i_est, ':g');
legend('h', 'h_{est}', 'hdot', 'hdot_{est}', 'i', 'i_{est}');
xlabel('Time (sec)');
uiwait(fig);

