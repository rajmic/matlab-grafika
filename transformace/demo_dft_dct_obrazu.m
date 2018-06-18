%Ukazka vypoctu dvojrozmerne DFT a DCT obrazu o velikosti 8x8 pixelu

close all

%% Obraz
obraz = [
    52    55    61    66    70    61    64    73
    63    59    55    90   109    85    69    72
    62    59    68   113   144   104    66    73
    63    58    71   122   154   106    70    69
    67    61    68   104   126    88    68    70
    79    65    60    70    77    68    58    75
    85    71    64    59    55    61    65    83
    87    79    69    68    65    76    78    94];

% obraz = [
%     -76      -73      -67      -62      -58      -67      -64      -55
%     -65      -69      -73      -38      -19      -43      -59      -56
%     -66      -69      -60      -15       16      -24      -62      -55
%     -65      -70      -57       -6       26      -22      -58      -59
%     -61      -67      -60      -24       -2      -40      -60      -58
%     -49      -63      -68      -58      -51      -60      -70      -53
%     -43      -57      -64      -69      -73      -67      -63      -45
%     -41      -49      -59      -60      -63      -52      -50      -34];

%zobrazeni
figure
imshow(obraz, [])
title('Originalni obraz')

%uprava stejnosmerne slozky
% obraz = obraz-128
obraz = obraz-mean(obraz(:))  %zbavime se ji odectenim prumeru; ostatnich slozek se to nedotkne

%% DFT (vypoctena pomoci FFT2)
obraz_fft = fft2(obraz) / 8;  %unitarni FFT
%modul
obraz_fft_abs = abs(obraz_fft);
%zaokrouhlena verze
% obraz_fft_abs_round = round(obraz_fft_abs);

%% DCT
obraz_dct = dct2(obraz);
obraz_dct_abs = abs(obraz_dct);
% obraz_dct_round = round(obraz_dct);

%% normalizace a zobrazeni
% obraz_fft_abs_normalized = obraz_fft_abs/max(max([obraz_fft_abs obraz_dct_abs]))
obraz_fft_abs_normalized = obraz_fft_abs/max(max(obraz_fft_abs))
obraz_dct_abs_normalized = abs(obraz_dct)/max(max(obraz_dct_abs))

%zobrazeni
%imshow(obraz_fft_abs, [])
figure
% imshow(log10(obraz_fft_abs_normalized), [])
imshow(obraz_fft_abs_normalized, [])
title('DFT obrazu (s vymazanou DC slozkou)')

%zobrazeni
% figure
% imshow(obraz_dct, [])
figure
% imshow(log10(obraz_dct_abs_normalized), [])
imshow(obraz_dct_abs_normalized, [])
title('DCT obrazu (s vymazanou DC slozkou)')

%% Profily energie
energie_fft = (sort(obraz_fft_abs(:),'descend')).^2; % / sum(obraz_dct_abs(:));
energie_dct = (sort(obraz_dct_abs(:),'descend')).^2; %/ sum(obraz_dct_abs(:));

figure
h_fft = bar(energie_fft);
hold on
h_dct = bar(energie_dct,'r','BarWidth',.45);
axis tight
title('Koncentrace energie obrazu v transformacnich koeficientech (mimo DC)')
legend('DFT','DCT')