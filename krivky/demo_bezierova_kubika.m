% DEMO - pøíklad Bézierovy kubiky, vcetne vykresleni bazovych funkci

%% zadani ridicich bodu
% P0 = [0,0];
% P1 = [1,3];
% P2 = [3,4];
% P3 = [8,2];
%jina volba:
P0 = [0,0];
P1 = [5,5];
P2 = [-5,5];
P3 = [6,0];

%casovy vektor
t = (0:0.05:1)';

%% vypocet bodu na krivce
[x,y,baze] = cubicbezier(P0,P1,P2,P3,t);

%% vykresleni parametricke konstrukce
plot_curve(x,y,t);

%% vykresleni samotne krivky s ridicimi body
figure
plot(x,y)
hold on
plot(P0(1),P0(2),'rx')
text(P0(1),P0(2),'P_0=q(0)')
plot(P1(1),P1(2),'rx')
text(P1(1),P1(2),'P_1')
plot(P2(1),P2(2),'rx')
text(P2(1),P2(2),'P_2')
plot(P3(1),P3(2),'rx')
text(P3(1),P3(2),'P_3=q(1)')
%
% text(x(1),y(2),'q(0)')
% text(x(end),y(end),'q(1)')

%% vykresleni bazovych polynomu
figure
plot(t,baze)
hold on
index = 17; %pro umisteni popisku
text(t(end-index),baze(end-index,1),'B_{0,3}(t)')
text(t(index),baze(index,2),'B_{1,3}(t)')
text(t(index),baze(index,3),'B_{2,3}(t)')
text(t(index),baze(index,4),'B_{3,3}(t)')
xlabel('t')