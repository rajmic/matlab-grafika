function R = rotating_matrix(uhel,osa)

%Vytvoøí matici R, která reprezentuje rotaci bodu kolem osy, ktera je
%zadana vektorem
%
%Pøíklady použití:
%Matice rotace kolem osy X o úhel 30°
%R = rotating_matrix(30,[1 0 0])
%
%Rotace podle osy Y
%R = rotating_matrix(30,[0 1 0])
%
%Rotace podle osy Z
%R = rotating_matrix(30,[0 0 1])
%
%Rotace v rovine XY
%R = rotating_matrix(30,[1 1 0])

% (c) 2009 Bartoò
% (c) 2010, 2016 drobné úpravy Rajmic

%%
%Ovìøení, zda je správnì zadaná osa rotace.
max = norm(osa);
if (max < eps)
   error('Osa otáèení nesmí mít nulovou velikost!');
end

%Znormování osy rotace k hodnotì 1.
osa = osa/max;
%Naètení vektoru os do promìnných.
x = osa(1);
y = osa(2);
z = osa(3);
%Pomocné výpoèty.
x2 = x^2;
y2 = y^2;
z2 = z^2;
c = cos((pi/180)*uhel);
s = sin((pi/180)*uhel);
%Alokace matice 4x4.
R = zeros(4,4);
%Naplnìní této matice hodnotami.
R(1,1) =  x2 + (y2 + z2)*c;
R(1,2) = x*y*(1-c) - z*s;
R(1,3) = x*z*(1-c) + y*s;
% R(1,4) = 0;
R(2,1) = x*y*(1-c) + z*s;
R(2,2) = y2 + (x2+z2)*c;
R(2,3) = y*z*(1-c) - x*s;
% R(2,4) = 0;
R(3,1) = x*z*(1-c) - y*s;
R(3,2) = y*z*(1-c)+x*s;
R(3,3) = z2 + (x2+y2)*c;
% R(3,4) = 0;
% R(4,1) = 0;
% R(4,2) = 0;
% R(4,3) = 0;
R(4,4) = 1;