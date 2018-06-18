function psd = cerne_teleso(T,lambda)

% Funkce vraci spektralni krivku prislusnou vyzarovani cerneho telesa podle
% Planckova modelu
%
% T ......... teplota (nebo vektor teplot) v Kelvinech
% lambda .... vlnove delky na kterych nas spektralni hodnoty zajimaji (nm)
%
% psd ....... spektralni hustota vykonu na prislusnych vlnovych delkach

% (c) 2011-2012 Rastislav Somora, Pavel Rajmic, VUT v Brne


%% sloupec
T = T(:);
lambda = lambda(:);

%% konstanty
h = 6.626075*10^-34; %Planckova konst.
c = 299792458; %3*10^8;  %rychlost svìtla ve vakuu
k = 1.3806*10^-23; %Boltzmanova konst.
lambda = lambda*1e-9; % horiz. osa - vlnova delka v metrech

%% telo programu
N = length(T);
psd = zeros(length(lambda),N); %alokace

for cnt = 1:length(T)
    A = (2*h*c^2)./lambda.^5;
    R = (h*c)./(lambda*k.*T(cnt)); %!
    B = 1./(exp(R)-1);
    psd(:,cnt) = (A.*B)';
end