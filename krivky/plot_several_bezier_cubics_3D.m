function [ ] = plot_several_bezier_cubics_3D(h,v,color)

%Vypocte ze vstupní(ch) posloupnost(í) øídících bodù Beziérových kubik
%body na tìchto køivkách a vykreslí je.
%Matice 'v' musí mít 3 sloupce a délku násobkem 4.
%
%Napøíklad: Vykreslení matice v1 do figury s handlem h=1, èervenou barvou
%data = data_domecek;
%plot_several_bezier_cubics_3D(1,data,'r')

% (c) 2012 Jiøí Kovaøík

%%
%Generace èasové osy - poèet vykreslovaných bodù. 
t = 0:0.01:1;
%Zjištìní délky matice v.
de = length(v);
j = 0;
%Test na úplnost matice-násobky ètyø.
if rem(de,4) == 0
    %Vybrání jednotlivých køivek z matice,výpoèet bodù køivek, vykreslení.
    for i = 1:4:de
        j = j + 1;
        [x,y,z] = cubicbezier3D(v(i,1:3),v(i+1,1:3),v(i+2,1:3),v(i+3,1:3),t');
%         X(:,j) = x;
%         Y(:,j) = y;
%         Z(:,j) = z;
        figure(h);
        plot3(x,y,z,color)
        hold on
    end
    
    axis equal
%     figure(h);
%     hold on;
%     plot3(X,Y,Z,color);
    xlabel('x(t)')
    ylabel('y(t)')
    zlabel('z(t)')
    % Zakomentované pøíkazy jsou pro názorné zobrazení domeèku bez perspektivy.
    % Zobrazí se tak jak jsme zvyklí.
    
    %axis([0 10 0 10 0 10])
    %rotate3d on
    %view(-37.5,30)
    %set(gca,'CameraUpVector',[0,1,0]);
else
   disp('Vstupní vektor není úplný, poèet øídících bodù pro Beziérovu kubiku musí být násobkem ètyø.');
end