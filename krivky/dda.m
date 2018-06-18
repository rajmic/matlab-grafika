function [screen] = dda( screen, a, b)
%% Vykresleni usecky z bodu a do bodu b
%%
%% screen -- pamet obrazu
%% a      -- souradnice bodu a
%% b      -- souradnice bodu b

% pokud je absolutni hodnota smernice vetsi nez 1, musim prehodit osy
if( abs( b(2)-a(2)) > abs( b(1)-a(1)))
    % ridici je osa y
    %ridici je osa x
    % inicializace smernice
    m = (b(1)-a(1))/(b(2)-a(2));
    if( b(2) >= a(2))
        %usecka zdola nahoru
        % vykresleni prvniho bodu
        point = a;
        while( point(2) < b(2))
          screen( floor( point(1)), point(2)) = 255;
          point(2) = point(2) + 1;
          point(1) = point(1) + m;
        end;
    else
        %usecka zhora dolu
        % vykresleni prvniho bodu
        point = a;
        while( point(2) > b(2))
          screen( floor( point(1)), point(2)) = 255;
          point(2) = point(2) - 1;
          point(1) = point(1) - m;
        end;
    end;
else
    %ridici je osa x
    % inicializace smernice
    m = (b(2)-a(2))/(b(1)-a(1));
    if( b(1) >= a(1))
        %usecka zleva do prava
        % vykresleni prvniho bodu
        point = a;
        while( point(1) < b(1))
          screen(point(1),floor(point(2))) = 255;
          point(1) = point(1) + 1;
          point(2) = point(2) + m;
        end;
    else
        %usecka zprava doleva
        % vykresleni prvniho bodu
        point = a;
        while( point(1) > b(1))
          screen(point(1),floor(point(2))) = 255;
          point(1) = point(1) - 1;
          point(2) = point(2) - m;
        end;
    end;
end;    
