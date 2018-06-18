% vyobrazi R,G,B funkce pouzite pri vypoctu barvy z vlnove delky (matching functions)

clc
close all

%vlnove delky
wl = 380:5:720;

%jejich RGB
[R, G, B] = wavelength2rgb(wl);

% vykresleni
plot(wl,R,'r')
hold on
plot(wl,G,'g')
plot(wl,B,'b')

title('Funkce R, G, B pouzite pri prevodu vlnove delky na RGB')
xlabel('nm')
ylabel('R, G, B (0-255)')
set(gca,'YLim',[0 269])