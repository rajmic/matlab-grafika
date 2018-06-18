function plotscreen(screen)

% Pomocna funkce, vykresli data ze 'screen' do okna - simulace obrazovky

screen = flipud( rot90(screen));
imagesc( screen);
colormap('gray');
set(gca,'DataAspectRatio',[1 1 1])