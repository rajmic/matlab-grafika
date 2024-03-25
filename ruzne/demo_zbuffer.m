%Demonstruje kvantovani (zaokrohlouvani) pri urcovani hodnoty v z-bufferu
%
%Zpracováno podle
% https://www.sjbaker.org/steve/omniv/love_your_z_buffer.html

% 2024 Pavel Rajmic, VUT v Brne

%% Volba parametru
zf = 100; %far plane vzdalenost od kamery
zn = 5;  %near plane vzdalenost od kamery
N = 3; %pocet bitu z-bufferu (typicky 24 nebo 32, nicmene aby byl obrazek ilustrativni, je treba volit mensi cislo)


close all
z = linspace(zn,zf,5000); %generovani bodu mezi zn a zf (mimo nedava smysl, body jsou oriznuty)

clen = zf/(zf-zn); %clen, ktery se opakuje
zavorka = clen - (zn * clen)./z;
pred_zaokrouhl = 2^N*zavorka;
po_zaokrouhl = floor(pred_zaokrouhl);

% clen1 = (zf+zn)/(zf-zn);
% clen2 = (2*zn*zf)/(zf-zn) * 1./z;
% pred_zaokrouhl = (clen1+clen2);
% po_zaokrouhl = round(pred_zaokrouhl);

plot(z,pred_zaokrouhl)
xlabel(['vzdalenost od kamery (z), mezi zn=' num2str(zn) ' a zf=' num2str(zf)])
ylabel('hodnota z-bufferu')
hold on
plot(z,po_zaokrouhl)

xlim([0 zf*1.1])