% DEMO -- ukazuje algoritmus de_Casteljau pro subdivision, na Bezierove kubice

close all

%% Vstupni udaje
CP = [ [27 15]' [25 250]' [407 170]' [350 19]' ];
cas = 0.5; % pro subdivision je nejcastejsi 0.5

%% Vykresleni cele Bezierovky (pro ideu)
CPt = CP';
t = linspace(0,1,101);
t = t(:);
[points] = bezier(CPt, t);
figure
h = plot(points(:,1), points(:,2));
set(h,'Color','k')
hold on

%% Ridici body a polygon
scatter(CP(1,:),CP(2,:),'+r', 'LineWidth', 2)
plot(CPt(:,1), CPt(:,2), 'r') %, 'LineWidth', 2)
text(CPt(1,1)+5, CPt(1,2), 'P_0')
text(CPt(2,1)-20, CPt(2,2), 'P_1')
text(CPt(3,1)+5, CPt(3,2), 'P_2')
text(CPt(4,1)+5, CPt(4,2), 'P_3')

%% Prvni deleni
[~, subdivLeft1, subdivRight1] = de_Casteljau(CP, cas);
hold on
scatter(subdivLeft1(1,:),subdivLeft1(2,:),'ob')
plot(subdivLeft1(1,:),subdivLeft1(2,:),'b')

scatter(subdivRight1(1,:),subdivRight1(2,:),'og')
plot(subdivRight1(1,:),subdivRight1(2,:),'g')

%% Druhe deleni -- leve
[~, subdivLeft2, subdivRight2] = de_Casteljau(subdivLeft1, cas);
hold on
scatter(subdivLeft2(1,:),subdivLeft2(2,:),'sm')
plot(subdivLeft2(1,:),subdivLeft2(2,:),'m')

scatter(subdivRight2(1,:),subdivRight2(2,:),'sc')
plot(subdivRight2(1,:),subdivRight2(2,:),'c')

%% Druhe deleni -- prave
[~, subdivLeft2, subdivRight2] = de_Casteljau(subdivRight1, cas);
hold on
scatter(subdivLeft2(1,:),subdivLeft2(2,:),'sm')
plot(subdivLeft2(1,:),subdivLeft2(2,:),'m')

scatter(subdivRight2(1,:),subdivRight2(2,:),'sc')
plot(subdivRight2(1,:),subdivRight2(2,:),'c')

set(gca,'visible','off')