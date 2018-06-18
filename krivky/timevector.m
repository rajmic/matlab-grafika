function T = timevector(t,n)

% vygeneruje "�asov�" polynom ��du n v �ase(ch) t
%
% Pokud t je skal�r, T je vektor rozm�ru 1 x (n+1)
% Pokud t je vektor d�lky m, T je matice rozm�ru m x (n+1)

% (c) 2012, Pavel Rajmic, UTKO FEKT VUT v Brne

%% kontrola vstupu
if nargin ~= 2
    error('nedostatek vstupnich parametru');
end
if all(size(t)>1)
    error('t musi byt skalar nebo vektor');
end
if ~isscalar(n)
    error('n musi byt skalar');
end

%% generovani casove matice
% (z pedagogick�ch d�vod� �iteln�m, ale zbyte�n� pomal�m zp�sobem)
t = t(:); %sloupec
lt = length(t);
T = zeros(lt,n+1); % vyhrazeni pameti
T(:,end) = ones(lt,1); % posledni sloupec jsou jednicky (konstantni clen)
if n>=1
    T(:,end-1) = t; % predposledni sloupec je primo cas (prvni mocnina)
end
if n>=2
    for cnt = 2:n % kvadraticky, kubicky, atd.
        T(:,end-cnt) = t.^cnt;
    end
end