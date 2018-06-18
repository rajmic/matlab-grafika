function h = plot_color_power_spectral_density(wavelengths, powers)

% vykresli PSD barvy barevne
%
% wavelengths.... vlnove delky (horizontalni osa), ekvidistantni,
%                 v nanometrech, cela cisla
% powers......... moduly spektra (vertikalni osa)
%
% h.............. handle na nove vytvoreny obrazek



%kontrola
if length(wavelengths)<2
    error('')
end

if length(wavelengths) ~= length(powers)
    error('')
end

%vypocet RGB souradnic pro danou vlnovou delku na zaklade zjednoduseneho
%modelu lidskeho videni
[r, g, b] = wavelength2rgb(wavelengths);

%zjisteni delky intervalu
%(za predpokladu ekvidist. vektoru vln. delek)
delka = wavelengths(2)-wavelengths(1);

%vykresleni
h = figure;

for cnt = 1:length(wavelengths)
    hh = bar(wavelengths(cnt),powers(cnt));
    set(hh,'FaceColor',[r(cnt), g(cnt), b(cnt)]/255)
    set(hh,'BarWidth',delka)
    hold on
end

%nastaveni parametru grafu
set(gca,'XTickMode','auto')
title('Spektralni hustota vykonu barvy')
xlabel('Vlnova delka [nm]')
ylabel('Vykon')
axis tight