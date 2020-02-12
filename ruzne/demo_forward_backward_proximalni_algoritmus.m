%% DEMO ukazuje minimalizaci funkce pomocí forward-backward algoritmu

% resi se minimalizace funkce jednoho parametru, tvaru:
% min_x { g(x) + 1/2 |a*x+b| }
% g(x)...je konvexni funkce, nize pouzita kvadraticka

% (c) 2020 Erik Ochodnicky, Pavel Rajmic, FEKT VUT v Brne

close all
clc

%% Volba parametru funkci
a = 2;
b = -7;
h = @(x) 0.5* abs(a*x+b);

g = @(x) 0.4*(0.6*x+3).^2;
g_deriv = @(x) 0.48*(0.6*x+3); %rucne spocitana derivace

%% Nastaveni algoritmu
t = 2.2;  % delka gradientniho kroku...
          % ...konvergence je zarucena pokud t <= 2/B, kde B je
          % lipschitzovska konstanta funkce g
        
x0 = 8; % startovaci bod

maxiter = 100; %maximalni pocet iteraci
epsilon = 10^(-2); %odchylka pri ktere uz se iterace zastavi

%% Algoritmus
i = 1; % pocitadlo iteraci
fin = 0;
xx = zeros(1,maxiter); %zde se ukladaji zaznamy pro vykresleni

while i<maxiter
    x1 = x0 - t*g_deriv(x0);
    x2 = proxth(x1,t,a,b); % vyhodnoceni prox
    xx(i) = x2;
    if (abs(x0-x2) < epsilon) % kriterium konvergence
        xx(i+1:maxiter)=[];
        i=maxiter;
        fin=x2;
    end
    x0=x2;
    i=i+1;
    if i>=maxiter
        fin=x2;
        disp('Dosahlo se max. poctu iteraci');
    end
end

%% Vypsani


%% Vykresleni
tt = linspace(-4,6,200);
figure
hold on
plot(tt,g(tt),'--r')
plot(tt,h(tt),'--g')
plot(tt,g(tt)+h(tt),'b')
legend('g(x)','h(x)','g(x)+h(x)')

figure
plot(tt,g(tt)+h(tt),'b')
hold on

for j=1:length(xx)
    if j==length(xx)
       plot(xx(j),g(xx(j))+h(xx(j)),'ob');
       drawnow 
    else
    plot(xx(j),g(xx(j))+h(xx(j)),'xr'); drawnow
    pause(3/length(xx)); 
    end
end
hold off

%% proximalni operatory
function p = proxth(x,t,a,b)
    p = 1/a*soft(a*x+b,t*0.5*a^2)-(b/a); % takto vypada poximalni operator funkce h
end

function s = soft(a,b)  % mekke prahovani
    s = sign(a)*max(abs(a)-b,0);
end