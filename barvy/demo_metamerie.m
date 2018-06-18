% DEMO ukazuje metamericka spektra
close all

%% Iluminant C
% nacteni dat
[values, wavelengths] = metameric_spectra_C();

%% vykresleni
figure
plot(wavelengths, values) %dohromady vsechny
xlabel('nm')
ylabel('%')

figure
plot(wavelengths, values(:,[2 4 8])) %vybrane, nepodobne
xlabel('nm')
ylabel('%')
title('Odrazove spektralni charakteristiky materialu metamernich pro iluminant C')

% for cnt = 1:size(values,2)
%     figure
%     plot(wavelengths, values(:,cnt))
% end
% legend

%% Iluminant D65
% nacteni dat
[values, wavelengths] = metameric_spectra_D65();

%% vykresleni
figure
plot(wavelengths, values) %dohromady vsechny
xlabel('nm')
ylabel('%')

figure
plot(wavelengths, values(:,[2 4 8])) %vybrane, nepodobne
xlabel('nm')
ylabel('%')
title('Odrazove spektralni charakteristiky materialu metamernich pro iluminant D65')