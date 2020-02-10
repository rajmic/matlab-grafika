% nacte spektra zroju svetla ve viditelne oblasti a vykresli je

% (c) 2020 Pavel Rajmic, Brno University of Technology, Czech Republic


clc
close all

%% spektrum
[wl, psd] = zmerena_spektra_zdroju();

%oriznuti na viditelne
crop = (wl>=380 & wl<=780);
wl = wl(crop,:);
psd = psd(crop,:);


%% vykresleni
% OSRAM
plot_color_power_spectral_density(wl, psd(:,1), false)
title('')
ylabel('Vykon [W/nm]')

% Hynek Medricky -- mod 1 (http://www.design-light.cz/den-bulb.html)
plot_color_power_spectral_density(wl, psd(:,2), false)
title('')
ylabel('Vykon [W/nm]')

% Hynek Medricky -- mod 2 (http://www.design-light.cz/den-bulb.html)
plot_color_power_spectral_density(wl, psd(:,3), false)
title('')
ylabel('Vykon [W/nm]')

% Hynek Medricky -- mod 3 (http://www.design-light.cz/den-bulb.html)
plot_color_power_spectral_density(wl, psd(:,4), false)
title('')
ylabel('Vykon [W/nm]')
