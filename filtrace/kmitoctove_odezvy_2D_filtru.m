% Vykreslovani kmitoctove charakteristiky a ucinku linearnich 2D filtru.
% Take vygeneruje latexove retezce pro sazbu pouzitych matic.
%
% Pred spustenim je potreba nacist z MAT souboru jmenem "2D_filtry":
%    - cell array "filtry" s filtry velikosti 3x3
%    - normalizacni koeficienty "normalizace" jim prislusne, kterymi se deli
% (load 2D_filtry)
%

close all
clc

%% Nastaveni parametru
% imagename = 'testpat1.png';
imagename = 'astig.gif';
% adresar = 'vystupy/';
uloz_kmit_char = false; %true; %
uloz_filtrovane_obr = false; %true; %
% filtrace = 1;

%% Uvodni blok
obr = imread(imagename);

% vykresleni originalu
figure
imagesc(obr)
colormap(gray)
axis image
title('Original')

% pocet filtru
pocet = length(filtry);

% pro ucely vykreslovani
% sloupcu = 1 + filtrace;
% radku = pocet;
% kmit = figure;
% obrazky = figure;

% % otevreni souboru (LaTeX) pro zapis
% fid = fopen([adresar 'latex_kod.txt'],'w');

%% Hlavni cyklus
for cnt = 1:pocet
    % kmit. charakteristika
    f = filtry{cnt};
%     tmp = sym(f); % pro ucely generovani LaTeX-kodu nize
    f = f/normalizace(cnt);
%     subplot(radku,sloupcu,cnt*sloupcu-1) %figure
    figure
    freqz2(f)
    %ukladani ampl. kmit. char. do obrazku
    if uloz_kmit_char == true
        print('-depsc2','-r100',['kmit_char_amp-' num2str(cnt)])
    end
    
    % filtrace obrazku
    obr_filtered = filter2(f,obr);
%     absmax = max(max(abs(obr_filtered)));
%     obr_filtered = obr_filtered/absmax;
%     obr_filtered = uint8(obr_filtered*255);

    %uprava do rozsahu 0 az 255
    maximum = max(max(obr_filtered));
    minimum = min(min(obr_filtered));
    obr_filtered = (obr_filtered - minimum) * 255/(maximum-minimum);
    obr_filtered = uint8(obr_filtered);
    
    %zobrazeni
    figure
    imagesc(obr_filtered)
    colormap(gca,'gray')
    axis(gca,'image')
    
    %ukladani
    if uloz_filtrovane_obr
        imwrite(obr_filtered,['obrazek_filtrovany-' num2str(cnt) '.png'],'png')
    end
%     end
    
%     %generovani LaTeX-kodu
%     f_latex = latex(tmp);
%     if normalizace(cnt) ~= 1
%         fprintf(fid,'%s','\frac{1}{');
%         fprintf(fid,'%s',num2str(normalizace(cnt)));
%         fprintf(fid,'%s','} ');
%     end
%     fprintf(fid,'%s',f_latex);
%     fprintf(fid,'%s\n','\\');
end

% % uzavreni souboru
% status = fclose(fid);