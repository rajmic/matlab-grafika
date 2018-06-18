function [x,y,alpha,dalpha] =  plot2cubicbeziers(P0,P1,P2,P3,Q0,Q1,Q2,Q3,t)

% Vykreslí dvì Bézierovy kubiky dle øídicích bodù a ukáže prùbìh první a druhé derivace
%
% Pn, Qm.... øídící body kubik
% t......... sloupcovy vektor "casu", pouzije se pro P i Q
% x,y....... souøadnice køivky v èase
% (d)alpha.. hodnoty první (druhé) diference
%
% Priklady:
% % C^1-napojeni:
% t = (0:0.025:1).';
% [x,y,alpha,dalpha] = ...
% plot2cubicbeziers([0,0],[1,3],[3,4],[8,2],[8,2],[13,0],[0,10],[3,13],t);
%
% % G^1-napojeni:
% [x,y,alpha,dalpha] = ...
% plot2cubicbeziers([0,0],[1,3],[3,4],[8,2],[8,2],[10.5,1],[0,10],[3,13],t);
%
% % C^0-napojeni:
% [x,y,alpha,dalpha] = ...
% plot2cubicbeziers([0,0],[1,3],[3,4],[8,2],[8,2],[11,3],[0,10],[3,13],t);

% (c) 2009, Pavel Rajmic, UTKO FEKT VUT v Brne


%% osetreni navaznosti (P3 == Q0)
if P3~=Q0
    error('Musi platit P3=Q0')
end

%% vypocet dvou krivek zvlast
[Px,Py] = cubicbezier(P0,P1,P2,P3,t);
[Qx,Qy] = cubicbezier(Q0,Q1,Q2,Q3,t);

%% spojeni krivek
x = [Px; Qx];
y = [Py; Qy];

%% vykresleni krivky
% close all
figure

subplot(5,1,1:3)
hold on
P = [P0;P1;P2;P3];
plot(P(:,1),P(:,2),'r-+')
Q = [Q0;Q1;Q2;Q3];
plot(Q(:,1),Q(:,2),'g-+')

plot(x,y,'b') % prostøední bod (uzel) je vykreslen duplicitnì, ale to v grafu nevadí
hold off
xlabel('x(t)')
ylabel('y(t)')
title('Dve napojene Bezierovy kubiky')
% set(gca,'DataAspectRatio',[1 1 1])
axis equal


%% vypocet a vykresleni uhlu
% prvni diference
dxP = diff(Px);
dyP = diff(Py);
alphaP = atan2(dyP,dxP);
dxQ = diff(Qx);
dyQ = diff(Qy);
alphaQ = atan2(dyQ,dxQ);
alpha = [alphaP; alphaQ]; % prostredni bod (tj. uzel) je timto obsazen pouze jednou
% 
subplot(5,1,4)
plot(linspace(0,2,length(alpha)),alpha)
% stairs(linspace(0,2,length(alpha)),alpha)
xlabel('t (dvakrat interval 0 az 1)')
ylabel('uhel tecny')
axis tight
grid

% druha diference
ddxP = diff(dxP);
ddyP = diff(dyP);
dalphaP = atan2(ddyP,ddxP);
ddxQ = diff(dxQ);
ddyQ = diff(dyQ);
dalphaQ = atan2(ddyQ,ddxQ);
dalpha = [dalphaP; dalphaQ]; % prostredni bod (tj. uzel) je timto obsazen pouze jednou
% 
subplot(5,1,5)
plot(linspace(0,2,length(dalpha)),dalpha)
% stairs(linspace(0,2,length(dalpha)),dalpha)
xlabel('t (dvakrat interval 0 az 1)')
ylabel('uhel tecny tecny')
axis tight
grid