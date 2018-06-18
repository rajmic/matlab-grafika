% DEMO slouží ke generování a visualizaci parametrických ploch.
% 
% size ... poèet px ve smeru jedné osy.
% type ... udává typ parametrické plochy.
%       = 0 ... Náhodnì generované Beziérovy plochy
%       = 1 ... Trumpet
%       = 2 ... Cone
%       = 3 ... Cylinder
%       = 4 ... Torus
%       = 5 ... Sphere
%       = 6 ... Shell
%       = 7 ... Plane
%       = 8 ... Mobius Band
%       = 9 ... Ellipsoid
%       = 10... Snake
%       = 11... Boy's surface
%       = 12... Conic Spiral ...Zmìnou parametrù lze dosáhnout dalších tvarù
%       = 13... Cross-Cap
%       = 14... Dini’s Surface ...Zmìnou parametrù lze dosáhnout dalších tvarù
%       = 15... Enneper’s Surface ... Zmìnou mezí umax, umin, vmax, vmin se
%           nastavuje tvar
%       = 16... Steiner’s Roman Surface
%       = 17... Super Ellipsoid ... Zmìnou parametrù lze dosáhnout dalších tvarù
%       = 18... Super Toroid ...Zmìnou parametrù lze dosáhnout dalších tvarù
% 
% Zroje: http://www.math.uri.edu/~bkaskosz/flashmo/tools/parsur/
%        http://www.vtk.org/VTK/img/ParametricSurfaces.pdf

% A,B,C,D jsou krajní body sítì u x v = [0,1] x [0,1]

% (c) 2009 Petr Doležal
% (c) drobné úpravy 2010,2012,2013 Pavel Rajmic

%% Zde muze uzivatel menit vstupni parametry
size = 100;
type = 9;

home

%% Priprava matic pro ulozeni dilcich ploch
    Surf_X = zeros(size, size);
    Surf_Y = zeros(size, size);
    Surf_Z = zeros(size, size);
    
    Raster_u = zeros(size, size);
    Raster_v = zeros(size, size);
        

