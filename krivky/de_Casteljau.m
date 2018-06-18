function pointOnBezier = de_Casteljau(controlPoints, t)

% Funkce vypocita souradnici na Bezierove krivce pomoci algoritmu de Casteljau
%
% controlPoints.....ridici body krivky jako sloupce matice
%                   (pocet radku tedy odpovida dimenzi prostoru,
%                   pocet sloupcu je pocet ridicich bodu)
% t................."cas", ve kterem chceme zjistit souradnici na krivce
%                   t je skalar z intervalu [0,1]
%
% Priklad:
% CP = [ [27 15]' [25 250]' [407 247]' [404 19]' ];
% t = 0.7;
% de_Casteljau(CP, t)

% (c) 2012 Pavel Rajmic, VUT v Brne


%pocet radku, sloupcu
[rows, cols] = size(controlPoints);
%alokace pameti pro nove ridici body
controlPointsNew = zeros(rows, cols-1);

% vypocet novych bodu
for cnt = 1:(cols-1)
    % vypocet noveho bodu na usecce mezi dvema starymi
    controlPointsNew(:,cnt) = controlPoints(:,[cnt cnt+1]) * [1-t ; t];
end

if cols > 2
    %pokud jeste mame vice nez jeden bod, rekurzivni volani
    pointOnBezier = de_Casteljau(controlPointsNew, t);
else
    %jiz mame jediny bod a to je ten hledany
    pointOnBezier = controlPointsNew;
end

% Nerekurzivni postup (funguje, autor M. Koch):
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

