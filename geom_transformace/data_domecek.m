function data = data_domecek

%Sestaven� matice ��d�c�ch bod� Bezi�rov�ch kubik ve 3D pro vykreslen� "dome�ku".
%Vol�n�: body = data_domecek

% (c) 2012 Jiri Kovarik, Pavel Rajmic, UTKO FEKT VUT v Brne


%% parametry
hloubka = 5; %jak "hluboky" je domecek

%% predni stena domecku
obloucek1 = [2,2,4,4;...
             4,6,6,4];
cara1 =     [2,2,4,4;...
             2,2,2,2];
cara2 =     [2,2,2,2;...
             2,2,2,4];
cara3 =     [2,2,4,4;...
             4,4,4,4];
cara4 =     [4,4,4,4;...
             2,2,2,4];
% spojeni do jednoho
data_predni_stena = [obloucek1 cara1 cara2 cara3 cara4];
% pripojeneni treti souradnice, ktera je nulova
data_predni_stena(3,1) = 0;

%% zadni stena domecku - pomoci translace predni steny
data_hom = cart2hom(data_predni_stena); %prevedeni do homog. souradnic
Atran = translating_matrix(0, 0, hloubka); %konstrukce matice pro posunuti
data_hom = Atran*data_hom; %posunuti
data_zadni_stena = hom2cart(data_hom,1); %prevod zpet do kartezskych, posledni nepotrebuji

%% cary spojujici steny dole a nahore
cara5 = [2,2,2,2;...
         2,2,2,2;...
         0,0,hloubka,hloubka];
cara6 = [4,4,4,4;...
         2,2,2,2;...
         0,0,hloubka,hloubka];
%% cary na oblouku (strecha)
t = linspace(0,1,6)'; % kolik bude celkem car: 6
% urceni souradnic ktere odpovidaji strese
P0 = data_predni_stena(1:2,1)';
P1 = data_predni_stena(1:2,2)';
P2 = data_predni_stena(1:2,3)';
P3 = data_predni_stena(1:2,4)';
[x,y] = cubicbezier(P0, P1, P2, P3, t); % zjisteni souradnic na krivce
% cary samotne
cara7 = [x(1),x(1),x(1),x(1);...
         y(1),y(1),y(1),y(1);...
         0,0,hloubka,hloubka];  
cara8 = [x(2),x(2),x(2),x(2);...
         y(2),y(2),y(2),y(2);...
         0,0,hloubka,hloubka];
cara9 = [x(3),x(3),x(3),x(3);...
         y(3),y(3),y(3),y(3);...
         0,0,hloubka,hloubka];
cara10 = [x(4),x(4),x(4),x(4);...
         y(4),y(4),y(4),y(4);...
         0,0,hloubka,hloubka];
cara11 = [x(5),x(5),x(5),x(5);...
         y(5),y(5),y(5),y(5);...
         0,0,hloubka,hloubka];
cara12 = [x(6),x(6),x(6),x(6);...
         y(6),y(6),y(6),y(6);...
         0,0,hloubka,hloubka];
     
%% vysledne spojeni
data = [data_predni_stena data_zadni_stena...
        cara5 cara6 cara7 cara8...
        cara9 cara10 cara11 cara12];