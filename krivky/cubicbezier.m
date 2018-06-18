function [x,y,baze] = cubicbezier(P0,P1,P2,P3,t)

% vypocita souradnice bodu na Bezierove kubice
% t je sloupcovy vektor "casu", t z [0,1]
% vystup jsou dva sloupcove vektory souradnic [x(t),y(t)]
%
% Pn.....ridici body - radkove vektory dvou souradnic
%
% Priklady:
% [x,y] = cubicbezier([0,0],[1,3],[3,4],[8,2],(0:0.05:1).')
% [~,~,baze] = cubicbezier([0,0],[1,3],[3,4],[8,2],linspace(0,1,101).')

% (c) 2008-2012, Pavel Rajmic, UTKO FEKT VUT v Brne

%% priprava matic
n = length(t);
% "casova" matice
T = timevector(t,3);

% matice geom. podminek (ridici body)
G = [P0;P1;P2;P3];  

% definice bazove matice
M = cubicbezierbasematrix();

%% vypocet
baze = T*M;
pointsonbezier = baze*G;
x = pointsonbezier(:,1);
y = pointsonbezier(:,2);