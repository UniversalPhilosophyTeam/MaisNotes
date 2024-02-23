%% Clear old variables, load song
clear all; close all

load marySong.mat

% marySong holds the song "mary had a little lamb"
% fs holds the sampling rate (44100 samples per second)
% M holds the number of notes (or rests) in the song
% Each note (or rest) is a quarter second, so the song is M*.25 seconds long.

sound(marySong,fs)
n = length(marySong);

% This problem will analyze the aliasing that occured in last week's
% problem set more carefully by looking at how the frequency spectrum of
% our signal changes.

%% Spectrum of y[n], Y[k]
% First, we'll look at the spectrum of the original song. Since it is very
% long, we will look at only the central portion of the spectrum. If you
% want to zoom out, you can widen the window_width (up to 159862).
y = marySong;
Y = fftshift(fft(y));
midpt = ceil(length(Y)/2);
window_width = 24000;
viewing_window = midpt-window_width:midpt+window_width;
figure; subplot(3,1,1); stem(abs(Y(viewing_window)));
title('Magnitude of Spectrum of Original Song');

%% Undersampled signal, y_d[n], and the upsampled signal y_s[n]

% Uniform under-sample every Nth sample
N = 35; 
N = 75;
y_d = y(1:N:end);

% Upsampling by N 
y_s = reshape([y_d zeros(n/N,N-1)].',n,1);
Y_s = fftshift(fft(y_s));
subplot(3,1,2); stem(abs(Y_s(viewing_window)));
title('Magnitude of Spectrum of Sampled Song');

%% Linear Interpolation, y_i[n]

tfull = 1/fs:1/fs:(0.25*M);
tii = tfull(1:N:n);
lastidx = find(tfull==tii(end));
tfull = tfull(1:lastidx);
y_i = interp1(tii,y_d,tfull,'linear');
sound(y_i,fs)

Y_i = fftshift(fft(y_i));
subplot(3,1,3); stem(abs(Y_i(viewing_window)));
title('Magnitude of Spectrum of Interpolated Song');
