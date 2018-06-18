% DEMO - jednoduchý predikèní kodér (DPCM) se zpetnou vazbou
% 
% Function demonstrates DPCM encoding of image
% and shows encoded and decoded image matrix [e_pq, x_r]
% 
% Optional inputs:
%
% ALPHA - input vector of  weights, lenght of this vector determines 
%         the predictor order - number of samples used for prediction
% QBIT - integer value of bits for quantization (including sign bit)
%==========================================================================

% 2011, 2012 Ján Paukeje, mírnì upravil P. Rajmic 2012
 
  function demo_predict_codec(alpha,qbits)

close all;
clc;
%=========== Default values - if calling function with no inputs ==========
%==========================================================================
if nargin == 0
 alpha = [0.2 0.2 0.2 0.2 0.2]';
 qbits = 4;
end

%=========== Input Exception Handling =====================================
%==========================================================================
if sum(alpha)~= 1
    error('Sum of weights must be 1')
end

%=========== Initialization of variables ==================================
%==========================================================================
% returns test image in matrix X, 1 layer, using colormap MAP
% load woman;
X = imread('woman.png');
X = double(X);

% return size, number of rows and columns of matrix X
[rows, cols, layers] = size(X); 

% max signal sample value
v = max(max(X));

% normalize matrix X to 1
x_n = X/v;

% order of predictor, number of samples used for prediction
order = length(alpha); 

% initializate vector K used for prediction (will be empty)
K = zeros(1,order); 

% calculate qantization step, one bit is used for SIGN!!!
qstep = 2^(-(qbits-1));

%============== ENCODING + QUANTIZATION ===================================
%==========================================================================

for i=1:rows 
    for j=1:cols
            
            % calculate predicted sample as sum of previous samples 
            % used for prediction in vector K, weighted by vector alpha 
            x_p = K*alpha; % scalar product sum(alpha.*K)
            
            % difference between new input sample and predicted sample
            e_p = x_n(i,j) - x_p;
            
            % quantize subtracted e_p sample (difference)
            % quant je z Neural Network toolboxu
            %e_pq(i,j) = quant(e_p,qstep);
            e_pq(i,j) = qstep*round(e_p/qstep);
            
            % renewed sample from difference and predicted sample
            x_nr = e_pq(i,j)+ x_p;
            
            % add renewed sample to vector K, so it takes an effect
            % in next prediction
            K(1:order) = [K(2:order), x_nr];
    end
end

%============== DECODING ==================================================
%==========================================================================
for i=1:rows 
    for j=1:cols
            
            % calculate predicted sample as sum of previous samples 
            % used for prediction in vector K, weighted by vector alpha 
            x_p = K*alpha;
            
            % reconstruction - addition of difference (quantized) sample
            % and predicted sample from reconstructed sample
            x_r(i,j) = e_pq(i,j) + x_p;
            
            % add currently reconstructed sample to vector K   
            K(1:order) = [K(2:order), x_r(i,j)];
    end
end

%================  SHOW and SAVE original and output ======================
%==========================================================================

figure(1)

%% ORIGINAL image
subplot(2,3,1)
imshow(x_n);
h=title('\bf Original image ');
% samples histogram of original image
subplot(2,3,4)
% x_n=sort(reshape(x_n,1,rows*cols));
hist(reshape(x_n,1,rows*cols));
xlabel('{\itsample value (-) \rightarrow}');
ylabel('{\itoccurrence  (-) \rightarrow}');

%% errors of prediction
% normalizing differential image to show output
e_pq_s = e_pq + 1; %shift to [0,2]
% max signal sample value
v = max(max(e_pq_s));
% normalize matrix e_pq_s to 1
e_pq_s = e_pq_s/v;

subplot(2,3,2);
imagesc(e_pq)
imshow(e_pq_s);
h=title('\bf Encoded image');
% samples histogram of output image
subplot(2,3,5)
e_pq_s=sort(reshape(e_pq_s,1,rows*cols));
hist(e_pq_s);
xlabel('{\itsample value (-) \rightarrow}');
ylabel('{\itoccurrence (-) \rightarrow}');

%================  SHOW differential and reconstructed image =====
%==========================================================================

% normalizing reconstructed image to show output
x_r = x_r-0.5;
% max signal sample value
v = max(max(x_r));
% normalize to 1
x_r = x_r/v;

% OUTPUT reconstructed (decoded) image
subplot(2,3,3)
imshow(x_r);
h=title('\bf Decoded image ');
subplot(2,3,6)
% samples histogram of output (reconstructed - decoded) image
% x_r=sort(reshape(x_r,1,rows*cols));
hist(reshape(x_r,1,rows*cols));
xlabel('{\itsample value (-) \rightarrow}');
ylabel('{\itoccurrence (-) \rightarrow}');

%% Error of reconstruction and plot
figure(2)
err = x_r - x_n;
norm(err)
imagesc(err)
% colorbar
title('Error of reconstruction')
