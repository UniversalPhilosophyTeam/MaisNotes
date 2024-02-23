%% load signal, build filter
h = ones(100,1); % moving average
x = load('../hmwk8/marySong.mat');
x = x.marySong(1:2560); % truncate because the song is so long
L = 256; % size of circular buffer is often a power of 2
P = length(h);


%% overlap add

%insert length of fft here
H = fft(h,?); 
% preallocate memory for output
y_a = zeros(?,1); 
numblocks = floor(length(x)/L);
for iblock = 1:numblocks
    % what indeces do we need?
    new_block = x(?:?); 
    %insert length of fft here
    New_Block = fft(new_block,?); 
    New_Out = New_Block.*H;
    % move back to time domain, insert lenght of ifft here
    new_out = ifft(New_Out,?); 
    % add current output to full output at which indeces?
    y_a(?:?) = y_a(?:?) + new_out; 
end

%% overlap save

%insert length of fft here
H = fft(h,?);
% preallocate memory for output
y_s = zeros(?,1);
% how much zero-padding do we need at the beginning?
x_pad = [zeros(?,1); x]; 
numblocks = floor((length(x_pad)-(P-1))/(L-P+1));
for iblock = 1:numblocks
    new_block = x_pad(?:?);
    New_Block = fft(new_block,?);
    New_Out = New_Block.*H;
    new_out = ifft(New_Out,?);
    % what indeces of our output do we use (and not throw away)?
    % where in y will they be stored?
    y_s(?:?) = new_out(?:?);
end

y_true = conv(x,h);

figure; plot(y_true);
hold on;
plot(y_a,'ro');
plot(y_s, 'gx');

% You should see that these plots overlap exactly. y_s is a little shorter
% because the length of x is not a multiple of its block size