switch type
    case 1 %trumpet
        % http://www.math.uri.edu/~bkaskosz/flashmo/tools/parsur/
        umax = 17; 
        umin = 0;
        vmax = 2*pi;
        vmin = 0;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = u;
                 Surf_Y(i,j) = 6/((u+1)^0.7)*cos(v);
                 Surf_Z(i,j) = 6/((u+1)^0.7)*sin(v);
             end
        end %trumpet

    case 2 %cone
        % http://www.math.uri.edu/~bkaskosz/flashmo/tools/parsur/
        umax = 1; 
        umin = -1;
        vmax = 2*pi;
        vmin = 0;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = u*cos(v);
                 Surf_Y(i,j) = u*sin(v);
                 Surf_Z(i,j) = u;
             end
        end %Cone

    case 3 %cylinder
        % http://www.math.uri.edu/~bkaskosz/flashmo/tools/parsur/
        umax = 3; 
        umin = 0;
        vmax = 2*pi;
        vmin = 0;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = cos(v);
                 Surf_Y(i,j) = sin(v);
                 Surf_Z(i,j) = u;
             end
        end % Cylinder
        
    case 4 %Torus
        % http://www.math.uri.edu/~bkaskosz/flashmo/tools/parsur/
        umax = 2*pi; 
        umin = 0;
        vmax = 2*pi;
        vmin = 0;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = 3*cos(v)+cos(u)*cos(v);
                 Surf_Y(i,j) = 3*sin(v)+cos(u)*sin(v);
                 Surf_Z(i,j) = sin(u);
             end
        end % Torus
        
    case 5 %Sphere
        % http://www.math.uri.edu/~bkaskosz/flashmo/tools/parsur/
        umax = pi; 
        umin = 0;
        vmax = 2*pi;
        vmin = 0;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = sin(u)*cos(v);
                 Surf_Y(i,j) = sin(u)*sin(v);
                 Surf_Z(i,j) = cos(u);
             end
        end % Sphere        

    case 6 %Shell
        % http://www.math.uri.edu/~bkaskosz/flashmo/tools/parsur/
        umax = pi; 
        umin = 0;
        vmax = 1.1*pi;
        vmin = -6;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = (4/3)^v*sin(u)*sin(u)*cos(v);
                 Surf_Y(i,j) = (4/3)^v*sin(u)*sin(u)*sin(v);
                 Surf_Z(i,j) = (4/3)^v*sin(u)*cos(u);
             end
        end % Shell          

    case 7 %Plane
        % http://www.math.uri.edu/~bkaskosz/flashmo/tools/parsur/
        umax = 1; 
        umin = -1;
        vmax = 1;
        vmin = -1;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = v;
                 Surf_Y(i,j) = 0;
                 Surf_Z(i,j) = u;
             end
        end % Plane
        
    case 8 %Mobius Band
        % http://www.math.uri.edu/~bkaskosz/flashmo/tools/parsur/
        umax = 0.5; 
        umin = -0.5;
        vmax = 2*pi;
        vmin = 0;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = 2*cos(v)+u*cos(v/2);
                 Surf_Y(i,j) = 2*sin(v)+u*cos(v/2);
                 Surf_Z(i,j) = u*sin(v/2);
             end
        end % Mobius Band        

    case 9 % Ellispoid
        % http://www.math.uri.edu/~bkaskosz/flashmo/tools/parsur/
        umax = pi; 
        umin = 0;
        vmax = 2*pi;
        vmin = 0;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = sin(u)*cos(v);
                 Surf_Y(i,j) = 2*sin(u)*sin(v);
                 Surf_Z(i,j) = cos(u);
             end
        end % Ellipsoid           
        
     case 10 % Snake
        % http://www.math.uri.edu/~bkaskosz/flashmo/tools/parsur/
        umax = 2*pi; 
        umin = 0;
        vmax = 1;
        vmin = 0;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = (1-v)*(3+cos(u))*cos(2*pi*v);
                 Surf_Y(i,j) = (1-v)*(3+cos(u))*sin(2*pi*v);
                 Surf_Z(i,j) = 6*v+(1-v)*sin(u);
             end
        end % Snake        

     case 11 % Boy's Surface
        % http://www.vtk.org/VTK/img/ParametricSurfaces.pdf
        umax = pi; 
        umin = 0;
        vmax = pi;
        vmin = 0;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s
                 
                 X = cos(u)*sin(v);
                 Y = sin(u)*sin(v);
                 Z = cos(v);

                 Surf_X(i,j) = 0.5*(2*X^2 - Y^2 - Z^2 + 2*Y*Z*(Y^2 - Z^2) + Z*X*(X^2 - Z^2) + X*Y*(Y^2 - X^2)) ;
                 Surf_Y(i,j) = sqrt(3)*0.5*(Y^2 - Z^2 + (Z*X*(Z^2 - X^2) + X*Y*(Y^2 - X^2)));
                 Surf_Z(i,j) = (X + Y + Z)*((X + Y + Z)^3 + 4*(Y - X)*(Z - Y)*(X - Z));
             end
        end % Boy's Surface          

     case 12 % Conic Spiral
        % http://www.vtk.org/VTK/img/ParametricSurfaces.pdf
        umax = 2*pi; 
        umin = 0;
        vmax = 2*pi;
        vmin = 0;
        
        a = 1;
        b = 0.1;
        c = 0.0;
        n = 2.0;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = a*(1 - v/(2*pi))*cos(n*v)*(1 + cos(u)) + c*cos(n*v);
                 Surf_Y(i,j) = a*(1 - v/(2*pi))*sin(n*v)*(1 + cos(u)) + c*sin(n*v);
                 Surf_Z(i,j) = (b*v + a*(1 - v/(2*pi))*sin(u))/(2*pi);
             end
        end % Conic Spiral 

     case 13 % Cross-Cap
        % http://www.vtk.org/VTK/img/ParametricSurfaces.pdf
        umax = pi; 
        umin = 0;
        vmax = pi;
        vmin = 0;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = cos(u)*sin(2*v);
                 Surf_Y(i,j) = sin(u)*sin(2*v);
                 Surf_Z(i,j) = cos(v)*cos(v) - (cos(u))^2*(sin(v))^2;
             end
        end % Cross-Cap     
        
      case 14 % Dini’s Surface
        % http://www.vtk.org/VTK/img/ParametricSurfaces.pdf
        umax = 10; 
        umin = 0;
        vmax = 1;
        vmin = 0;
        
        a = 1;
        b = 0.1;
        
        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = a*cos(u)*sin(v);
                 Surf_Y(i,j) = a*sin(u)*sin(v);
                 Surf_Z(i,j) = a*(cos(v)+log(tan(v/2))) + b*u;
             end
        end % Dini’s Surface        
        
       case 15 % Enneper’s Surface
        % http://www.vtk.org/VTK/img/ParametricSurfaces.pdf
        umax = 10; 
        umin = -10;
        vmax = 10;
        vmin = -10;

        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = u - u^3/3 + u*v^2;
                 Surf_Y(i,j) = v - v^3/3 + v*u^2;
                 Surf_Z(i,j) = u^2 - v^2;
             end
        end % Enneper’s Surface           
        
       case 16 % Steiner’s Roman Surface
        % http://www.vtk.org/VTK/img/ParametricSurfaces.pdf
        umax = pi; 
        umin = 0;
        vmax = pi;
        vmin = 0;
        
        a = 1;

        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = (a^2*cos(v)^2*sin(2*u))/2;
                 Surf_Y(i,j) = (a^2*sin(u)*sin(2*v))/2;
                 Surf_Z(i,j) = (a^2*cos(u)*sin(2*v))/2;
             end
        end % Steiner’s Roman Surface        
        
       case 17 % Super Ellipsoid
        % http://www.vtk.org/VTK/img/ParametricSurfaces.pdf
        umax = 2*pi; 
        umin = 0;
        vmax = pi;
        vmin = 0;
        
        a = 3;
        b = 2;
        c = 1;
        
        n = 0.6;
        nn = 1.4;

        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = a*sin(v)^n*cos(u)^nn;
                 Surf_Y(i,j) = b*sin(v)^n*sin(u)^nn;
                 Surf_Z(i,j) = c*cos(v)^n;
                 Surf_X(i,j) = real(Surf_X(i,j)); %kvuli numerickym problemum / MATLAB pridaval temer nulovou imaginarni slozku
                 Surf_Y(i,j) = real(Surf_Y(i,j)); %kvuli numerickym problemum / MATLAB pridaval temer nulovou imaginarni slozku
                 Surf_Z(i,j) = real(Surf_Z(i,j)); %kvuli numerickym problemum / MATLAB pridaval temer nulovou imaginarni slozku
             end
        end % Super Ellipsoid
        
       case 18 % Super Toroid
        % http://www.vtk.org/VTK/img/ParametricSurfaces.pdf
        umax = 2*pi; 
        umin = 0;
        vmax = 2*pi;
        vmin = 0;
        
        rx = 5;
        ry = 2;
        rz = 1;
        a = 2;
        c = 6;
        n = 0.7;
        nn = 0.8;

        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

                 Surf_X(i,j) = rx*(c + a*cos(v)^nn)*cos(u)^n;
                 Surf_Y(i,j) = ry*(c + a*cos(v)^nn)*sin(u)^n;
                 Surf_Z(i,j) = rz*a*sin(v)^nn;
                 Surf_X(i,j) = real(Surf_X(i,j)); %kvuli numerickym problemum / MATLAB pridaval temer nulovou imaginarni slozku
                 Surf_Y(i,j) = real(Surf_Y(i,j)); %kvuli numerickym problemum / MATLAB pridaval temer nulovou imaginarni slozku
                 Surf_Z(i,j) = real(Surf_Z(i,j)); %kvuli numerickym problemum / MATLAB pridaval temer nulovou imaginarni slozku
             end
        end % Super Toroid 
        
    otherwise %defaultnì se generuji nahodne Bezierovy plochy
        % Náhodné generování øídících bodù. Každý bod v prostoru je urèen 3
        % souøadnicemi, náhodnì generujeme pouze souøadnici z. Souøadnice
        % x,y jsou dány napevno, tak aby byly rovnomìrnì rozprostøeny po
        % celé ploše z rozsahu 0..1x0..1. Tato skuteènost a zároveò
        % vlastnosti Bezierovy køivky nám umožní zjednodušení v tom smyslu,
        % že souøadnice x,y øídících bodù nemusíme vùbec uvažovat. Funkce 
        % rand generuje èísla z rozsahu 0..1 a proto není nutné souøadnice
        % normalizovat. Generujeme 3 sady po 16ti øídících bodech. 
          
        Points_X_z = rand (4,4);
        Points_Y_z = rand (4,4);
        Points_Z_z = rand (4,4);
                
        %Bazova matice pro bezierovu krivku        
        Mb = [-1  3 -3 1;...
               3 -6  3 0;...
              -3  3  0 0;...
               1  0  0 0];
           
        umax = 1; 
        umin = 0;
        vmax = 1;
        vmin = 0;

        for i = 1:size
             for j = 1:size
                 u = (umax-umin)*((i-1)/(size-1))+umin;%t
                 v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s
                 
                 U = [u^3 u^2 u 1];
                 V = [v^3 v^2 v 1];
                 
                 Surf_X(i,j) = U*Mb*Points_X_z*Mb'*V';
                 Surf_Y(i,j) = U*Mb*Points_Y_z*Mb'*V';                 
                 Surf_Z(i,j) = U*Mb*Points_Z_z*Mb'*V';               
             end
        end %bezier

