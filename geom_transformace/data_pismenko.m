function data = data_pismenko

%Matice nìkolika øídících bodù Beziérových kubik pro vykreslení pismenka "R".
%Data jsou jako kaertézské 3D-souøadnice ve sloupcích.
%
%Volání: body = data_pismenko

% 2D-data
cara1 = [2,4,4,2;...
         6,6,4,4];
cara2 = [2,2,2,2;...
         6,6,2,2];
oblouk = [2,2,3.5,3.5;...
          4,4,2,2];
data = [cara1 cara2 oblouk];

% treti souradnice nulova
data(3,1) = 0;