% vygeneruje nahodne spektrum barvy ve viditelne oblasti a vykresli jej

clc
close all

%vlnove delky
wl = 380:10:720;

%prislusne nahodne moduly PSD (spektrum)
psd = randi(100, [length(wl) 1]);

% vykresleni
plot_color_power_spectral_density(wl,psd)