end %switch


% Zakladní rastr pro plochy
for i = 1:size
    for j = 1:size
        u = (umax-umin)*((i-1)/(size-1))+umin;%t
        v = (vmax-vmin)*((j-1)/(size-1))+vmin;%s

        Raster_u(i,j) = u;
        Raster_v(i,j) = v;

    end
end


%% Visualizace 
figure()
colormap(cool)

% plocha Z(u,v)
subplot(2,2,1)
    surf(Raster_u(:,:),Raster_v(:,:),Surf_Z(:,:))
    view(3)
    xlabel('u')
    ylabel('v')
    zlabel('Z(u,v)')
    grid on
    % shading flat
    % shading faceted
    % shading interp
    hold on
    plot3(Raster_u(1,1),     Raster_v(1,1),     Surf_Z(1,1),'rs')
    text( Raster_u(1,1),     Raster_v(1,1),     Surf_Z(1,1),'A','BackgroundColor',[.7 .9 .7],'Color', 'r')
    plot3(Raster_u(1,1),     Raster_v(end,end), Surf_Z(1,end),'rs')
    text( Raster_u(1,1),     Raster_v(end,end), Surf_Z(1,end),'B','BackgroundColor',[.7 .9 .7],'Color', 'r')
    plot3(Raster_u(end,end), Raster_v(1,1),     Surf_Z(end,1),'rs')
    text( Raster_u(end,end), Raster_v(1,1),     Surf_Z(end,1),'C','BackgroundColor',[.7 .9 .7],'Color', 'r')
    plot3(Raster_u(end,end), Raster_v(end,end), Surf_Z(end,end),'rs')
    text( Raster_u(end,end), Raster_v(end,end), Surf_Z(end,end),'D','BackgroundColor',[.7 .9 .7],'Color', 'r')

