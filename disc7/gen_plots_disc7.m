% generate plots for disc 7 problem

 X = [4:-1:0 1:3].';
 N = length(X)
 x = ifft(X);
 
 y_u = reshape([x'; zeros(1,N)],2*N,1);
 Y_u = fft(y_u);
 
 %y_z = [x; zeros(N,1)];
 %Y_z = fft(y_z);
 
 %Y_z = [X; zeros(N,1)];
 %y_z = ifft(Y_z);
 
 figure; 
 subplot(3,1,1); stem(X);
 subplot(3,1,2); stem(Y_u);
 
 figure; 
 %subplot(3,1,1); stem(x);
 %subplot(3,1,3); stem(y_z);