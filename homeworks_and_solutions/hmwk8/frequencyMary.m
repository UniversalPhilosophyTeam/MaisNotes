% close all; clear all;
% 
% load marySong.mat

% marySong holds the song "mary had a little lamb"
% fs holds the sampling rate (44100 samples per second)
% M holds the number of notes (or rests) in the song
% Each note (or rest) is a quarter second, so the song is M*.25 seconds long.

sound(marySong,fs)
n = length(marySong);
Y = fft(marySong);
Y_shift = fftshift(abs(Y));
midpt = ceil(length(Y_shift)/2);
window_width = 8000;
figure; subplot(2,1,1); stem(Y_shift(midpt-window_width:midpt+window_width));

% Uniform under-sample every Nth sample
N = 35; 
ii=1:N:n;
y = marySong(ii);


%% Sinc interpolation result

% 
% m=1:n;
% y_sinc=zeros(1,n);
% for i=1:length(ii)
%     y_sinc = y_sinc + y(i)*sinc(m-ii(i));
% end
% sound(y_sinc,fs)
% 
% Y_sinc = fft(y_sinc);
% subplot(3,1,2); stem(abs(Y_sinc));


%% Linear interpolation result

tfull = 1/fs:1/fs:(0.25*M);
tii = tfull(ii);
lastidx = find(tfull==tii(end));
tfull = tfull(1:lastidx);
y_interp = interp1(tii,y,tfull,'linear');
sound(y_interp,fs)



Y_interp = fft(y_interp);
Y_interp_shift = fftshift(abs(Y_interp));
midpt = ceil(length(Y_interp_shift)/2);
subplot(2,1,2); stem(Y_interp_shift(midpt-window_width:midpt+window_width));

figure; plot(Y_interp_shift)
hold on;
plot(1:length(Y_shift),Y_shift,'r')

% %% Now let's do the same for a Scarlatti clip
% 
% scarlatti = wavread('scarlattiOrig.wav');
% sound(scarlatti,fs);
% n = length(scarlatti);
% 
% ii=N:N:n;
% y = scarlatti(ii);
% 
% m=1:n;
% y_sinc=zeros(1,n);
% for i=1:length(ii)
%     y_sinc = y_sinc + y(i)*sinc(m-ii(i));
% end
% sound(y_sinc,fs)
% 
% tfull = 1/fs:1/fs:(0.25*M);
% tii = tfull(ii);
% y_interp = interp1(tii,y,tfull,'linear');
% sound(y_interp,fs)

