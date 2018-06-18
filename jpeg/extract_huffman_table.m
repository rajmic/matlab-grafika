function ht = extract_huffman_table(NoOfRepresentants, Symbols_Hex)

% Zkonstruuje Huffmanovu tabulku na zaklade vstupnich poli
% funkce je volana z huffman_table_dc_lum() a z huffman_table_ac_lum()

% (c) 2010-2012 Pavel Rajmic, Brno University of Technology



% %prevedeni na desitkove vyjadreni
% Symbols_Dec = h2d(Symbols_Hex);

%vytvoreni tabulky
%(inspirovano http://stackoverflow.com/questions/662565/how-to-create-huffman-tree-from-ffc4-dht-header-in-jpeg-file)
% numBits = length(NoOfRepresentants);
ht = cell(sum(NoOfRepresentants),2); %vyhrazeni pameti
% binaryCode = 0;
count = 1;
codeString = num2str([]);

for numBits = 1:length(NoOfRepresentants)
    for i = 1 : NoOfRepresentants(numBits)
        %predrazeni nul tolikrat, aby byl kod spravne dlouhy
        for n = length(codeString) : (numBits-1)
%             codeString = ['0' codeString];
            codeString = [codeString '0'];
        end
        
        %ulozeni do tabulky
        ht{count,2} = codeString;
        ht{count,1} = Symbols_Hex(count,:);
%         ht{count,2} = Symbols_Dec(count,:);
        
        %posuny citacu apod.
%         binaryCode = addonebinary(binaryCode);
        codeString = addonebinary(codeString);

        count = count + 1;
%         codeString = [];
    end
    
%     binaryCode = [binaryCode '0'];
    codeString = [codeString '0'];
    
end

% clear i n

end




%% Pomocne funkce

function y = addonebinary(x)

% Pricte jednicku k binarnimu cislu x

y = x;
hotovo = false;
cnt = length(x);

while ~hotovo
    if x(cnt) == '0'
        y(cnt) = '1';
        hotovo = true;
    else
        y(cnt) ='0';
        if cnt == 1 %zpracovali jsme prvni cislici, co byla puvodne jednicka 
            y = ['1' y]; %prodlouzeni cisla
            hotovo = true;
        else
            cnt = cnt - 1;
        end
    end
end
end

% function mtx_dec = h2d(mtx_hex)
%     %prevede sloup. vektor hex. cisel na dekadicke
%     siz = size(mtx_hex,1);
%     mtx_dec = zeros(siz,1);
%     for cntr = 1:siz
% %         for cntc = 1:size(mtx_hex,2)
%             mtx_dec(cntr) = hex2dec(mtx_hex(cntr,:));
% %         end
%     end
% end
