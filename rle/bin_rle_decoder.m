function [rle_decoded] = bin_rle_decoder(input_data, zero_bits, one_bits)
% Kodovanie binarnych obrazov pomocou RLE
% 
% input_data.....sekvencia vstupnych dat
% zero_bits......pocet binarnych miest pre vyjadrenie sekvencie nul
% one_bits.......pocet binarnych miest pre vyjadrenie sekvencie jednotiek
%
% rle_decoded....vystupna matica dekodovaneho obrazu
%
% obraz je vyjadreny v binarnej forme, 1bpp

% (c) 2018 M. Matisko, Brno University of Technology


%% kontrola binarnej formy vstupnych dat
if ~ismatrix(input_data) && min(input_data) > -1 && max(input_data) < 2
    error('Obraz musi byt v binarnej forme');
end

%% vıpoèet rozmerov obrazu
image_size=size(input_data, 2); %sqrt(size(input_data));

%% dekódovanie obrazu pomocou RLE
bit=0;
in_index=1;
out_index=1;
rle_decoded(1:1)=0;
while in_index<=image_size
    % dekodovanie postupnosti bitov 0
    if bit==0
        top_border=(in_index+zero_bits-1);
        bin_count=input_data(1,in_index:top_border);
        %count_of_zeroes=binaryVectorToDecimal(bin_count, 'MSBFirst');
        count_of_zeroes=bin2dec(char(bin_count));
        for j=1:count_of_zeroes
            rle_decoded(1,out_index)=0;
            out_index=out_index+1;
        end
    else 
        % dekodovanie postupnosti bitov 1
        top_border=(in_index+one_bits-1);
        bin_count=input_data(1,in_index:top_border);
        %count_of_ones=binaryVectorToDecimal(bin_count);
        count_of_ones=bin2dec(char(bin_count));
        for j=1:count_of_ones    
            rle_decoded(1,out_index)=1;
            out_index=out_index+1;
        end
    end

    in_index=top_border+1;
    bit=mod((bit+1),2);
end
end