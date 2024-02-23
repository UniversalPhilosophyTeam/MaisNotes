% load image and cast to a double
img = double(imread('Lenna.png'));

% note that this is a 3D matrix because the 3rd dimension holds the RGB
% values!

% crop image to make it rectangular (and more interesting!)
img = img(:,51:512-50,:);

% filter that sums to one to avoid scaling the image
h = [8 4 4 2 2 2 0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 2 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 2 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0 1 0 0 0 0 0; 
    0 0 0 0 0 0 0 0 0 1 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 1 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 1 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 1 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 1];
h = h/sum(h(:));

for color_ndx = 1:3
    blurry_img(:,:,color_ndx) = conv2(img(:,:,color_ndx),h,'valid');
end
figure; 
subplot(1,3,1); imshow(img/255);
subplot(1,3,2); imshow(blurry_img/255);

%% Deconvolution by Inverse Filter

N = size(blurry_img,1);
M = size(blurry_img,2);
H = fft2(h,N,M);
for color_ndx = 1:3
    Blurry_img(:,:,color_ndx) = fft2(blurry_img(:,:,color_ndx));  
    Deblurred_img(:,:,color_ndx) = Blurry_img(:,:,color_ndx)./H;
end

deblurred_img = real(ifft2(Deblurred_img));
% clip values larger than 255 due to ringing
deblurred_img = min(deblurred_img,255); 
subplot(1,3,3); imshow(deblurred_img/255);

%% Look at filter and its frequency response
figure; 
subplot(1,2,1); imagesc(h); colormap('gray'); 
colorbar; axis equal; axis tight;
subplot(1,2,2); imagesc(abs(fft2(h))); colormap('gray'); 
colorbar; axis equal; axis tight;

%% Now appply deconvolution to a noisy, blurred image

SNR = 10; % in dB
signal_amp = norm(img(:))/sqrt(numel(img)); % root mean square amplitude
noise_std = signal_amp*10^(-SNR/20);
% zero-mean, additive, white Gaussian noise
% can apply other kinds of noise using imnoise
noisy_img = blurry_img + noise_std*randn(size(blurry_img));
noisy_img = max(min(noisy_img,255),0);

for color_ndx = 1:3
    Noisy_img(:,:,color_ndx) = fft2(noisy_img(:,:,color_ndx));  
    Deblurred_noisy_img(:,:,color_ndx) = Noisy_img(:,:,color_ndx)./H;
end

figure; 
subplot(1,3,1); imshow(img/255);
subplot(1,3,2); imshow(noisy_img/255);
deblurred_noisy_img = real(ifft2(Deblurred_noisy_img));
deblurred_noisy_img = min(deblurred_noisy_img,255); 
subplot(1,3,3); imshow(deblurred_noisy_img/255);
