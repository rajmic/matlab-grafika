function [ ] = plot_several_bezier_cubics_3D(h,v,color)

%Vypocte ze vstupn�(ch) posloupnost(�) ��d�c�ch bod� Bezi�rov�ch kubik
%body na t�chto k�ivk�ch a vykresl� je.
%Matice 'v' mus� m�t 3 sloupce a d�lku n�sobkem 4.
%
%Nap��klad: Vykreslen� matice v1 do figury s handlem h=1, �ervenou barvou
%data = data_domecek;
%plot_several_bezier_cubics_3D(1,data,'r')

% (c) 2012 Ji�� Kova��k

%%
%Generace �asov� osy - po�et vykreslovan�ch bod�. 
t = 0:0.01:1;
%Zji�t�n� d�lky matice v.
de = length(v);
j = 0;
%Test na �plnost matice-n�sobky �ty�.
if rem(de,4) == 0
    %Vybr�n� jednotliv�ch k�ivek z matice,v�po�et bod� k�ivek, vykreslen�.
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
    % Zakomentovan� p��kazy jsou pro n�zorn� zobrazen� dome�ku bez perspektivy.
    % Zobraz� se tak jak jsme zvykl�.
    
    %axis([0 10 0 10 0 10])
    %rotate3d on
    %view(-37.5,30)
    %set(gca,'CameraUpVector',[0,1,0]);
else
   disp('Vstupn� vektor nen� �pln�, po�et ��d�c�ch bod� pro Bezi�rovu kubiku mus� b�t n�sobkem �ty�.');
end