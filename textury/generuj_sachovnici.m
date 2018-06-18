function [texture] = generuj_sachovnici (M, N, pointsx, pointsy)
% [texture] = generuj_sachovnici (M, N, pointsx, pointsy)
% 
% Vygeneruje bitmapov� obr�zek rozm�ru 'pointsx' x 'pointsy' -
% - �achovnici s MxN pol��ky. �achovnice za��n� v lev�m
% spodn�m rohu �ern�m pol��kem (p��p. b�l�m, podle nastaven� ve funkci
% "sachovnice_proceduralni.m"). Vrac� matici vypln�nou obrazov�mi daty.
% 
% M ......... po�et pol��ek �achovnice v horizont�ln�m sm�ru
% N ......... po�et pol��ek �achovnice ve vertik�ln�m sm�ru
% pointsx ... po�adovan� po�et pixel� v horizont�ln�m sm�ru
% pointsy ... po�adovan� po�et pixel� ve vertik�ln�m sm�ru

% Aby byla �achovnice bezchybn� vygenerovan�, je nutn� zadat po�et pixel� v
% p��slu�n�m sm�ru jako celo��seln� n�sobek po�tu pol��ek v t�m�e sm�ru. V
% opa�n�m p��pad� dojde ke vzniku "aliasingu" (nev�m, zda to tak mohu
% nazvat), kdy pol��ka budou nestejn� �irok�, resp. vysok�. Toto se projev�
% p�edev��m u �achovnic s n�zk�m po�tem pixel�. Naopak pokud bude m�t
% �achovnice na ���ku nap�. 100px tak si ani nev�imneme, �e je n�kter� pole
% nap�. o 1px �ir��. Ale chyba takto samoz�ejm� vznik�.

% (c) 2009 Petr Dole�al
% (c) drobn� �pravy 2009, 2010 Pavel Rajmic

%% O�et�en� vybran�ch nekorektn�ch vstup�.

% Nulove vstupy
if ( (pointsx == 0) || (pointsy == 0) || (M == 0) || (N == 0))
    error('Vstupni parametry musi byt nenulove.');
end

% Po�adovan� po�et pol��ek je men�� ne� po�et px
if ( (pointsx < M) )
    error('Pointsx = %s je men�� ne� po�et po�adovan�ch pol��ek M = %s', num2str(pointsx),num2str(M));
end
if ( (pointsy < N) )
    error('Pointsy = %s je men�� ne� po�et po�adovan�ch pol��ek N = %s', num2str(pointsy),num2str(N));
end

% Varovani p�ed vznikem aliasingu
if (mod(pointsx,M)), 
    warning('Pointsx = %s neni celocislenym nasobkem M = %s. Sachovnice bude ovlivnena aliasingem.', num2str(pointsx), num2str(M));
end
if (mod(pointsy,N)),
    warning('Pointsy = %s neni celocislenym nasobkem N = %s. Sachovnice bude ovlivnena aliasingem.', num2str(pointsy), num2str(N));    
end


%% P��prava v�stupn� prom�nn�
texture = zeros (pointsy, pointsx);

% Do vztahu pro normov�n� sou�adnic nelze dosadit rozm�r 1px, proto tyto
% stavy jsou o�et�eny samostatn�m cyklem, celkem mohou nastat 4 situace
% 1x1, 1x?, ?x1, ?x?

% ?x?
if ((pointsx > 1)&&(pointsy > 1))
    for i = 1 : pointsy
        for j = 1 : pointsx
            u = (j-1)/(pointsx-1);
            v = (i-1)/(pointsy-1);
            texture (i,j) = sachovnice_proceduralni (M,N,u,1-v);
        end
    end
% 1x1
elseif((pointsx == 1)&&(pointsy == 1))
    u = 1;
    v = 1;
    texture (1,1) = sachovnice_proceduralni (M,N,u,1-v);
% 1x?
elseif((pointsx == 1)&&(pointsy > 1))
    for i = 1 : pointsy
        u = 1;
        v = (i-1)/(pointsy-1);
        texture (i,1) = sachovnice_proceduralni (M,N,u,1-v);
    end
% ?x1
elseif((pointsx > 1)&&(pointsy == 1))
    for j = 1 : pointsx
        u = (j-1)/(pointsx-1);
        v = 1;
        texture (1,j) = sachovnice_proceduralni (M,N,u,1-v);
    end

end %konec if

%% Zobrazen�
imshow(texture);
