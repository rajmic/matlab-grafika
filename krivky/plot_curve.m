function h = plot_curve(x,y,t)

% PLOT_CURVE vykresli do grafu prubeh krivky
%
% PLOT_CURVE(x,y) vykresli jeden graf s prùbìhem køivky
% PLOT_CURVE(x,y,t) vykresli tøi provázané grafy s viditelnou parametrizací
%
% x,y.......[x(t),y(t)]; dva sloupcove vektory souradnic
% t.........casovy vektor, sloupcovy, nepovinny, pokud je pritomny, vykresli se i pomocne
%           osy ukazujici jak funguje parametricka reprezentace.
%           Predpoklada se t=[0,...,1]'.
% h.........handle na vysledny graf (figuru)

% Priklad:
% krok = 0.05;
% t = (0:krok:1)';
% C = randn(5,2);
% [x,y] = polyn_curve(C,t);
% plot_curve(x,y,t)

% (c) 2009-2012 Pavel Rajmic, UTKO FEKT VUT v Brne

%% Kontrola
p = nargin;
if p > 3; error; end
if p < 2; error; end
if p == 3
    bTriGrafy = true;
else
    bTriGrafy = false;
end

%% Kresleni
h = figure;
if bTriGrafy % priprava a castecne kresleni ve trojich osach
    % t versus y(t)
    subplot(2,2,1)
    plot(t,y)
    xlabel('t'), ylabel('y(t)')
    title('Prubeh y(t)')
    axis tight
    aux = axis;
    ymin = aux(3); ymax = aux(4); %zjisteni rozsahu vertikalni osy
    
    % t versus x(t) (v opacnem gardu)
    subplot(2,2,4)
    plot(x,t)
    xlabel('x(t)'), ylabel('t')
    title('Prubeh x(t) - prohozene osy')
    axis tight
    aux = axis;
    xmin = aux(1); xmax = aux(2); %zjisteni rozsahu vertikalni osy
    
    % x(t) versus y(t) - priprava os pro kresleni
    hxy = subplot(2,2,2);
    
else %priprava pouze jednech os pro kresleni
    hxy = axes;
    
end

axes(hxy)
plot(x,y)
text(x(1),y(1),'q(0)')
text(x(end),y(end),'q(1)')
xlabel('x(t)'), ylabel('y(t)')
ht = title('Prubeh krivky Q(t) v case');
if bTriGrafy %uprava rozsahu os - prizpusobeni druhym dvema grafum
    set(ht,'FontWeight','bold') %titulek tucne
    set(gca,'YLim',[ymin ymax])
    set(gca,'XLim',[xmin xmax])
end

clear aux hxy

