function [ image ] = jpeg_decode( bitstream, Qmtx, htaclum, htdclum,dimx, dimy)
%JPEG_DECODE Dekoder formatu jpeg
%   Dekoduje obrazek z bitoveho toku formatu jpeg do hrubych dat
%bitstream                  bitova posloupnost kodu obrazku v jpeg
%Qmtx                        kvantovaci matice
%htaclum                    huffmanova tabulka pro AC slozku
%htdclum                    huffmanova tabulka pro DC slozku
%dimx a dimy              x a y rozmery obrazku
%
%funkce vrati dekodovany obrazek, pocita s jednokanalovym obrazkem ve
%stupnich sedi. Dale nepocita s jpeg hlavickou, proto jsou tyto informace 
%predavany pomoci parametru

% (c) 2015-2016 Jakub Hejda, Pavel Rajmic, UTKO FEKT VUT v Brne

str = '';
num = 0;
DCvector = [];
Rvector = [];
bitVector = [];
huffcd = [];
cnt = 1;
Xblocks = dimx/8;
%Yblocks = dimy/8;
image = [];
refactored = 0;
prevDC = 3000;
rowOfBlocks = [];
RS = [];
Rplus = 0;
block_no = 1;

%Prochazeni bitove posloupnosti, behem iteraci hlavniho cyklu dochazi
%k hledani klice v ht pro delku DC slozky, po jeho nalezeni nastupuje vnitrni cyklus parsujici
%RS dvojice a dekodovani do bloku 8x8px pro ziskani AC slozky
while cnt <= length(bitstream)
    str = [str  bitstream(cnt)];
    num = getNumberOfBits(htdclum,str);%hledani DC kodu, nastavi num na cislo v htDC tabulce
    if num ~= -1 % pokud je num nastaveno, dochazi k parsovani DC slozky bloku
        newDC = '';
        wasDCmin = 1;
        if num == 0 %kdyz je DC stejna, jak ta predchozi
            if ~isempty(DCvector)
                pd = DCvector(length(DCvector));
            else
                pd = prevDC;
            end
            DCvector = [DCvector pd];
