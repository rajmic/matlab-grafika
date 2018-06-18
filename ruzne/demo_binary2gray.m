% demo ukazujici prime binarni kodovani ve srovnani s Grayovym kodem
% (c) 2012-2014 Pavel Rajmic, VUT v Brne


%% vstupni parametry
maximum = 22;

clc

tic

for cnt = 0:maximum
    disp ([int2str(cnt), '  ', dec2bin(cnt), '  ', binary2gray(dec2bin(cnt)) ]);
end

toc