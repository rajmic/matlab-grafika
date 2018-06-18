% vytvori prouzek s barvami ve viditelnem pasmu

clc
close all

%vlnove delky
wavelengths = 380:2:720;

% %prislusne moduly spektra - pomocne, vsechny shodne
% psd = ones(length(wavelengths),1);

%vypocet RGB souradnic pro danou vlnovou delku na zaklade zjednoduseneho
%modelu lidskeho videni
[r, g, b] = wavelength2rgb(wavelengths);


spektrum = zeros(1,numel(wavelengths),3);
spektrum(:,:,1) = r;
spektrum(:,:,2) = g;
spektrum(:,:,3) = b;

figure;
imagesc(wavelengths,[1,1],spektrum/255);
%nastaveni parametru grafu

% title('Spektralni hustota vykonu barvy')
xlabel('Vlnova delka [nm]')
% ylabel('Vykon')
set(gca,'YTick',[]) %zruseni vertikalni osy
axis tight