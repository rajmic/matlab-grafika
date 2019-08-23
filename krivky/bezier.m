function [Q, baze] = bezier(P,t)

% vypocita souradnice bodu na Bezierove kubice
% zakladnim zpusobem, tj. primo, bez pouziti de Casteljau
% t je sloupcovy vektor "casu", t z [0,1]
% vystup jsou dva sloupcove vektory souradnic [x(t),y(t)]
%
% P......ridici body jako radky v matici
% Q......body na Bezierove krivce
% baze...volitelny vystup, bazove vektory, vycislene v case(ch) t
%
% (c) 2013--2019, Pavel Rajmic, UTKO FEKT VUT v Brne

%% priprava matic
n = size(P,1);

% "casova" matice
T = timevector(t,n-1);

% definice bazove matice
M = bezierbasematrix(n-1);

% matice geom. podminek (ridici body)
G = P;

%% vypocet
baze = T*M;
Q = baze*G;