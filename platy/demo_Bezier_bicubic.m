% DEMO: Vypocita a zobrazi Bezierovu bikubiku

% (c) 2012-2013, Pavel Rajmic, UTKO FEKT VUT v Brne

close all

%% vstupni data
% ridici body (prvni index udava prislusnost ke krivce - okraji - a druhy
% kolikaty je to ridici bod na tom okraji)
P00 = [0 0 0];
P01 = [0 2 1];
P02 = [0 5 2];
P03 = [0 6 0];

P10 = [2 0 -1];
P11 = [2 4 -1];
P12 = [2 5 -1];
P13 = [2 6  0];

P20 = [6 1 2];
P21 = [6 4 -2];
P22 = [5 5 -3];
P23 = [6 6 2];

P30 = [8 0 0];
P31 = [7 1 1];
P32 = [9 4 3];
P33 = [7 5 3];

n = 101; % hustota site

%% vytvoreni matic
% "èasy"
u = linspace(0,1,n);
v = linspace(0,1,n);

% matice
P0 = [P00; P01; P02; P03];
P1 = [P10; P11; P12; P13];
P2 = [P20; P21; P22; P23];
P3 = [P30; P31; P32; P33];
Gx = [P0(:,1) P1(:,1) P2(:,1) P3(:,1)];
Gy = [P0(:,2) P1(:,2) P2(:,2) P3(:,2)];
Gz = [P0(:,3) P1(:,3) P2(:,3) P3(:,3)];

%matice bázová
M = cubicbezierbasematrix;

%% vypocet bodu na plose
% vypocet plochy (bod po bodu - neefektivni, ale prehledny zpusob)
Qx = zeros(n,n);
Qy = zeros(n,n);
Qz = zeros(n,n);
for p1 = 1:n
    for p2 = 1:n
        Qx(p1,p2) = [u(p1)^3 u(p1)^2 u(p1) 1] * M * Gx * M' * [v(p2)^3 v(p2)^2 v(p2) 1]';
        Qy(p1,p2) = [u(p1)^3 u(p1)^2 u(p1) 1] * M * Gy * M' * [v(p2)^3 v(p2)^2 v(p2) 1]';
        Qz(p1,p2) = [u(p1)^3 u(p1)^2 u(p1) 1] * M * Gz * M' * [v(p2)^3 v(p2)^2 v(p2) 1]';
    end
end

%% vykresleni
meshc(Qx,Qy,Qz)

xlabel('x(u,v)')
ylabel('y(u,v)')
zlabel('z(u,v)')

% doplneni o ridici body
hold on
style='ks';
plot3(Gx(:),Gy(:),Gz(:),style)
% popisky bodu
text(P00(1),P00(2),P00(3),'P_{00}')
text(P01(1),P01(2),P01(3),'P_{01}')
text(P02(1),P02(2),P02(3),'P_{02}')
text(P03(1),P03(2),P03(3),'P_{03}')
text(P10(1),P10(2),P10(3),'P_{10}')
text(P11(1),P11(2),P11(3),'P_{11}')
text(P12(1),P12(2),P12(3),'P_{12}')
text(P13(1),P13(2),P13(3),'P_{13}')
text(P20(1),P20(2),P20(3),'P_{20}')
text(P21(1),P21(2),P21(3),'P_{21}')
text(P22(1),P22(2),P22(3),'P_{22}')
text(P23(1),P23(2),P23(3),'P_{23}')
text(P30(1),P30(2),P30(3),'P_{30}')
text(P31(1),P31(2),P31(3),'P_{31}')
text(P32(1),P32(2),P32(3),'P_{32}')
text(P33(1),P33(2),P33(3),'P_{33}')
