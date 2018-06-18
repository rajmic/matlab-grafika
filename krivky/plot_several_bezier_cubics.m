function [ ] = plot_several_bezier_cubics(h,v,color)

%Vypocte ze vstupn�(ch) posloupnost(i) ��d�c�ch bod� Bezi�rov�ch kubik
%body na techto krivkach a vykresl� je.
%Matice 'v' mus� m�t 2 sloupce a d�lku n�sobkem 4.
%
%Nap��klad: Vykreslen� matice v1 do figury s handlem h=1, �ervenou barvou
%data = data_pismenko;
%plot_several_bezier_cubics(1,data,'r')

% (c) 2009 Barto�
% (c) 2010-2012 drobn� �pravy Pavel Rajmic

%%
%Generace �asov� osy - po�et vykreslovan�ch bod�. 
t = 0:0.01:1;
%Zji�t�n� d�lky matice v.
de = length(v);
%Test na �plnost matice-n�sobky �ty�.
if rem(de,4) == 0
%Vybr�n� jednotliv�ch k�ivek z matice,v�po�et bod� k�ivek, vykreslen�. 
   for i = 1:4:de
       [x,y] = cubicbezier(v(i,1:2),v(i+1,1:2),v(i+2,1:2),v(i+3,1:2),t');
       hold all;
       figure(h);
       plot(x,y,color);
       %axis([0 10 0 10]); %�prava m���tek os
   end
else
   disp('Vstupn� vektor nen� �pln�, po�et ��d�c�ch bod� pro Bezi�rovu kubiku mus� b�t n�sobkem �ty�.');
end