% DEMO - Bézierova kubika v n-D (a její vizualizace)

% (c) 2012 Pavel Rajmic, UTKO FEKT VUT v Brne
% [x,y] = cubicbezier([0,0,5],[1,3,3],[3,4,3],[8,2,0],(0:0.05:1).')  % køivka ve 3D

home

%% Øídicí body a další parametry
P0 = [0, 0, 5, 0];
P1 = [5, 5, 3, 250*4/3];
P2 = [-5,5, 3, 250*4/3];
P3 = [6, 0, 0, 0];

deleni = 101; %jemnost casoveho prubehu

%% Výpoèet
t = linspace(0,1,deleni)'; %cas
T = timevector(t,3); %casova matice pro polynomy stupne 3
M = cubicbezierbasematrix; %bazova matice
G = [P0; P1; P2; P3];
n = size(G,2); % kolik dimenzi
pointsOnCurve = T*M*G; %vsechny dimenze naraz

%% Vykresleni krivky ve 3D
figure
plot3(pointsOnCurve(:,1), pointsOnCurve(:,2), pointsOnCurve(:,3))
grid
xlabel('x(t)')
ylabel('y(t)')
zlabel('z(t)')
% ridici body
hold on
plot3(P0(1),P0(2),P0(3),'rx')
text(P0(1),P0(2),P0(3),'P_0=q(0)')
plot3(P1(1),P1(2),P1(3),'rx')
text(P1(1),P1(2),P1(3),'P_1')
plot3(P2(1),P2(2),P2(3),'rx')
text(P2(1),P2(2),P2(3),'P_2')
plot3(P3(1),P3(2),P3(3),'rx')
text(P3(1),P3(2),P3(3),'P_3=q(1)')
% % zacatek krivky
% text(pointsOnCurve(1,1), pointsOnCurve(1,2), pointsOnCurve(1,3),'q(0)')
% % konec krivky
% text(pointsOnCurve(end,1), pointsOnCurve(end,2), pointsOnCurve(end,3),'q(1)')

%% Vykresleni prubehu v jednotlivych osach
figure
for cnt = 1:n
    subplot(n,1,cnt)
    plot(t,pointsOnCurve(:,cnt))
end
% title('Prubehy v jednotlivych osach -- projekce')

%% Vykresleni se ctvrtou souradnici jako odstinem sedi
figure
% hold on
% t = linspace(0,1,deleni+1);
lt = length(t);
% vykresleni krivky po useckach odpovidajicich casovemu deleni, barva se
% bere ze ctvrte souradnice
for cnt = 1:lt-1
    %prumerna barva ze dvou po sobe jdoucich hodnot prubehu
    stupne_sedi = (pointsOnCurve(cnt,4)+pointsOnCurve(cnt+1,4)) /2 /255;
    barva = stupne_sedi * ones(1,3); %prevod jakoby na RGB
    plot3(pointsOnCurve([cnt cnt+1],1), pointsOnCurve([cnt cnt+1],2), pointsOnCurve([cnt cnt+1],3), 'Color', barva)
    hold on % vne cyklu nefunguje :(
end
grid
