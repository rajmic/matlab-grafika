% Demo - Priklad pouziti Perlinovych sumovych funkci
%
% Petr Sysel
% 2009 (c) VUT v Brne

home;
help( mfilename);

% vytvoreni prostoru pro obraz
width = 640;
height = 480;
screen = int16(zeros( width,height));

% pocet car
count = 10;
sirka = width/count;

for( k = 0:count-1)
    y = 0:height-1;
    h = 20*perlinoct( y/height, 5, 1.5, 4);
    for x = 0:sirka
       screen( x+k*sirka+1, :) = 256 * 1/2 * ( 1 + cos( 2*pi*(x + sirka/2 + h)/sirka) );
    end
end

imagesc( flipud( rot90( screen)));