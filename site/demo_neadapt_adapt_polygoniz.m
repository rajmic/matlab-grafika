% DEMO: Ukazka nerovnomerne polygonizace

% (c) 2021 Pavel Rajmic, UTKO FEKT VUT v Brne

clear all
close all

%% Priprava krivky, ktera bude jakoby rotovat a vytvori objekt
t = 1:0.01:5;
% vygenerovano z predepsanych bodu pomoci https://mycurvefit.com/
r = @(h) -10.43955 + 29.70587*(h+1) - 18.85184*(h+1).^2 + 4.756095*(h+1).^3 - 0.4172748*(h+1).^4;
t = t - 1; % posun do nuly
krivka = r(t);
krivka = krivka - min(krivka); % posun do nuly
% plot(z,krivka)


%% Kompletni neadaptivni sit
uhel = linspace(0,1,17); %normalizovany
vyska = linspace(0,1,28); %normalizovana

[Mesh_uhly, Mesh_vyska] = meshgrid(uhel*2*pi, vyska*max(t));
X = r(Mesh_vyska) .* sin(Mesh_uhly);
Y = r(Mesh_vyska) .* cos(Mesh_uhly);
Z = Mesh_vyska;

%korekce nepresneho vyjadreni funkce h (dole)
l0 = (Mesh_vyska == 0);
X(l0) = 0;
Y(l0) = 0;

%korekce nepresneho vyjadreni funkce h (nahore)
l1 = (Mesh_vyska == max(t));
X(l1) = 0;
Y(l1) = 0;

% Vykresleni
figure
handle = mesh(X,Y,Z);  % vykresleni site
set(handle,'EdgeColor',[0 0 0]);
xlabel('x')
ylabel('y')
zlabel('z')
% % view(40,15)
% % axis tight


%% Adaptivni vykresleni
figure
%% Pas c. 1 k vykreseleni
uhel = linspace(0,1,17); %normalizovany
vyska = linspace(0,.2,9); %normalizovana

[Mesh_uhly, Mesh_vyska] = meshgrid(uhel*2*pi, vyska*max(t));
X = r(Mesh_vyska) .* sin(Mesh_uhly);
Y = r(Mesh_vyska) .* cos(Mesh_uhly);
Z = Mesh_vyska;

%korekce nepresneho vyjadreni funkce h (dole)
l0 = (Mesh_vyska == 0);
X(l0) = 0;
Y(l0) = 0;

% Vykresleni
handle = mesh(X,Y,Z);  % vykresleni site
set(handle,'EdgeColor',[0 0 0]);
xlabel('x')
ylabel('y')
zlabel('z')
hold on

%% Pas c. 2 k vykreseleni
uhel = linspace(0,1,17); %normalizovany
vyska = linspace(.2,1.3/2,6); %normalizovana

[Mesh_uhly, Mesh_vyska] = meshgrid(uhel*2*pi, vyska*max(t));
X = r(Mesh_vyska) .* sin(Mesh_uhly);
Y = r(Mesh_vyska) .* cos(Mesh_uhly);
Z = Mesh_vyska;

% Vykresleni
handle = mesh(X,Y,Z);  % vykresleni site
set(handle,'EdgeColor',[0 0 0]);

%% Pas c. 3 k vykreseleni
uhel = linspace(0,1,17); %normalizovany
vyska = linspace(1.3/2,3.7/4,11); %normalizovana

[Mesh_uhly, Mesh_vyska] = meshgrid(uhel*2*pi, vyska*max(t));
X = r(Mesh_vyska) .* sin(Mesh_uhly);
Y = r(Mesh_vyska) .* cos(Mesh_uhly);
Z = Mesh_vyska;

% Vykresleni
handle = mesh(X,Y,Z);  % vykresleni site
set(handle,'EdgeColor',[0 0 0]);

%% Pas c. 4 k vykreseleni
uhel = linspace(0,1,17); %normalizovany
vyska = linspace(3.7/4,1,4); %normalizovana

[Mesh_uhly, Mesh_vyska] = meshgrid(uhel*2*pi, vyska*max(t));
X = r(Mesh_vyska) .* sin(Mesh_uhly);
Y = r(Mesh_vyska) .* cos(Mesh_uhly);
Z = Mesh_vyska;

%korekce nepresneho vyjadreni funkce h (nahore)
l1 = (Mesh_vyska == max(t));
X(l1) = 0;
Y(l1) = 0;

% Vykresleni
handle = mesh(X,Y,Z);  % vykresleni site
set(handle,'EdgeColor',[0 0 0]);

