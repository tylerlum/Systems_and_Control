%% Assignment 1 CP2.2

% Setup transfer functions for feedback system
controller = tf([1], [1 1]);
plant = tf([1 2], [1 3]);
negativeFeedback = tf([1], [1]);

% a) Compute the closed-loop transfer function
feedbackSystem = feedback(series(controller, plant), negativeFeedback);
disp('a) Compute the closed-loop transfer function:');
feedbackSystem
disp('********************');

% b) Obstain the closed-loop system unit step response with the step
% function
minRealFeedbackSystem = minreal(feedbackSystem);
[stepResponse, stepResponseTime] = step(minRealFeedbackSystem);
plot(stepResponseTime, stepResponse);
disp('b) Obstain the closed-loop system unit step response with the step function:');
disp('Plot is shown in figure');
disp('********************');

% b) Verify that the final value of the output is 2/5
finalValue = stepResponse(end);
disp('b) Verify that the final value of the output is 2/5:');
finalValue
disp('********************');