%% MATLAB Assignment Problem 12

%% a) Plot step responses varying values of Ka
Ka = [0.5, 1.0, 5.0, 10.0, 20.0];
G = tf([2], conv([1,0], conv([1,1],[1,4])));
Gc1 = tf([Ka(1)], [1]);
Gc2 = tf([Ka(2)], [1]);
Gc3 = tf([Ka(3)], [1]);
Gc4 = tf([Ka(4)], [1]);
Gc5 = tf([Ka(5)], [1]);

%% Systems for R(s) = 1/s, D(s) = 0
sys1_1 = feedback(G*Gc1, [1]);
sys1_2 = feedback(G*Gc2, [1]);
sys1_3 = feedback(G*Gc3, [1]);
sys1_4 = feedback(G*Gc4, [1]);
sys1_5 = feedback(G*Gc5, [1]);

% Display performance values
stepInfo1_1 = stepinfo(sys1_1);
stepInfo1_2 = stepinfo(sys1_2);
stepInfo1_3 = stepinfo(sys1_3);
stepInfo1_4 = stepinfo(sys1_4);
stepInfo1_5 = stepinfo(sys1_5);
[y1_1,t1]=step(sys1_1);
[y1_2,t2]=step(sys1_2);
[y1_3,t3]=step(sys1_3);
[y1_4,t4]=step(sys1_4);
[y1_5,t5]=step(sys1_5);
Ess1_1 = abs(1-y1_1(end));
Ess1_2 = abs(1-y1_2(end));
Ess1_3 = abs(1-y1_3(end));
Ess1_4 = abs(1-y1_4(end));
Ess1_5 = abs(1-y1_5(end));
disp('Performance for R(s) = 1/s, D(s) = 0');
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(1), stepInfo1_1.SettlingTime, stepInfo1_1.Overshoot, Ess1_1));
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(2), stepInfo1_2.SettlingTime, stepInfo1_2.Overshoot, Ess1_2));
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(3), stepInfo1_3.SettlingTime, stepInfo1_3.Overshoot, Ess1_3));
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(4), stepInfo1_4.SettlingTime, stepInfo1_4.Overshoot, Ess1_4));
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(5), stepInfo1_5.SettlingTime, stepInfo1_5.Overshoot, Ess1_5));

% Plot stable
fig = figure;
step(sys1_1, 'r-.', sys1_2, 'g-', sys1_3, 'b--');
title('Problem 12a) R(s) = 1/s. D(s) = 0. Stable Systems');
legend(sprintf('K_a = %f', Ka(1)), sprintf('K_a = %f', Ka(2)), sprintf('K_a = %f', Ka(3)));
uiwait(fig);

% Plot marginal stable
fig = figure;
step(sys1_4, 'k-');
title('Problem 12a) R(s) = 1/s. D(s) = 0. Marginal Stable System');
legend(sprintf('K_a = %f', Ka(4)));
uiwait(fig);

% Plot unstable
fig = figure;
step( sys1_5, 'c-');
title('Problem 12a) R(s) = 1/s. D(s) = 0. Unstable System');
legend(sprintf('K_a = %f', Ka(5)));
uiwait(fig);

%% Systems for R(s) = 0, D(s) = 1/s
sys2_1 = feedback(G, Gc1);
sys2_2 = feedback(G, Gc2);
sys2_3 = feedback(G, Gc3);
sys2_4 = feedback(G, Gc4);
sys2_5 = feedback(G, Gc5);

% Display performance values
stepInfo2_1 = stepinfo(sys2_1);
stepInfo2_2 = stepinfo(sys2_2);
stepInfo2_3 = stepinfo(sys2_3);
stepInfo2_4 = stepinfo(sys2_4);
stepInfo2_5 = stepinfo(sys2_5);
[y2_1,t1]=step(sys2_1);
[y2_2,t2]=step(sys2_2);
[y2_3,t3]=step(sys2_3);
[y2_4,t4]=step(sys2_4);
[y2_5,t5]=step(sys2_5);
Ess2_1 = abs(0-y2_1(end));
Ess2_2 = abs(0-y2_2(end));
Ess2_3 = abs(0-y2_3(end));
Ess2_4 = abs(0-y2_4(end));
Ess2_5 = abs(0-y2_5(end));
disp('Performance for R(s) = 0, D(s) = 1/s');
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(1), stepInfo2_1.SettlingTime, stepInfo2_1.Overshoot, Ess2_1));
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(2), stepInfo2_2.SettlingTime, stepInfo2_2.Overshoot, Ess2_2));
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(3), stepInfo2_3.SettlingTime, stepInfo2_3.Overshoot, Ess2_3));
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(4), stepInfo2_4.SettlingTime, stepInfo2_4.Overshoot, Ess2_4));
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(5), stepInfo2_5.SettlingTime, stepInfo2_5.Overshoot, Ess2_5));

