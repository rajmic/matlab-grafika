function [pointOnBezier, subdivContrPointsLeft, subdivContrPointsRight] = ...
    de_Casteljau(controlPoints, t, varargin)

% Funkce vypocita souradnici na Bezierove krivce pomoci algoritmu de Casteljau
%
% controlPoints.....ridici body krivky jako sloupce matice
%                   (pocet radku tedy odpovida dimenzi prostoru,
%                   pocet sloupcu je pocet ridicich bodu)
% t................."cas", ve kterem chceme zjistit souradnici na krivce
%                   t je skalar z intervalu [0,1]
% Jine vstupni argumenty nepouzivat.
%
% pointOnBezier.....bod na Bezierove krivce v okamziku t
% subdivContrPointsLeft, subdivContrPointsRight....
%                ...ridici body urcujici prvni resp. druhou polovinu krivky
%                   rozdelene v bode t (subdivision)
%
% Priklady:
% CP = [ [27 15]' [25 250]' [407 247]' [404 19]' ];
% t = 0.7;
% de_Casteljau(CP, t)
%
% %nebo
% CP = [ [27 15]' [25 250]' [407 247]' [404 19]' ];
% t = 0.7;
% [point, subdivLeft, subdivRight] = de_Casteljau(CP, t);
% figure
% scatter(CP(1,:),CP(2,:),'+r'), hold on
% scatter(subdivLeft(1,:),subdivLeft(2,:),'ob')
% scatter(subdivRight(1,:),subdivRight(2,:),'og','filled')

% (c) 2012--2019 Pavel Rajmic, VUT v Brne


%pocet radku, sloupcu
[rows, cols] = size(controlPoints);

%
if cols == 1
    %jiz mame jediny bod a to je ten hledany
    pointOnBezier = controlPoints;
    if isempty(varargin) %volalo se bez dalsich argumentu, tj. z nejvyssi urovne
        subdivContrPointsLeft = controlPoints; %pouze kopie
        subdivContrPointsRight = controlPoints; %pouze kopie
    else  %volani prislo rekurzivne
        subdivContrPointsLeft = varargin{1}; %kopie
        subdivContrPointsRight = varargin{2}; %kopie
    end
else
    if isempty(varargin) %volalo se bez dalsich argumentu, tj. z nejvyssi urovne
        subL = controlPoints(:,1); %prvni
        subR = controlPoints(:,end); %posledni
    else
        subL = varargin{1}; %volani bylo rekurzi
        subR = varargin{2};
    end    
    % vypocet novych bodu
    controlPointsNew = zeros(rows, cols-1); %alokace pameti
    for cnt = 1:(cols-1)
        % vypocet noveho bodu na usecce mezi dvema starymi
        controlPointsNew(:,cnt) = controlPoints(:,[cnt cnt+1]) * [1-t ; t];
        %rekurzivni volani
        [pointOnBezier, subdivContrPointsLeft, subdivContrPointsRight] = ...
            de_Casteljau(controlPointsNew, t, [subL controlPointsNew(:,1)], [controlPointsNew(:,end) subR]);
    end
end


%% Nerekurzivni postup vypoctu de Casteljau (funguje, autor M. Koch):
% P1 = zeros(s, n-1);
% if(s == 2)    
%     for i=2:n
%         for j=0:n-i
%            %P1(1,j+1) posun j+1 kvùli indexaci od 1. 
%            P1(1,j+1) = (1-t)*P(1,j+1) + t*P(1,j+2); 
%            P1(2,j+1) = (1-t)*P(2,j+1) + t*P(2,j+2); 
%         end
%         P = P1;
%         P1 = zeros(s, n-i);
%     end
% else
%     disp('Rozmer bodu je nepovolený')
% end    
% x = P(1);
% y = P(2);
% 

