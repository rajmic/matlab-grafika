% DEMO - Coonsova kubika

% (c) 2012-13 Pavel Rajmic, UTKO FEKT VUT v Brne

home

%% vstupni udaje
% definice ridicich bodu
P0 = [100, 100];
P1 = [200,   0];
P2 = [200, 300];
P3 = [300,-200];

% "casovy" vektor
t = (0:0.05:1).';

%% priprava matic
n = length(t);
% "casova" matice
T = [t.^3 t.^2 t ones(n,1)];

% definice bazove matice
M = cubiccoonsbasematrix;

% matice geom. podminek
G = [P0; P1; P2; P3];

%% vypocet bodu na krivce
baze = T*M;
pointsoncurve = baze*G;
x = pointsoncurve(:,1);
y = pointsoncurve(:,2);

%% vykresleni parametricke konstrukce
plot_curve(x,y,t);

%% vykresleni samotne krivky s ridicimi body
figure
plot(x,y)
hold on
plot(P0(1),P0(2),'rx')
text(P0(1),P0(2),'P_0')
plot(P1(1),P1(2),'rx')
text(P1(1),P1(2),'P_1')
plot(P2(1),P2(2),'rx')
text(P2(1),P2(2),'P_2')
plot(P3(1),P3(2),'rx')
text(P3(1),P3(2),'P_3')
%
text(x(1),y(2),'q(0)')
text(x(end),y(end),'q(1)')

%% vykresleni bazovych polynomu
figure
plot(t,baze)
hold on
index = 16; %pro umisteni popisku
text(t(end-index),baze(end-index,1),'BS_{0,3}(t)')
text(t(index),baze(index,2),'BS_{1,3}(t)')
text(t(index),baze(index,3),'BS_{2,3}(t)')
text(t(index),baze(index,4),'BS_{3,3}(t)')
xlabel('t')