% plocha Y(u,v)
subplot(2,2,3)   
    surf(Surf_Y(:,:),Raster_u(:,:),Raster_v(:,:))
    view(55, 30) 
    xlabel('Y(u,v)')
    ylabel('u')
    zlabel('v')
    grid on 
    % shading flat
    % shading faceted
    % shading interp    
    hold on
    plot3(Surf_Y(1,1),      Raster_u(1,1),      Raster_v(1,1),'rs')
    text( Surf_Y(1,1),      Raster_u(1,1),      Raster_v(1,1),'A','BackgroundColor',[.7 .9 .7],'Color', 'r')
    plot3(Surf_Y(1,end),    Raster_u(1,1),      Raster_v(end,end),'rs')
    text( Surf_Y(1,end),    Raster_u(1,1),      Raster_v(end,end),'B','BackgroundColor',[.7 .9 .7],'Color', 'r')
    plot3(Surf_Y(end,1),    Raster_u(end,end),  Raster_v(1,1),'rs')
    text( Surf_Y(end,1),    Raster_u(end,end),  Raster_v(1,1),'C','BackgroundColor',[.7 .9 .7],'Color', 'r')
    plot3(Surf_Y(end,end),  Raster_u(end,end),  Raster_v(end,end),'rs')
    text( Surf_Y(end,end),  Raster_u(end,end),  Raster_v(end,end),'D','BackgroundColor',[.7 .9 .7],'Color', 'r')

