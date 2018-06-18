function [screen] = bresenham_pravouhly( screen, a, b, style)
%% screen -- pamet obrazu
%% a      -- souradnice bodu a
%% b      -- souradnice bodu b
%% style  -- sablona vzoru

% inicializace konstant
k1 = 2*(b(2) - a(2));
k2 = 2*((b(2) - a(2))-(b(1) - a(1)));
%% inicializace predikce
p = 2*(b(2) - a(2)) - (b(1) - a(1));
% inicializace bodu
point = a;
% inicializace stylu
done = 1; rest = length( style);
%% vykresleni bodu 
screen( point) = 255;
while( point(1) < b(1))
  point(1) = point(1) + 1;
  if( p > 0)
    point( 2) = point( 2) + 1;
    p = p + k2;
  else
    p = p + k1;
  end;
  % vykresleni pouze pokud to odpovida vzoru
  if( style( done) == 1)
    screen(point(1),point(2)) = 255;
  end;
  done = done + 1;
  rest = rest - 1;
  if( rest == 0)
    done = 1;
    rest = length( style);
  end
end;