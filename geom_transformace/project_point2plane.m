function [Pproj, ProjMtx] = project_point2plane(P,plane_gen,offset,vec_direct)

% Vypocita souradnice bodu po projekci na rovinu v 3D-prostoru
% (jako kdyz bod vrhne stin na plochu)
%
% P .......... souradnice bodu, ktery se ma promitnout
%              P ma rozmer 3xn, kde n je pocet bodu, serazenych do sloupcu
% plane_gen... matice 3x2, ktera jako sve dva sloupce obsahuje linearne
%              nezavisle generatory projekcni plochy (cilovy prostor)
%              tedy rovina prochazi pocatkem
% offset...... skalar, ktery definuje souradnici 'z' projekcni roviny pokud x=y=0
% vec_direct...vektor 3x1 smeru promitani; pokud neni pritomen, pocita se
%              kolma (ortogonalni) projekce
%
% Pproj........souradnice promitnutych bodu
% ProjMtx......prislusna projekcni matice
%
%
% Varianty:
% project_point2plane(P,A,posun)   vypocita ortogonalni (kolmou) projekci 'P'
%                                  na rovinu urcenou 'A' a 'posun'
% project_point2plane(P,A,posun,u) vypocita sikmou projekci bodu 'P'
%                                  na rovinu urcenou 'A'
%
%
% Priklad:
% Pp = project_point2plane([1 5 3]', [[1 0 0]' [0 1 0]'], -5, [3 2 1]')
%
% [Pproj, ProjMtx] = ...
%      project_point2plane([[1 5 3]' [2 2 4]'], [[1 0 0]' [0 1 0]'], 0, [1 8 4]')

% (c) 2012 Pavel Rajmic, Vysoke uceni technicke v Brne
% posledni revize 12.4.2012


%% Kontrola
if nargin < 3
    error('Malo vstupnich parametru!')
end
if nargin > 4
    error('Prilis mnoho vstupnich parametru!')
end

if size(P,1) ~= 3
    error('')
end

if size(plane_gen,1) ~= 3
    error('')
end
if size(plane_gen,2) ~= 2
    error('')
end

if ~isscalar(offset)
    error('')
end

if nargin == 4
    if ~isvector(vec_direct)
        error('')
    end
    if length(vec_direct) ~= 3
        error('')
    end
    vec_direct = vec_direct(:);
end

%% Vypocet
A = plane_gen;

%nulovy prostor projekce
if nargin < 3 %pokud je zvolena ortogonalni projekce
    B = A;
else %sikma
    B = (null(vec_direct'));
end

%posunuti bodu o offset
Ptranslated = P;
Ptranslated(3,:) = Ptranslated(3,:) - offset;

%projekce
ProjMtx = A*inv(B'*A)*B';
Ptranslatedproj = ProjMtx * Ptranslated;

%posusuti zpet
Pproj = Ptranslatedproj;
Pproj(3,:) = Pproj(3,:) + offset;