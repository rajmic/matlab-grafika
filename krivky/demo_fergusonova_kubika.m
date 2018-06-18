% DEMO - Fergusonova interpolaèní kubika

% (c) 2006-2013, Petr Sysel, Pavel Rajmic, UTKO FEKT VUT v Brne

home

%% vstupni udaje
% definice hranicnich bodu a tecen
P1 = [100, 100];
P1t = [200, -300];
P2 = [400,350];
P2t = [300,-200];

% "casovy" vektor
t = (0:0.05:1).';

%% priprava matic
n = length(t);
% "casova" matice
T = [t.^3 t.^2 t ones(n,1)];

% definice bazove matice
M = cubicfergusonbasematrix;

% matice geom. podminek
G = [P1; P2; P1t; P2t];

%% vypocet
pointsonferguson = T*M*G;
x = pointsonferguson(:,1);
y = pointsonferguson(:,2);

%% vykresleni
plot_curve(x,y,t);