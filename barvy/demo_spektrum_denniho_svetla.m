% DEMO spektralni charakteristiky "denniho" svetla

close all

%ziskani dat
[values, temperatures, wavelengths] = daylight_spectrum();

%vykresleni
plot(wavelengths, values)
axis tight
xlabel('nm')
title('Relative power distribution of daylight for different temperatures')
legend(num2str(temperatures))
text(455,80, [num2str(temperatures(1)) ' K'])
text(500,180, [num2str(temperatures(end)) ' K'])