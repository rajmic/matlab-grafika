function R = rotating_matrix(uhel,osa)

%Vytvo�� matici R, kter� reprezentuje rotaci bodu kolem osy, ktera je
%zadana vektorem
%
%P��klady pou�it�:
%Matice rotace kolem osy X o �hel 30�
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

% (c) 2009 Barto�
% (c) 2010, 2016 drobn� �pravy Rajmic

%%
%Ov��en�, zda je spr�vn� zadan� osa rotace.
max = norm(osa);
if (max < eps)
   error('Osa ot��en� nesm� m�t nulovou velikost!');
end

%Znormov�n� osy rotace k hodnot� 1.
osa = osa/max;
%Na�ten� vektoru os do prom�nn�ch.
x = osa(1);
y = osa(2);
z = osa(3);
%Pomocn� v�po�ty.
x2 = x^2;
y2 = y^2;
z2 = z^2;
c = cos((pi/180)*uhel);
s = sin((pi/180)*uhel);
%Alokace matice 4x4.
R = zeros(4,4);
%Napln�n� t�to matice hodnotami.
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