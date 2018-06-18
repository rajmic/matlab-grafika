function M = scaling_matrix(diagonal)

% vraci matici pro zmenu meritka v 3D homogenních souradnicich
% diagonal.....vektor meritek, porade sx, sy, sz
%
% Napriklad:
% A = scaling_matrix([2 1 .5])

% (c) 2008-2013, Pavel Rajmic, UTKO FEKT VUT v Brne


%% Kontrola, zda je to vektor
% [n,m] = size(diagonal);
if ~isvector(diagonal)
    error('')
end
if length(diagonal) ~= 3
    error('')
end

%% Generování matice
M = diag(diagonal);
M(4,4) = 1;