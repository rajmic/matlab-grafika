% Demonstruje kresleni ctvrtkruznice a cele kruznice pomoci racionalni
% Bezierovy krivky
%
% (c) 2013 Pavel Rajmic, Martin Sulc, VUT v Brne

close all
clc


%% CTVRTKRUZNICE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P0 = [1,0]; %ridici body (ale kartezske v rovine w=1!)
P1 = [1,1]; %ridici body (ale kartezske v rovine w=1!)
P2 = [0,1]; %ridici body (ale kartezske v rovine w=1!)
w = [1, 1, 2]'; %jejich vahy neboli souradnice w
t = (0:0.05:1)'; %casovy vektor

%% vypocet
P = [P0*w(1); P1*w(2); P2*w(3)]; %zhomogeneni ridicich bodu
Pw = [P w];
Q = bezier(Pw,t);  %3D body na krivce (homogenni)

Pw_cart = hom2cart(Pw');  %ridici body po projekci
Qrat = ratbezier(P,w,t);  %2D body na krivce (kartezske)

%% kresleni
figure
%ridici body homogenni
subplot(2,1,1)
plot3(Pw(:,1),Pw(:,2),Pw(:,3),'k.-')
hold on
grid on
%ridici body racionalni
plot3(Pw_cart(1,:),Pw_cart(2,:),Pw_cart(3,:),'ko-')
%krivky
plot3(Q(:,1),Q(:,2),Q(:,3))
plot3(Qrat(:,1),Qrat(:,2),ones(length(t),1),'r') %kreslime v rovine z=1
axis equal
axis([-0.5, 1.4, -0.5, 2.2, -0.2, 2.3]);
% axis([-0.5, 1.5, -0.5, 2.5, -0.5, 2.5]);
xlabel('x');
ylabel('y');
zlabel('w');
title('Racionalni Bezierova krivka v homog. sour.')
plot3([Pw(1,1),0], [Pw(1,2),0], [Pw(1,3),0],'k.--') %drahy projekci - spojnice s pocatkem
plot3([Pw(2,1),0], [Pw(2,2),0], [Pw(2,3),0],'k.--')
plot3([Pw(3,1),0], [Pw(3,2),0], [Pw(3,3),0],'k.--')
%popisky bodù
text([Pw(1,1)+0.1], [Pw(1,2)+0.1], [Pw(1,3)+0.04],'P0_{hom}=P0_{kart}')
text([Pw(2,1)+0.1], [Pw(2,2)+0.1], [Pw(2,3)+0.04],'P1_{hom}=P1_{kart}')
text([Pw_cart(2,1)+0.1], [Pw_cart(2,2)+0.1], [Pw_cart(2,3)+0.04],'P2_{kart}')
text([Pw(3,1)+0.1], [Pw(3,2)+0.1], [Pw(3,3)+0.04],'P2_{hom}')
text(0.1,0.1,0,'0')
%rovina z=1
surf([-0.4, 1.3],[-0.4, 2.1],[1,1;1,1]);
if ~isoctave
   alpha(0.5); %pruhledna
end

%projekce -- vysledna pulkruznice
subplot(2,1,2)
plot(Qrat(:,1), Qrat(:,2),'r');
hold on
grid on
axis equal
xlabel('x');
ylabel('y');
title('Racionalni Bezierova krivka v kartez. sour.')
%ridici body
plot(P0(1), P0(2), 'ko')
text(P0(1)-0.08, P0(2)+0.05, 'P0_{kart}')
plot(P1(1), P1(2), 'ko')
text(P1(1)-0.07, P1(2)-0.05, 'P1_{kart}')
plot(P2(1), P2(2), 'ko')
text(P2(1)+0.03, P2(2)-0.05, 'P2_{kart}')
%osy
axis equal
axis tight



%% CELA KRUZNICE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P0 = [0,0]; %ridici body (ale kartezske v rovine w=1!)
P1 = [4,0]; %ridici body (ale kartezske v rovine w=1!)
P2 = [2,4]; %ridici body (ale kartezske v rovine w=1!)
P3 = [-2,4];
P4 = [-4,0];
P5 = [0,0];
w = [1, 0.2, 0.2, 0.2, 0.2, 1]'; %jejich vahy neboli souradnice w
t = (0:0.01:1)'; %casovy vektor

%% vypocet
P = [P0*w(1); P1*w(2); P2*w(3); P3*w(4); P4*w(5);P5*w(6)]; %zhomogeneni ridicich bodu
Pw = [P w];
Q = bezier(Pw,t);  %3D body na krivce (homogenni)

Pw_cart = hom2cart(Pw');  %ridici body po projekci
Qrat = ratbezier(P,w,t);  %2D body na krivce (kartezske)

%% kresleni
figure
%ridici body homogenni
subplot(2,1,1)
plot3(Pw(:,1),Pw(:,2),Pw(:,3),'k.-')
hold on
grid on
%ridici body racionalni
plot3(Pw_cart(1,:),Pw_cart(2,:),Pw_cart(3,:),'ko-')
%krivky
plot3(Q(:,1),Q(:,2),Q(:,3))
plot3(Qrat(:,1),Qrat(:,2),ones(length(t),1),'r') %kreslime v rovine z=1
% axis equal
axis([-4.5, 4.4, -1, 4.2, -0.2, 1.5]);
% axis([-0.5, 1.5, -0.5, 2.5, -0.5, 2.5]);
set(gca,'DataAspectRatio',[1 1 1/3.3])
xlabel('x');
ylabel('y');
zlabel('w');
title('Racionalni Bezierova krivka v homog. sour.')
plot3([Pw(1,1),0], [Pw(1,2),0], [Pw(1,3),0],'k.--') %drahy projekci - spojnice s pocatkem
plot3([Pw(2,1),0], [Pw(2,2),0], [Pw(2,3),0],'k.--')
plot3([Pw(3,1),0], [Pw(3,2),0], [Pw(3,3),0],'k.--')
plot3([Pw(4,1),0], [Pw(4,2),0], [Pw(4,3),0],'k.--')
plot3([Pw(5,1),0], [Pw(5,2),0], [Pw(5,3),0],'k.--')
plot3([Pw(6,1),0], [Pw(6,2),0], [Pw(6,3),0],'k.--')
%popisky bodù
text([Pw(1,1)+0.1], [Pw(1,2)+0.1], [Pw(1,3)+0.04],'P0_{hom}=P0_{kart}=P5_{hom}=P5_{kart}') %popisky bodù hom
text([Pw(2,1)+0.1], [Pw(2,2)+0.1], [Pw(2,3)+0.04],'P1_{hom}')
text([Pw(3,1)+0.1], [Pw(3,2)+0.1], [Pw(3,3)+0.04],'P2_{hom}')
text([Pw(4,1)+0.1], [Pw(4,2)+0.1], [Pw(4,3)+0.04],'P3_{hom}')
text([Pw(5,1)+0.1], [Pw(5,2)+0.1], [Pw(5,3)+0.04],'P4_{hom}')

text(P1(1)+0.05, P1(2)+0.05, 1.05,'P1_{kart}') %popisky bodù kart
text(P2(1)+0.03, P2(2)-0.15,1.05, 'P2_{kart}')
text(P3(1)+0.03, P3(2)-0.15,1.05, 'P3_{kart}')
text(P4(1)+0.03, P4(2)+0.15,1.05, 'P4_{kart}')

plot3([P2(1),0], [P2(2),0], [1,0],'k.--') %spojnice kart. bodù s poèátkem
plot3([P3(1),0], [P3(2),0], [1,0],'k.--')
plot3([P4(1),0], [P4(2),0], [1,0],'k.--')
plot3([P1(1),0], [P1(2),0], [1,0],'k.--')
%text([Pw_cart(2,1)+0.1], [Pw_cart(2,2)+0.1], [Pw_cart(2,3)+0.04],'P2_{kart}')
%text([Pw(3,1)+0.1], [Pw(3,2)+0.1], [Pw(3,3)+0.04],'P2_{hom}')
text(0.1,0.1,0,'0')
%rovina z=1
surf([-4.5, 4.4],[-1, 4.2],[1,1;1,1]);
if ~isoctave
   alpha(0.5); %pruhledna
end

%projekce -- vysledna pulkruznice
subplot(2,1,2)
plot(Qrat(:,1), Qrat(:,2),'r');
hold on
grid on
axis equal
xlabel('x');
ylabel('y');
title('Racionalni Bezierova krivka v kartez. sour.')
%ridici body
plot(P0(1), P0(2), 'ko')
text(P0(1)-0.08, P0(2)+0.15, 'P0_{kart} = P5_{kart}')
plot(P1(1), P1(2), 'ko')
text(P1(1)-0.5, P1(2)+0.15, 'P1_{kart}')
plot(P2(1), P2(2), 'ko')
text(P2(1)+0.03, P2(2)-0.15, 'P2_{kart}')
plot(P3(1), P3(2), 'ko')
text(P3(1)+0.03, P3(2)-0.15, 'P3_{kart}')
plot(P4(1), P4(2), 'ko')
text(P4(1)+0.03, P4(2)+0.15, 'P4_{kart}')

%osy
axis equal
axis tight
