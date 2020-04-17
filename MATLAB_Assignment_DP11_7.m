A = [0, 1, 0; 0, 0, 1; -2, -5, -10];
B = [0; 0; 1];
C = [1, 0, 0];
D = [0];
sysc = ss(A, B, C, D);
x0 = [1;1;1]
%x0 = [1;1;1;0;0;0]
t = [0:0.001:2];
[y,t] = initial(sysc,x0,t);
subplot(311)
plot(t,y(:,1),t,y(:,4),'--'),grid
subplot(312)
plot(t,y(:,2),t,y(:,5),'--'),grid
subplot(313)
plot(t,y(:,3),t,y(:,6),'--'),grid