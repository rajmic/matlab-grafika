% Demo ukazuje interpolaci obrazku pomoci ruznych jader

% (c) 2020 Lubomir Skvarenina, Pavel Rajmic, VUT v Brne

%% Cistka
clear all;
close all;
clc;

%% Nacteni obrazku
I_orig = imread('lena_grayscale_64x64.png');
imshow(I_orig)
axis image
% I = I(1:32,1:32);
I = imresize(I_orig, 0.125, 'nearest');  %podvzorkovani a ziskani hodnot k interpolaci
imshow(I)
axis image

%% Nastaveni
X = 0:size(I,2)-1;
Y = 0:size(I,1)-1;
V = double(I);
dif = 0.01; %rozliseni interpolantu
xgv = 0:dif:size(I,2)-1; %jemna mrizka pro interpolant
ygv = 0:dif:size(I,1)-1;
[X,Y] = ndgrid(X,Y);
[Xq,Yq] = ndgrid(xgv,xgv);

limitz = [0 7 0 7 0 255];
uhel = [-66 39];

%% Vypocet
method = 'nearest';
F1 = griddedInterpolant(X,Y,V, method);
Vq1 = F1(Xq,Yq);
method = 'linear';
F2 = griddedInterpolant(X,Y,V, method);
Vq2 = F2(Xq,Yq);
method = 'cubic';
F3 = griddedInterpolant(X,Y,V, method);
Vq3 = F3(Xq,Yq);

%% Vykreslenie 
f1 = figure('name','2D interpolace nejblizsim sousedem','NumberTitle','off');
surf(Xq,Yq,Vq1,'LineStyle','none','EdgeColor','none');
view(uhel);
colormap(gray);
caxis([0 255]);
axis tight;
axis(limitz);
% colorbar
hold on
stem3(X,Y,I,'filled')

f2 = figure('name','2D interpolace (bi)linearni','NumberTitle','off');
surf(Xq,Yq,Vq2,'LineStyle','none','EdgeColor','none');
view(uhel);
colormap(gray);
caxis([0 255]);
axis tight;
axis(limitz);
% colorbar
hold on
stem3(X,Y,I,'filled')

f3 = figure('name','2D interpolace (bi)kubicka','NumberTitle','off');
surf(Xq,Yq,Vq3,'LineStyle','none','EdgeColor','none');
view(uhel);
colormap(gray);
caxis([0 255]);
axis tight;
axis(limitz);
% colorbar
hold on
stem3(X,Y,I,'filled')


%% Ulozeni obrazku
% figure(f1), print('interpolace_2D_neigh', '-depsc2');
figure(f1), print('interpolace_2D_neigh', '-dpng');
% figure(f2), print('interpolace_2D_linear', '-depsc2');
figure(f2), print('interpolace_2D_linear', '-dpng');
% figure(f3), print('interpolace_2D_cubic', '-depsc2');
figure(f3), print('interpolace_2D_cubic', '-dpng');