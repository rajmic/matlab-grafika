function T = perspect_project_matrix(z0)

%Vytvo�en� perspektivn� matice T pro st�edov� prom�t�n�.
%Sou�adnice [0,0,z0] jsou pozic� kamery, z0>0; pr�m�tnou je rovina xy.
%
% (c) 2012-2013 Ji�� Kova��k, Pavel Rajmic, UTKO FEKT VUT v Brne


%% osetrujici podminky 
if z0 <= 0
    error('zaporna pozice kamery')
end

%% perspektivni matice
T = [1,    0,        0,  0;...
     0,    1,        0,  0;...
     0,    0,        0,  0;...
     0,    0,       -1/z0,  1];