%             cnt = cnt+1;%kodovaci funkce pridava jeste jednu nulu jako nulovy rozdil stejnych slozek
        else% v opacnem pripade nacitame num bitu, tvoricich hodnotu DC slozky
            for cnt2 = 1:num
                newDC = [newDC bitstream(cnt+cnt2)] ;
            end
            if newDC(1) == '0'%pokud DC slozka byla zaporna, prevedeme jednotkovym doplnkem na kladne cislo, to pak nasobime -1
                newDC = jedn_doplnek(newDC);
                wasDCmin = -1;
            end
            if refactored ~= 0
                DCvector = [DCvector (wasDCmin*bin2dec(newDC)+DCvector(refactored))];
            else if prevDC ~= 3000
                    DCvector = [DCvector (wasDCmin*bin2dec(newDC)+prevDC)];
                else
                    DCvector = [DCvector (wasDCmin*bin2dec(newDC))];
                end
            end
            cnt = cnt + cnt2;%zvysime iteracni promennou cnt o pocet nactenych bitu
        end
        str = '';
        found = -1;
        cnt2 = 1;
        loaded = 0;
        speslLoaded = 0;
        % po rozparsovani DC slozky hledame klic v ht pro AC slozku, pokud
        % jsme narazili na hodnotu 1010 znacici konec bloku, cyklus dale
        % nepokracuje
        while found ~= 4
            found = -1;
            cnt2 = 1;
            str = '';
            while found == -1 %hledani kodu znacici rs dvojici v ht
                str = [str bitstream(cnt+cnt2)];
                found = findIndex(htaclum,str);
                cnt2 = cnt2 + 1;
            end
            
            % loaded = loaded + 1;
            cnt = cnt + cnt2 - 1;
            o=(htaclum(found,1));
            hg = '';
            hg = [hg o{1}(1) o{1}(2)];
            if hg == 'f0' %zachytavani kodu f0
                Rplus = Rplus + 15;
                RS = [RS; o{1}(1) o{1}(2)];
               continue %skok na zacatek cyklu - necitani dalsich bitu
            end
            % inkrementace promenne uchovavajici, kolik je hodnot AC
            % slozky, na konci cyklu kontrolujeme, zdali jsme nenasli AC
            % slozku na 63 pozici, v tom pripade se totiz nepouziva znak
            % 00 k ukonceni bloku
            if hex2dec(o{1}(1)) ~= 0 %
                speslLoaded =  speslLoaded + Rplus + hex2dec(o{1}(1)) + 1;
            else
                speslLoaded = speslLoaded + Rplus + 1;
            end
            %kontrola, jestli neni nacteno 1010 pro konec bloku
            if (found == 4) || (loaded == 64) || (speslLoaded == 64)
                %disp('found break')
                break;
            end
            %parsovani R hodnot
            RS = [RS; o{1}(1) o{1}(2)];
            Rvector = [Rvector hex2dec(o{1}(1))+Rplus];
            Rplus = 0;
            cnt2 = 1;
            str = '';
            wasMinus = 1;
            if bitstream(cnt+1) == '0'
                wasMinus = -1;
            end
            for cnt2 = 1:hex2dec(o{1}(2))
                str = [str bitstream(cnt+cnt2)];
            end
            if wasMinus == -1
                str = jedn_doplnek(str);
            end
            %parsovani bitu dle delky ziskane z S casti RS kodu
            bitVector = [bitVector wasMinus*bin2dec(str)] ;
            cnt = cnt + hex2dec(o{1}(2));
            if speslLoaded == 63
                break
            end
        end
        %inkrementace promenne uchovavajici pocet ziskanych bloku v ramci
        %radku, nasledna refaktorizace puvodniho vektoru Rhodnot, dle
        %algoritmu, nakonec dojde k zpetne transformaci z vektoru na
        %matici, jeji pronasobeni kvantovaci matici a ke zpetne diskretni
        %kosinove transformaci
        refactored = refactored + 1;
        refactoredRVec = [];
        if length(Rvector) ~= 0
            refactoredRVec = [Rvector(1)+1];
            for c = 2:length(Rvector)
                refactoredRVec(c) = refactoredRVec(c-1) + Rvector(c) + 1;
            end
        end
        vect = zeros([1 64]);
        vect(1) = DCvector(refactored);
        if length(Rvector) ~= 0
            refactoredRVec;
            bitVector;
            for c=1:length(refactoredRVec)
                vect(refactoredRVec(c)+1) = bitVector(c);
            end
        end
        q_transform = invzigzag(vect,8,8);
        transform = q_transform .* Qmtx;
        im = idct2(transform);
        im = round(im);
        im = im + 128;
        im = uint8(im); %timto zaroven dojde k pripadnemu orezani rozsahu na [0, 255]
        
        disp(['Byl dekodovan blok ' num2str(block_no)])
        block_no = block_no +1;
        
        %ziskavani radku bloku tvoricich obrazek
%         if im == ones(8,8) .* 255
%             %     error('molo.');
%         end;
        rowOfBlocks = [rowOfBlocks im];
        Rvector = [];
        bitVector = [];
        %jsme-li na konci radku, pridame jej do vysldneho obrazku
        if refactored == Xblocks
            image = [image ; rowOfBlocks];
            DCvector;
            prevDC = 0;%DCvector(length(DCvector));
            DCvector = [];
            rowOfBlocks = [];
            refactored = 0;
        end
        str = '';
    end
    cnt = cnt+1;
end
end

function index = findIndex(ht,symbol)
% najde radkovy index v Huffmanove tabulce 'ht' prislusny symbolu
    index = -1;
    for c = 1:length(ht(:,2))
        if strcmp(ht(c,2),symbol) == 1
            index = c;
            break
        end        
    end    
end

function index = getNumberOfBits(ht,symbol)
%vraci pocet bitu ke cteni dle ht
    index = -1;
    for c = 1:length(ht(:,2))
        if strcmp(ht(c,2),symbol) == 1
            index = hex2dec(ht(c,1));
            break
        end        
    end    
end