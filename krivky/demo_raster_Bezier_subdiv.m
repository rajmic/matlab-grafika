function demo_raster_Bezier_subdiv
% DEMO - pouziti de Casteljau pro vykresleni Bezierovy krivky (v rastru)
%
% Demo ukazuje cim dal jemnejsi priblizeni bodu ke krivce (subdivision).
% Krivka je nejprve rozdelena v polovine, nasledne jsou oba jeji podsegmenty
% rozdeleny v polovine, atd.

% (c) 2006-2019, Petr Sysel, Pavel Rajmic, UTKO FEKT VUT v Brne

home;
help(mfilename);
 
% definice obrazovky
screen = zeros(640,480);

% definice ridicich bodu
P0 = [100, 100];
P1 = [200, 350];
P2 = [350, 150];
P3 = [400, 300];

% pocet stupnu rozkladu
fine =  5;
disp(['Iterativni vykreslovani Berierovy krivky pomoci posloupnosti usecek,'])
disp(['Celkovy pocet iteraci: ' num2str(fine)])

%% rozklad 
for k = 0: fine
  % vykresleni
  screen = zeros(640, 480);
  screen = bezier_deleni(screen, P0, P1, P2, P3, k);

  imagesc(rot90(screen));
  colormap('gray');
  set(gca,'DataAspectRatio',[1 1 1])

  disp('Stiskni klavesu');
  pause;
end

disp('Konec vykreslovani');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [screen] = bezier_deleni( screen, P1, P2, P3, P4, count)
% vykresli Bezierovu kubiku pomoci lomene primky
% body jsou ziskany pomoci subdivision

if ( count > 0)
  count = count - 1;

  % rekurze
  left1 = P1;
  left2 = floor(( P1+P2) / 2);
  tmp = floor((P2+P3) / 2);
  left3 = floor(( left2+tmp)/2);
  right4 = P4;
  right3 = floor((P3+P4) / 2);
  right2 = floor((tmp + right3) / 2);
  right1 = floor(( left3+right2) / 2);
  left4 = floor((left3+ right2) / 2);

  screen = bezier( screen, left1, left2, left3, left4, count);
  screen = bezier( screen, right1, right2, right3, right4, count);
else
  screen = dda( screen, P1, P2);
  screen = dda( screen, P2, P3);
  screen = dda( screen, P3, P4);
end
