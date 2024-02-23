%% ECE431: Homework 10
%
% * Author:     John Lipor
% * Due:        11/24/09
%
%% Problem 10.3 (c)
% Plot the magnitude of the filter frequency response using MATLAB. You can
% also do latex here, as in $\sum_{n = 0}^{N-1} x_{n}e^{-j2\pi kn/N}$. If I
% were a student, I would probably put my answer here and describe the
% script below.

B = [1 1.414 1 0 -1 -1.414 -1];
A = [1 -1.3435 0.9025];
[H,W] = freqz(B,A);

plot(W,abs(H))
title('Frequency Response of Filter')
xlabel('Frequency, rad')
ylabel('Magnitude')