function [color] = sachovnice_proceduralni (M, N, u, v)
% [color] = sachovnice_proceduralni (M, N, u, v)
% 
% Vrac� barvu v �achovnici, kde color = -1 ... �ern�
%                                     =  1 ... b�l�
% 
% M,N ... po�ty d�lk� �achovnice ve sm�ru u, resp. v.
% u,v ... sou�adnice bodu, ve kter�m chci zjistit barvu, rozsah <0,1>
% p�i�em� "u" ch�peme jako vodorovnou osu a "v" jako osu svislou.
% 
% P�edpokl�d�me, �e �achovnice za��n� v lev�m doln�m rohu �ern�m pol��kem
% (lze jednodu�e zm�nit v k�du).

% (c) 2009 Petr Dole�al
% drobn� �pravy (c) 2009,2010 Pavel Rajmic


% Chceme-li za��nat v lev�m doln�m rohu b�l�m pol��kem, nastav�me
% n�sleduj�c� prom�nnou na 0. P�i jedni�ce tam bude �ern�.
bool_zacni_cernou = 1;

% Vybr�n�m minima o�et��me mezn� situaci, kdy u �i v = 1.0. Kdybychom
% neo�et�ili, do�lo by pro okrajov� pixely k nevhodn�mu p�eklopen� ji� do dal��ho
% d�lku opa�n� barvy.

m = min(floor(u*M), M-1);
n = min(floor((v)*N), N-1);
% n = min(floor((1-v)*N), N-1);

color = (-1)^(m+n+bool_zacni_cernou);