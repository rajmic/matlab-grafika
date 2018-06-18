function T = perspect_project_matrix(z0)

%Vytvoøení perspektivní matice T pro støedové promítání.
%Souøadnice [0,0,z0] jsou pozicí kamery, z0>0; prùmìtnou je rovina xy.
%
% (c) 2012-2013 Jiøí Kovaøík, Pavel Rajmic, UTKO FEKT VUT v Brne


%% osetrujici podminky 
if z0 <= 0
    error('zaporna pozice kamery')
end

%% perspektivni matice
T = [1,    0,        0,  0;...
     0,    1,        0,  0;...
     0,    0,        0,  0;...
     0,    0,       -1/z0,  1];