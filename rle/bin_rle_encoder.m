function [bin_data] = bin_rle_encoder(input_data, zero_bits, one_bits)
% Kodovanie binarnych obrazov pomocou RLE
% 
% input_data....vstupna binarna matica vyjadrujuca obraz 
% zero_bits.....pocet binarnych miest pre vyjadrenie sekvencie nul
% one_bits......pocet binarnych miest pre vyjadrenie sekvencie jednotiek
%
% rle_encoded....vystupna postupnost kodovaneho obrazu v dekadickom tvare
% bin_data.......vystupna postupnost kodovaneho obrazu v binarnom tvare
%
% obraz je vyjadreny v binarnej forme, 1bpp 

% (c) 2018 M. Matisko, Brno University of Technology

%% kontrola binarnej formy vstupnych dat obrazu
if ~ismatrix(input_data) && min(input_data) > -1 && max(input_data) < 2
    error('Obraz musi byt v binarnej forme');
end

%% RLE kodovanie
bit=0;
count=0;
index=0;
rle_encoded(1:1)=0;
for row=1:size(input_data,1)
    for col=1:size(input_data,2)
        % kodovanie postupnosti aktualne nastaveneho bitu
        if (input_data(row,col)==bit)
            count=count+1;
            if (bit==0 && count==(2^zero_bits-1)) || (bit==1 && ...
                count==(2^one_bits-1))
                % kodovanie postupnosti aktualne nastaveneho bitu po
                % preteceni limitu urceneho poctom kodovacich bitov
                index=index+1;
                rle_encoded(index)=count;
                count=0;
                bit=mod((bit+1),2);
            end
        else
            % nasledujuci bit je opacny, zapis do medzivysledku
            index=index+1;
            rle_encoded(index)=count;
            count=1;
            bit=mod((bit+1),2);
        end
    end
end
index=index+1;
rle_encoded(index)=count;

%% konverzia dekadickych medzivysledkov na binarne vysledky
bin_data(1:1)=0;
bit=0;
out_index=1;
for in_index=1:size(rle_encoded,2)
    if bit==0
        % dekodovanie postupnosti bitov 0
        %bin_value=decimalToBinaryVector(rle_encoded(in_index),zero_bits,...
                  %'MSBFirst');
        bin_value=dec2bin(rle_encoded(in_index),zero_bits);
        for bin_index=1:size(bin_value,2)
            bin_data(out_index)=bin_value(bin_index);
            out_index=out_index+1;
        end
    else
        % dekodovanie postupnosti bitov 1
        %bin_value=decimalToBinaryVector(rle_encoded(in_index),one_bits, ...
         %         'MSBFirst');
        bin_value=dec2bin(rle_encoded(in_index),one_bits);
        for bin_index=1:size(bin_value,2)
            bin_data(out_index)=bin_value(bin_index);
            out_index=out_index+1;
        end    
    end
    bit=mod((bit+1),2);
end
end