function [ ] = plot_several_bezier_cubics(h,v,color)

%Vypocte ze vstupní(ch) posloupnost(i) øídících bodù Beziérových kubik
%body na techto krivkach a vykreslí je.
%Matice 'v' musí mít 2 sloupce a délku násobkem 4.
%
%Napøíklad: Vykreslení matice v1 do figury s handlem h=1, èervenou barvou
%data = data_pismenko;
%plot_several_bezier_cubics(1,data,'r')

% (c) 2009 Bartoò
% (c) 2010-2012 drobné úpravy Pavel Rajmic

%%
%Generace èasové osy - poèet vykreslovaných bodù. 
t = 0:0.01:1;
%Zjištìní délky matice v.
de = length(v);
%Test na úplnost matice-násobky ètyø.
if rem(de,4) == 0
%Vybrání jednotlivých køivek z matice,výpoèet bodù køivek, vykreslení. 
   for i = 1:4:de
       [x,y] = cubicbezier(v(i,1:2),v(i+1,1:2),v(i+2,1:2),v(i+3,1:2),t');
       hold all;
       figure(h);
       plot(x,y,color);
       %axis([0 10 0 10]); %úprava mìøítek os
   end
else
   disp('Vstupní vektor není úplný, poèet øídících bodù pro Beziérovu kubiku musí být násobkem ètyø.');
end