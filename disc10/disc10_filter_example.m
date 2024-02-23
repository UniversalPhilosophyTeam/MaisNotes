%% Discusion 10 Filtering Examples

%% Low pass filter

% location of zeros and poles
zs = exp(j*pi*[0.5 -0.5 0.75 -0.75 1]);
ps = [0.6 0.8 0.8 0.8 0.8].*exp(j*pi*[0 0.25 -0.25 0.5 -0.5]);
%ps = 0.6;

% coefficients of numerator of the transfer function H(z)
b = poly(zs);

% coefficients of denominator of the transfer function H(z)
a = poly(ps);

fs = 8000;
plot_length = 100;
figure; freqz(b,a, plot_length, fs); title('Frequency Response for Low Pass Filter');
figure; zplane(b,a); title('Pole-Zero Plot for Low Pass Filter');

%% What is happening when we use freqz?

[h,f] = freqz(b,a, plot_length, fs);
% h is a complex vector that contains the magnitude response
% f is the frequencies corresponding to h

% To see the magnitude of the frequency response |H(w)|
figure; plot(f,abs(h));

% Note that freqz has this same plot, but in dB: scaled by logarithm

% Question: why does freqz only output/plot half of the spectrum? What are they
% assuming?

%% Comb filter 

zs = exp(j*pi*[0.25 -0.25 0.5 -0.5 0.75 -0.75 1]);
ps = 0.9*exp(j*pi*[0.25 -0.25 0.5 -0.5 0.75 -0.75 1]);

b = poly(zs);
a = poly(ps);

fs = 8000;
plot_length = 100;
figure; freqz(b,a, plot_length, fs); title('Frequency Response for Comb Filter');
figure; zplane(b,a); title('Pole-Zero Plot for Comb Filter');

%% Butterworth filter

% normalized cutoff frequency, between 0 and 1 (corresponding to 0 and pi)
cutoff = 0.4;
butter_order = 10;
[zs, ps, k] = butter(butter_order, cutoff, 'low'); % or 'high'
b = poly(zs);
a = poly(ps);

fs = 8000;
plot_length = 100;
figure; freqz(b,a, plot_length, fs); title('Frequency Response for Butterworth Filter');
figure; zplane(b,a); title('Pole-Zero Plot for Butterworth Filter');
%%
bands = [0.2 0.3];
butter_order = 3;
[zs, ps, k] = butter(butter_order, bands, 'stop'); % or 'bandpass'
b = poly(zs);
a = poly(ps);

fs = 8000;
plot_length = 100;
figure; freqz(b,a, plot_length, fs); title('Frequency Response for Butterworth Filter');
figure; zplane(b,a); title('Pole-Zero Plot for Butterworth Filter');
