% Displays the 2D-DCT orthonormal basis of R^{8×8}
%
% (c) 2023, Pavel Rajmic, Brno University of Technology

%% Set parameters
N = 8; %size of the vector

T = 1;
border = 2;  %size of the border between images
bckgrnd = [.5 .15 .2];  %background color (will be color shifted at the end :()

close all

%% 1D DCT basis, discrete time
n = (0:N-1)'; %time vector
ln = length(n);
DCTvectors = zeros(ln,N); %memory allocation

t = linspace(0,T,300)'; %time vector
lt = length(t);
DCTfunctions = zeros(lt,N); %memory allocation

for f = 0:N-1
    DCTvectors(:,f+1) = cos(pi*(n+0.5)*f/N); %vectors as columns
    DCTfunctions(:,f+1) = cos(pi*(t+0.5)*f/N); % * sqrt(2/N);
end

%normalization
DCTvectors(:,1) = DCTvectors(:,1) * sqrt(1/N); 
DCTvectors(:,2:N) = DCTvectors(:,2:N) * sqrt(2/N);
DCTfunctions(:,1) = DCTfunctions(:,1) * sqrt(1/N); 
DCTfunctions(:,2:N) = DCTfunctions(:,2:N) * sqrt(2/N);

DCTvectors'*DCTvectors %check orthonormality

% figure('Name','DCT basis vectors');
% for f = 0:N-1
%     subplot(N,1,f+1);
%     stem(n,DCTvectors(:,f+1),'b')
% end

%% 2D DCT orthobasis, by tensor product(s)
canvas = ones((N+1)*border+N*N,(N+1)*border+N*N,3); %RGB canvas memory allocation
canvas(:,:,1) = bckgrnd(1); %spreading single R value over all image
canvas(:,:,2) = bckgrnd(2); %spreading single G value over all image
canvas(:,:,3) = bckgrnd(3); %spreading single B value over all image

matrices = cell(N,N);
maximum = -Inf;
minimum =  Inf;

%loop over all basis matrices
for kx = 0:(N-1)
    for ky = 0:(N-1)
        matrices{kx+1,ky+1} = DCTvectors(:,kx+1) * (DCTvectors(:,ky+1))';
        %update max and min because of displaying scale
        maximum = max(maximum, max(matrices{kx+1,ky+1},[],'all'));
        minimum = min(minimum, min(matrices{kx+1,ky+1},[],'all'));
    end
end
absmaximum = max(abs(maximum),abs(minimum));

%check orthonormality (random pick)
sum(matrices{3,4} .* matrices{5,7},'all')
sum(matrices{3,4} .* matrices{3,4},'all')

%loop again and fill the canvas
for kx = 0:(N-1)
    for ky = 0:(N-1)
        startindexx = border*(kx+1)+1+N*kx;
        stopindexx = startindexx+N-1;
        startindexy = border*(ky+1)+1+N*ky;
        stopindexy = startindexy+N-1;

        for rgb =1:3 %repeat to achieve grayscale
            canvas(startindexx:stopindexx,startindexy:stopindexy,rgb) = ...
            matrices{kx+1,ky+1}/absmaximum;
        end
    end
end
         
%shift colors (for I am not able to force imshow to scale the RGB image automatically)
canvas = (canvas + 1)/2; %old range was [-1 1], new range is [0 1]

figure
imshow(canvas)
% imshow(canvas,[-1 1])
axis image
% axis square
