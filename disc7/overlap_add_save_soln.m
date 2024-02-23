h = ones(100,1);
x = load('../hmwk8/marySong.mat');
x = x.marySong(1:2560);
L = 256; % size of circular buffer
P = length(h);


%% overlap add
H = fft(h,L+P-1);
y_a = zeros(length(x)+P-1,1);
numblocks = floor(length(x)/L);
for iblock = 1:numblocks
    new_block = x((iblock-1)*L+1:iblock*L);
    New_Block = fft(new_block,L+P-1);
    New_Out = New_Block.*H;
    new_out = ifft(New_Out,L+P-1);
    y_a((iblock-1)*L+1:iblock*L+P-1) = y_a((iblock-1)*L+1:iblock*L+P-1) + new_out;
end

%% overlap save
H = fft(h,L);
y_s = zeros(length(x)+P-1,1);
x_pad = [zeros(P-1,1); x];
numblocks = floor((length(x_pad)-(P-1))/(L-P+1));
for iblock = 1:numblocks
    new_block = x_pad((iblock-1)*(L-P+1)+1:iblock*(L-P+1)+P-1);
    New_Block = fft(new_block,L);
    New_Out = New_Block.*H;
    new_out = ifft(New_Out,L);
    y_s((iblock-1)*(L-P+1)+1:iblock*(L-P+1)) = new_out(P:L);
end

y_true = conv(x,h);

figure; plot(y_true);
hold on;
plot(y_a,'ro');
plot(y_s, 'gx');