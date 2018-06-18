% demo ukazujici vrzeni stinu

% (c) 2012 Pavel Rajmic, Zdenek Jedlicka, Vysoke uceni technicke v Brne

clc
close all

%% Vstupni hodnoty
% projekcni rovina
plane = [[1 1 0]' [0.5 1 2]']
% A = [1 10 ; 
%      2 11 ;
%      1 -5  ];

%posun plochy po ose 'z'
offset = -5

%promitany bod  
point = [3 2 7]'

%vektor svetla
light = [8 3 -2];
light'
 
%%  Vypocet promitaneho bodu
point_proj = project_point2plane(point,plane,offset,light)


%% Vykresleni bodu a vektoru
figure

%puvodni bod
plot3(point(1),point(2),point(3),'ro');
grid on
hold on

%promitnuty bod
plot3(point_proj(1),point_proj(2),point_proj(3),'rx');

%vektor smeru promitani (svetla)
% %original
% quiver3(0,0,0,light(1),light(2),light(3),0) 
% jiny zpusob
rozdil = point_proj-point
quiver3(point(1), point(2), point(3), rozdil(1), rozdil(2), rozdil(3), 1)
% % jeste jiny zpusob
% quiver3(point(1), point(2), point(3), light(1), light(2), light(3),0);

%% Vykresleni projekcni roviny
factorx = 1.2; % zvetseni rozsahu v procentech puvodniho rozsahu
factory = 1.2; % zvetseni rozsahu v procentech puvodniho rozsahu

maxx = max([point(1) point_proj(1)]);
minx = min([point(1) point_proj(1)]);
meanx = mean([maxx ,minx]);
maxx = (maxx - meanx)* factorx + meanx;
minx = (minx - meanx)* factorx + meanx;

maxy = max([point(2) point_proj(2)]);
miny = min([point(2) point_proj(2)]);
meany = mean([maxy ,miny]);
maxy = (maxy - meany)* factory + meany;
miny = (miny - meany)* factory + meany;

[Mx,My] = meshgrid([minx maxx],[miny maxy]);
normal = null(plane');
Mz = -1* (normal(1)*Mx+normal(2)*My) / normal(3) + offset;
h = mesh(Mx, My, Mz, 'FaceColor', 'green', 'EdgeColor', 'none');

if ~isoctave
    set(h,'FaceAlpha',0.8)
    % alpha(0.8)
end


%% Vykresleni os
% x
xlabel('x')
minx = min(minx,0);
maxx = max(maxx,0);
h = plot3([minx,maxx],[0,0],[0,0],'k');
set(h,'LineWidth',2)
% y
ylabel('y')
miny = min(miny,0);
maxy = max(maxy,0);
h = plot3([0,0],[miny,maxy],[0,0],'k');
set(h,'LineWidth',2)
% z
zlabel('z')
minz = min(min(min(Mz)),0);
maxz = max(max(max(Mz)),0);
h = plot3([0,0],[0,0],[minz,maxz],'k');
set(h,'LineWidth',2)
%upraveni rozsahu
% set(gca,'ZLim',[0, max(max(w),1)])

%% Popisky
title('Projekce bodu na plochu urcenym smerem')
legend('Puvodni bod', 'Promitnuty bod', 'Vektor svetla', 'Projekcni rovina')

hold off