% Plot stable
fig = figure;
step(sys2_1, 'r-.', sys2_2, 'g-', sys2_3, 'b--');
title('Problem 12a) R(s) = 0. D(s) = 1/s. Stable Systems');
legend(sprintf('K_a = %f', Ka(1)), sprintf('K_a = %f', Ka(2)), sprintf('K_a = %f', Ka(3)));
uiwait(fig);

% Plot marginal stable
fig = figure;
step(sys2_4, 'k-');
title('Problem 12a) R(s) = 0. D(s) = 1/s. Marginal Stable System');
legend(sprintf('K_a = %f', Ka(4)));
uiwait(fig);

% Plot unstable
fig = figure;
step( sys2_5, 'c-');
title('Problem 12a) R(s) = 0. D(s) = 1/s. Unstable System');
legend(sprintf('K_a = %f', Ka(5)));
uiwait(fig);

%% Systems for R(s) = 1/s, D(s) = 1/s
sys3_1 = sys1_1 + sys2_1;
sys3_2 = sys1_2 + sys2_2;
sys3_3 = sys1_3 + sys2_3;
sys3_4 = sys1_4 + sys2_4;
sys3_5 = sys1_5 + sys2_5;

% Display performance values
stepInfo3_1 = stepinfo(sys3_1);
stepInfo3_2 = stepinfo(sys3_2);
stepInfo3_3 = stepinfo(sys3_3);
stepInfo3_4 = stepinfo(sys3_4);
stepInfo3_5 = stepinfo(sys3_5);
[y3_1,t1]=step(sys3_1);
[y3_2,t2]=step(sys3_2);
[y3_3,t3]=step(sys3_3);
[y3_4,t4]=step(sys3_4);
[y3_5,t5]=step(sys3_5);
Ess3_1 = abs(1-y3_1(end));
Ess3_2 = abs(1-y3_2(end));
Ess3_3 = abs(1-y3_3(end));
Ess3_4 = abs(1-y3_4(end));
Ess3_5 = abs(1-y3_5(end));
disp('Performance for R(s) = 1/s, D(s) = 1/s');
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(1), stepInfo3_1.SettlingTime, stepInfo3_1.Overshoot, Ess3_1));
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(2), stepInfo3_2.SettlingTime, stepInfo3_2.Overshoot, Ess3_2));
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(3), stepInfo3_3.SettlingTime, stepInfo3_3.Overshoot, Ess3_3));
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(4), stepInfo3_4.SettlingTime, stepInfo3_4.Overshoot, Ess3_4));
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka(5), stepInfo3_5.SettlingTime, stepInfo3_5.Overshoot, Ess3_5));

% Plot stable
fig = figure;
step(sys3_1, 'r-.', sys3_2, 'g-', sys3_3, 'b--');
title('Problem 12a) R(s) = 1/s, D(s) = 1/s. Stable Systems');
legend(sprintf('K_a = %f', Ka(1)), sprintf('K_a = %f', Ka(2)), sprintf('K_a = %f', Ka(3)));
uiwait(fig);

% Plot marginal stable
fig = figure;
step(sys3_4, 'k-');
title('Problem 12a) R(s) = 1/s, D(s) = 1/s. Marginal Stable System');
legend(sprintf('K_a = %f', Ka(4)));
uiwait(fig);

% Plot unstable
fig = figure;
step( sys3_5, 'c-');
title('Problem 12a) R(s) = 1/s, D(s) = 1/s. Unstable System');
legend(sprintf('K_a = %f', Ka(5)));
uiwait(fig);

%% b) Plot Root Locus as Ka
numerator = [2];
denominator = conv([1, 0], conv([1, 1], [1, 4]));
plotRootLocus(numerator, denominator, 'Problem 12b) Root Locus Plot');

%% Plot for selected Ka
Ka = 9.5;
Gc = tf([Ka], [1]);

%% System for R(s) = 1/s, D(s) = 0
sys4 = feedback(G*Gc, [1]);

% Display performance values
stepInfo4 = stepinfo(sys4);

[y4,t4]=step(sys4);
Ess4 = abs(1-y4(end));
disp('Performance for R(s) = 1/s, D(s) = 0');
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka, stepInfo4.SettlingTime, stepInfo4.Overshoot, Ess4));

% Plot stable
fig = figure;
step(sys4, 'r-.');
title('Problem 12b) R(s) = 1/s, D(s) = 0');
legend(sprintf('K_a = %f', Ka));
uiwait(fig);