%plocha X
subplot(2,2,4)    
    view(3)    
    surf(Surf_X(:,:),Raster_u(:,:),Raster_v(:,:))
    xlabel('X(u,v)')
    ylabel('u')
    zlabel('v')
    grid on
    % shading flat
    % shading faceted
    % shading interp
    hold on
    plot3(Surf_X(1,1),     Raster_u(1,1),     Raster_v(1,1),'rs')
    text( Surf_X(1,1),     Raster_u(1,1),     Raster_v(1,1),'A','BackgroundColor',[.7 .9 .7],'Color', 'r')
    plot3(Surf_X(1,end),   Raster_u(1,1),     Raster_v(end,end),'rs')
    text( Surf_X(1,end),   Raster_u(1,1),     Raster_v(end,end),'B','BackgroundColor',[.7 .9 .7],'Color', 'r')
    plot3(Surf_X(end,1),   Raster_u(end,end), Raster_v(1,1),'rs')
    text( Surf_X(end,1),   Raster_u(end,end), Raster_v(1,1),'C','BackgroundColor',[.7 .9 .7],'Color', 'r')
    plot3(Surf_X(end,end), Raster_u(end,end), Raster_v(end,end),'rs')
    text( Surf_X(end,end), Raster_u(end,end), Raster_v(end,end),'D','BackgroundColor',[.7 .9 .7],'Color', 'r')

% Výsledná parametrická plocha
subplot(2,2,2)
    view(3)   
    %surf(Surf_X(:,:),Surf_Y(:,:),Surf_Z(:,:))
    % Volitelnì lze namapovat šachovnici, je vhodne zvolit shading
    % flat, pouziti prikazu warp u ostatnich subplotu zmeni
    % nastaveni colormap (!).
    texture = generuj_sachovnici (20, 20, 100, 100);
    if ~isoctave
        warp(Surf_X(:,:),Surf_Y(:,:),Surf_Z(:,:),texture);
    else
        surf(Surf_X(:,:),Surf_Y(:,:),Surf_Z(:,:),texture);
    end
    %%%%%
    xlabel('X(u,v)')
    ylabel('Y(u,v)')
    zlabel('Z(u,v)')
    title('Výsledná ''plocha''')
    grid on
    shading flat
    % shading faceted
    % shading interp      
    hold on
    plot3(Surf_X(1,1)     ,Surf_Y(1,1),     Surf_Z(1,1),'rs')
    text( Surf_X(1,1)     ,Surf_Y(1,1),     Surf_Z(1,1),'A','BackgroundColor',[.7 .9 .7],'Color', 'r')
    plot3(Surf_X(1,end)   ,Surf_Y(1,end),   Surf_Z(1,end),'rs')
    text( Surf_X(1,end)   ,Surf_Y(1,end),   Surf_Z(1,end),'B','BackgroundColor',[.7 .9 .7],'Color', 'r')
    plot3(Surf_X(end,1)   ,Surf_Y(end,1),   Surf_Z(end,1),'rs')
    text( Surf_X(end,1)   ,Surf_Y(end,1),   Surf_Z(end,1),'C','BackgroundColor',[.7 .9 .7],'Color', 'r')
    plot3(Surf_X(end,end) ,Surf_Y(end,end), Surf_Z(end,end),'rs')
    text( Surf_X(end,end) ,Surf_Y(end,end), Surf_Z(end,end),'D','BackgroundColor',[.7 .9 .7],'Color', 'r')
