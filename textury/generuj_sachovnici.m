function [texture] = generuj_sachovnici (M, N, pointsx, pointsy)
% [texture] = generuj_sachovnici (M, N, pointsx, pointsy)
% 
% Vygeneruje bitmapový obrázek rozmìru 'pointsx' x 'pointsy' -
% - šachovnici s MxN políèky. Šachovnice zaèíná v levém
% spodním rohu èerným políèkem (pøíp. bílým, podle nastavení ve funkci
% "sachovnice_proceduralni.m"). Vrací matici vyplnìnou obrazovými daty.
% 
% M ......... poèet políèek šachovnice v horizontálním smìru
% N ......... poèet políèek šachovnice ve vertikálním smìru
% pointsx ... požadovaný poèet pixelù v horizontálním smìru
% pointsy ... požadovaný poèet pixelù ve vertikálním smìru

% Aby byla šachovnice bezchybnì vygenerovaná, je nutné zadat poèet pixelù v
% pøíslušném smìru jako celoèíselný násobek poètu políèek v témže smìru. V
% opaèném pøípadì dojde ke vzniku "aliasingu" (nevím, zda to tak mohu
% nazvat), kdy políèka budou nestejnì široká, resp. vysoká. Toto se projeví
% pøedevším u šachovnic s nízkým poètem pixelù. Naopak pokud bude mít
% šachovnice na šíøku napø. 100px tak si ani nevšimneme, že je nìkteré pole
% napø. o 1px širší. Ale chyba takto samozøejmì vzniká.

% (c) 2009 Petr Doležal
% (c) drobné úpravy 2009, 2010 Pavel Rajmic

%% Ošetøení vybraných nekorektních vstupù.

% Nulove vstupy
if ( (pointsx == 0) || (pointsy == 0) || (M == 0) || (N == 0))
    error('Vstupni parametry musi byt nenulove.');
end

% Požadovaný poèet políèek je menší než poèet px
if ( (pointsx < M) )
    error('Pointsx = %s je menší než poèet požadovaných políèek M = %s', num2str(pointsx),num2str(M));
end
if ( (pointsy < N) )
    error('Pointsy = %s je menší než poèet požadovaných políèek N = %s', num2str(pointsy),num2str(N));
end

% Varovani pøed vznikem aliasingu
if (mod(pointsx,M)), 
    warning('Pointsx = %s neni celocislenym nasobkem M = %s. Sachovnice bude ovlivnena aliasingem.', num2str(pointsx), num2str(M));
end
if (mod(pointsy,N)),
    warning('Pointsy = %s neni celocislenym nasobkem N = %s. Sachovnice bude ovlivnena aliasingem.', num2str(pointsy), num2str(N));    
end


%% Pøíprava výstupní promìnné
texture = zeros (pointsy, pointsx);

% Do vztahu pro normování souøadnic nelze dosadit rozmìr 1px, proto tyto
% stavy jsou ošetøeny samostatným cyklem, celkem mohou nastat 4 situace
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

%% Zobrazení
imshow(texture);
