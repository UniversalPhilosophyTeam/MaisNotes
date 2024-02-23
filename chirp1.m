% chirp1.m

% here is the form of a 'chirp' signal that starts at 1000 Hz
% and gradually ramps up to 3000 Hz over 3 seconds.
xa = @(t) cos(2 * pi * (1000+2000/2*t/3) .* t);

Fs = 8192;              % sampling rate in Hz
Ts = 1 / Fs;			% sampling period
n = 0:round(3/Ts);		% 3 seconds of samples
xn = xa(n * Ts);		% samples of signal

specgram(xn, [], Fs)    % display spectrogram (advanced topic!)
sound(xn, Fs)			% listen to chirp signal
