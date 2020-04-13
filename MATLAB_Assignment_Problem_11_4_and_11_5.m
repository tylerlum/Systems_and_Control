%% MATLAB Assignment Problem 11.4 and 11.5

%% 4) Find smallest alpha so that all poles are real.
alphaList = 0.9:0.01:16;
rootsLargestImaginaryList = zeros(1, numel(alphaList));

for alpha = alphaList
    % Calculate roots
   myRoots = roots([1, 1+alpha, alpha, 1]);
   
   % Find largest imaginary component
   largestImaginary = 0;
   for i = 1:numel(myRoots)
       r = myRoots(i);
       imaginary = abs(imag(r));
       if imaginary > largestImaginary
          largestImaginary = imaginary; 
       end
   end
   
   % End loop if found all real poles
   if largestImaginary == 0
       bestAlpha = alpha;
       break;
   end
end

disp(sprintf('Smallest Alpha with all real poles: %f', bestAlpha));

% Plot largest imaginary vs. alpha
rootsLargestImaginaryList = zeros(1, numel(alphaList));
for j = 1:numel(alphaList)
    % Calculate roots
    alpha = alphaList(j);
    myRoots = roots([1, 1+alpha, alpha, 1]);
    
   % Find largest imaginary component
   largestImaginary = 0;
   for i = 1:numel(myRoots)
       r = myRoots(i);
       imaginary = abs(imag(r));
       if imaginary > largestImaginary
          largestImaginary = imaginary; 
       end
   end
   disp(largestImaginary);
   rootsLargestImaginaryList(j) = largestImaginary;
end

fig = figure;
plot(alphaList, rootsLargestImaginaryList);
title('11.4 Largest Imaginary vs. alpha');
xlabel('alpha');
ylabel('Largest imaginary');
uiwait(fig);

%% 4) Plot poles and zeros for selected alpha values 
alphaList = [1.0, 1.1, 0.9];
sys1 = getTransferFunction(alphaList(1));
sys2 = getTransferFunction(alphaList(2));
sys3 = getTransferFunction(alphaList(3));

fig = figure;
pzmap(sys1, 'r', sys2, 'g', sys3, 'b');
title('11.4 Pole Zero Plot');
legend(sprintf('alpha = %f', alphaList(1)), sprintf('alpha = %f', alphaList(2)), sprintf('alpha = %f', alphaList(3)))
uiwait(fig);

%% 5) Plot step responses for selected alpha values
alphaList = [1.0, 1.1, 0.9];
% sys1 = getTransferFunction(alphaList(1)) / alphaList(1);
% sys2 = getTransferFunction(alphaList(2)) / alphaList(2);
% sys3 = getTransferFunction(alphaList(3)) / alphaList(3);

sys1 = getTransferFunction(alphaList(1));
sys2 = getTransferFunction(alphaList(2));
sys3 = getTransferFunction(alphaList(3));
stepInfo1 = stepinfo(sys1);
stepInfo2 = stepinfo(sys2);
stepInfo3 = stepinfo(sys3);

[y1,t1]=step(sys1);
[y2,t2]=step(sys2);
[y3,t3]=step(sys3);

Ess1 = abs(1-y1(end));
Ess2 = abs(1-y2(end));
Ess3 = abs(1-y3(end));

fig = figure;
step(sys1, 'r.', sys2, 'g--', sys3, 'b*');
title('11.5 Step Response for different alpha');
uiwait(fig);

disp(sprintf('T_s: %f. PO: %f. Ess: %f', stepInfo1.SettlingTime, stepInfo1.Overshoot, Ess1));
disp(sprintf('T_s: %f. PO: %f. Ess: %f', stepInfo2.SettlingTime, stepInfo2.Overshoot, Ess2));
disp(sprintf('T_s: %f. PO: %f. Ess: %f', stepInfo3.SettlingTime, stepInfo3.Overshoot, Ess3));

function transferFunction = getTransferFunction(alpha)
    num = [1, alpha];
    den = [1, 1+alpha, alpha, 1];
    transferFunction = tf(num, den);
end
