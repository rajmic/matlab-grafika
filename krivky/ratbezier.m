function Qrat = ratbezier(P,w,t)

% vypocita souradnice bodu na racionalni Bezierove krivce
%
% P.......ridici body (jako radkove vektory)
% w.......jejich vahy (sloupcovy vektor)
% t....... je sloupcovy vektor "casu", t z [0,1]
% vystup je matice se souradnicemi krivky v prislusnych casech
%
% Priklady:
% [Q] = ratbezier([0,0; 1,3; 3,4; 8,2],[1 2 1 0.3]',(0:0.05:1).')

% (c) 2013, Pavel Rajmic, UTKO FEKT VUT v Brne

Q = bezier([P w],t);
Qrat = hom2cart(Q',1)';