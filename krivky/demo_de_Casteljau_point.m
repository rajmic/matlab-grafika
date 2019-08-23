% DEMO -- ukazuje algoritmus de_Casteljau pro nalezeni bodu na Bezierove kubice

% (c) 2019, Pavel Rajmic, UTKO FEKT VUT v Brne

close all

%% Vstupni udaje
CP = [ [27 15]' [25 250]' [407 170]' [350 19]' ];
cas = 0.7; %mozno menit

%% Vykresleni cele Bezierovky (pro ideu)
CPt = CP';
% CP = [ [27 15]' [25 250]' [407 247]' ];
t = linspace(0,1,101);
t = t(:);
[points] = bezier(CPt, t);
figure
h = plot(points(:,1), points(:,2));
set(h,'Color','k')
hold on

%% Ridici body a polygon
scatter(CPt(:,1), CPt(:,2), 'r+', 'LineWidth', 2)
text(CPt(1,1)+5, CPt(1,2), 'P_0')
text(CPt(2,1)-20, CPt(2,2), 'P_1')
text(CPt(3,1)+5, CPt(3,2), 'P_2')
text(CPt(4,1)+5, CPt(4,2), 'P_3')
plot(CPt(:,1), CPt(:,2), 'r')

%% Dalsi uroven a jeji polygon
points = CP;
point1 = de_Casteljau(points(:,1:2), cas);
point2 = de_Casteljau(points(:,2:3), cas);
point3 = de_Casteljau(points(:,3:4), cas);
points = [point1 point2 point3]';
plot(points(:,1), points(:,2), 'g')

%% Dalsi uroven a jeji polygon
points = points';
point1 = de_Casteljau(points(:,1:2), cas);
point2 = de_Casteljau(points(:,2:3), cas);
points = [point1 point2]';
plot(points(:,1), points(:,2), 'b')

%% Posledni uroven = vysledny bod
points = points';
point1 = de_Casteljau(points(:,1:2), cas);
plot(point1(1), point1(2), 'k*')

set(gca,'visible','off')