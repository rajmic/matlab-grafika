% DEMO - Priklad rasterizace elipsy Bresenhamovym algoritmem

% (c) 2006-2018, Petr Sysel, Pavel Rajmic, UTKO FEKT VUT v Brnehome;

clear all
close all

home;
help( mfilename);

%% stred elipsy
center = [250,250];
%% excentricity
% b = 71;
% a = 143;
b = 51;
a = 173;
% b = 100;
% a = 200;


%% priprava plochy
screen = zeros( 640, 480);

%% PRVNI POLOVINA -- ridici osou je x
%% inicializace bodu
point = [0,b];
%% inicializace predikce
p = floor(b^2 - a^2*b - a^2/4);
% p = (b^2 - a^2*b - a^2/4);
%% opakuj
while( b^2*point(1) <= a^2*point(2))
    %% vykresleni bodu
    % (zrcadleni diky soumernosti podle obou os)
    tmp = point+center;
    screen(tmp(1), tmp(2)) = 255;
    tmp = point*[1,0;0,-1]+center;
    screen(tmp(1), tmp(2)) = 255;
    tmp = point*[-1,0;0,1]+center;
    screen(tmp(1), tmp(2)) = 255;
    tmp = point*[-1,0;0,-1]+center;
    screen(tmp(1), tmp(2)) = 255;
    %% aktualizace predikce
    if( p > 0)
%       p = p + b^2*(2*point(1)+1) - 2*a^2*point(2);
      p = p + b^2*(2*point(1)+3) - 2*a^2*(point(2)-1);
      point(2) = point(2) - 1;  %snizi se druha osa
    else
%       p = p + b^2*(2*point(1)+1);  %jinak zustane na stejne hodnote
      p = p + b^2*(2*point(1)+3);
      %a druha osa zustane na stejne hodnote
    end;
    %% posun
    point(1) = point(1) + 1;
end;

%% DRUHA POLOVINA -- ridici osou je y
%% inicializace bodu
point = [a,0];
%% inicializace predikce
p = floor(a^2 - b^2*a - b^2/4);
%% opakuj
while( b^2*point(1) >= a^2*point(2))
    %% vykresleni bodu
    % (zrcadleni diky soumernosti podle obou os)
    tmp = point+center;
    screen(tmp(1), tmp(2)) = 255;
    tmp = point*[1,0;0,-1]+center;
    screen(tmp(1), tmp(2)) = 255;
    tmp = point*[-1,0;0,1]+center;
    screen(tmp(1), tmp(2)) = 255;
    tmp = point*[-1,0;0,-1]+center;
    screen(tmp(1), tmp(2)) = 255;
    %% aktualizace predikce
    if( p > 0)
%       p = p + a^2*(2*point(2)+1) - 2*b^2*point(1);
      p = p + a^2*(2*point(2)+3) - 2*b^2*(point(1)-1);
      point(1) = point(1) - 1;
    else
      p = p + a^2*(2*point(2)+3);
    end;
    %% posun
    point(2) = point(2) + 1;
end;

screen(center(1),center(2)) = 127; %stred

%% vykresleni presne elipsy a jeji prime rasterizace
N = 300; %pocet bodu
angles = (0:N)'/N*(pi/2);
points(:,1) = a*cos(angles) + center(1);
points(:,2) = b*sin(angles) + center(2);
% for cnt = 1:N
%     screen(round(points(cnt,1)),round(points(cnt,2))) = 127;
% end
% % bod zmeny ridici osy
% screen(center(1) + round(a^2/sqrt(a^2+b^2)), center(2) + round(b^2/sqrt(a^2+b^2))) = 183;

%% vykresleni obrazovky
plotscreen(screen)
hold on
line(points(:,1),points(:,2))
plot(center(1)+a^2/sqrt(a^2+b^2), center(2)+b^2/sqrt(a^2+b^2),'bo')