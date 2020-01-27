%% Assignment 1 CP2.1

% Setup polynomials
p = tf([1 8 12], 1);
q = tf([1 2], 1);

% a) Compute p(s)q(s)
pq = p * q;
disp('a) Compute p(s)q(s):');
pq
disp('********************');

% b) Compute the poles and zeros of G(s) = q(s) / p(s)
G = q / p;
zeros = zero(G);
poles = pole(G);
disp('b) Compute the poles and zeros of G(s) = q(s) / p(s):');
zeros
poles
disp('********************');

% c) Compute p(-1)
answer = evalfr(p, -1);
disp('c) Compute p(-1):');
answer
disp('********************');