%% System for R(s) = 0, D(s) = 1/s
sys5 = feedback(G, Gc);

% Display performance values
stepInfo5 = stepinfo(sys5);

[y5,t5]=step(sys5);
Ess5 = abs(0-y5(end));
disp('Performance for R(s) = 0, D(s) = 1/s');
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka, stepInfo5.SettlingTime, stepInfo5.Overshoot, Ess5));

% Plot stable
fig = figure;
step(sys5, 'r-.');
title('Problem 12b) R(s) = 0, D(s) = 1/s');
legend(sprintf('K_a = %f', Ka));
uiwait(fig);

%% Find Ka such that damping = 0.5
damping_desired = 0.5;
required_angle = pi - acos(0.5);
numerator = [2];
denominator = conv([1, 0], conv([1, 1], [1, 4]));
k = 0:0.001:10;
r = rlocus(tf(numerator, denominator), k);

disp(sprintf('Searching for Ka such that damping = %f, which means angle = %f', damping_desired, required_angle));
closest_angle = 0;
for i = 1:numel(r)
    this_angle = angle(r(i));
    if abs(closest_angle - required_angle) > abs(this_angle - required_angle)
        closest_angle = this_angle;
        bestKa = k(i);
    end
end
disp(sprintf('Found Ka = %f results in closest angle %f, only %f away from requirement', bestKa, closest_angle, abs(required_angle - closest_angle)));

%% Show Bode Plot with the found Ka
Gc = tf([bestKa], [1]);
% System for R(s) = 1/s, D(s) = 0
sys6 = feedback(G*Gc, [1]);
% System for R(s) = 0, D(s) = 1/s
sys7 = feedback(G, Gc);

bodePlot(sys6, sprintf('Problem 12d) Bode Plot R(s) = 1/s, D(s) = 0, K_a = %f', bestKa));
bodePlot(sys7, sprintf('Problem 12d) Bode Plot R(s) = 0, D(s) = 1/s, K_a = %f', bestKa));
bodePlot(G*Gc, sprintf('Problem 12d) Bode Plot R(s) = 1/s, D(s) = 0, K_a = %f', bestKa));

%% System for R(s) = 1/s, D(s) = 0
Ka = 4.032;
Gc = tf([Ka],[1]);
sys10 = feedback(G*Gc, [1]);

% Display performance values
stepInfo4 = stepinfo(sys10);

[y4,t4]=step(sys10);
Ess4 = abs(1-y4(end));
disp('Performance for R(s) = 1/s, D(s) = 0');
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka, stepInfo4.SettlingTime, stepInfo4.Overshoot, Ess4));

% Plot stable
fig = figure;
step(sys10, 'r-.');
title('Problem 12c) R(s) = 1/s, D(s) = 0');
legend(sprintf('K_a = %f', Ka));
uiwait(fig);

%% System for R(s) = 0, D(s) = 1/s
sys5 = feedback(G, Gc);

% Display performance values
stepInfo5 = stepinfo(sys5);

[y5,t5]=step(sys5);
Ess5 = abs(0-y5(end));
disp('Performance for R(s) = 0, D(s) = 1/s');
disp(sprintf('For Ka = %f. T_s: %f. PO: %f. Ess: %f', Ka, stepInfo5.SettlingTime, stepInfo5.Overshoot, Ess5));

% Plot stable
fig = figure;
step(sys5, 'r-.');
title('Problem 12b) R(s) = 0, D(s) = 1/s');
legend(sprintf('K_a = %f', Ka));
uiwait(fig);

%% Systems for R(s) = 1/s, D(s) = 1/s
sys3 = sys10 + sys5;

% Display performance values
stepInfo = stepinfo(sys3);
[y,t]=step(sys3);
Ess = abs(1-y(end));
disp('Performance for R(s) = 1/s, D(s) = 1/s');
disp(sprintf('For K = %f. T_s: %f. PO: %f. Ess: %f', Ka, stepInfo.SettlingTime, stepInfo.Overshoot, Ess));

% Plot stable
fig = figure;
step(sys3, 'r-.');
title('Problem 12.2c) R(s) = 1/s, D(s) = 1/s');
legend(sprintf('K = %f', Ka));
uiwait(fig);

function bodePlot(transfer_function, titleText)
    plot = figure;
    bode(transfer_function);
    title(titleText);
    uiwait(plot);   
end

function plotRootLocus(num, den, titleText)
    sys = tf(num, den);
    plot = figure;
    rlocus(sys);
    title(titleText);
    uiwait(plot);
end