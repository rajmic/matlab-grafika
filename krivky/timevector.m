function T = timevector(t,n)

% vygeneruje "èasovı" polynom øádu n v èase(ch) t
%
% Pokud t je skalár, T je vektor rozmìru 1 x (n+1)
% Pokud t je vektor délky m, T je matice rozmìru m x (n+1)

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
% (z pedagogickıch dùvodù èitelnım, ale zbyteènì pomalım zpùsobem)
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