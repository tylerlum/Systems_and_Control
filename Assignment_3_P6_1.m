%% Assignment 3 P6.1

% a)
a = [1 5 2];
plotRoots(a, 'a');

% b)
b = [1 4 6 6];
plotRoots(b, 'b');

% c)
c = [1 2 -4 20];
plotRoots(c, 'c');

% d)
d = [1 1 2 10 8];
plotRoots(d, 'd');

% e)
K = 10;  % Look at when K > 2, K < 0, and 2 > K > 0
e = [1 1 3 2 K];
plotRoots(e, 'e');

% f)
f = [1 1 2 0 1 5];
plotRoots(f, 'f');

% g)
for K = [-10 -1 -0.1 -0.01 0.01 0.05 0.2 0.5 1 10 100]
    g = [1 1 2 1 1 K];
    plotRoots(g, sprintf('g) K = %f', K));
end



function plotRoots(den, titleText)
    [zz, pp, kk] = tf2zp([1], den);

    plot = figure;
    pzmap(pp, zz);
    title(titleText);
    uiwait(plot);
end
