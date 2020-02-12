% nacte spektra zroju svetla ve viditelne oblasti a vykresli je

% (c) 2020 Pavel Rajmic, Brno University of Technology, Czech Republic


clc
close all

%% nacteni spekter
[wl1, psd1] = zmerena_spektra_zdroju();

%oriznuti na viditelne
crop = (wl1>=380 & wl1<=780);
wl1 = wl1(crop,:);
psd1 = psd1(crop,:);

%zarovka
[wl2, psd2] = spektrum_zarovky();

%% vykresleni
% OSRAM LED
plot_color_power_spectral_density(wl1, psd1(:,1), false)
title('')
ylabel('Vykon [W/nm]')

% Hynek Medricky -- mod 1 (http://www.design-light.cz/den-bulb.html)
plot_color_power_spectral_density(wl1, psd1(:,2), false)
title('')
ylabel('Vykon [W/nm]')

% Hynek Medricky -- mod 2 (http://www.design-light.cz/den-bulb.html)
plot_color_power_spectral_density(wl1, psd1(:,3), false)
title('')
ylabel('Vykon [W/nm]')

% Hynek Medricky -- mod 3 (http://www.design-light.cz/den-bulb.html)
plot_color_power_spectral_density(wl1, psd1(:,4), false)
title('')
ylabel('Vykon [W/nm]')

% Zarovka obycejna
plot_color_power_spectral_density(wl2, psd2, false)
title('')
ylabel('Normalizovany vykon [W/nm]')