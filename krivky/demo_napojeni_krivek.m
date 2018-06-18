% DEMO - napojení køivek (konkrétnì dvou Bézierových kubik)

close all
t = (0:0.005:1)';

% souradnice prvni krivky - napevno
P0 = [0,0];
P1 = [1,3];
P2 = [3,4];
P3 = [8,2];

%% C^1-napojeni:
Q0 = [8,2];
Q1 = [13,0];
Q2 = [0,10];
Q3 = [3,13];
[x,y,alpha,dalpha] = plot2cubicbeziers(P0,P1,P2,P3,Q0,Q1,Q2,Q3,t);
set(gcf,'Name','C^1 napojeni','NumberTitle','off')

%% G^1-napojeni:
% Q1 = [9,2-2/5];
Q1 = [10.5,1];
[x,y,alpha,dalpha] = plot2cubicbeziers(P0,P1,P2,P3,Q0,Q1,Q2,Q3,t);
set(gcf,'Name','G^1 napojeni','NumberTitle','off')

%% C^0-napojeni:
Q1 = [11,3];
[x,y,alpha,dalpha] = plot2cubicbeziers(P0,P1,P2,P3,Q0,Q1,Q2,Q3,t);
set(gcf,'Name','C^0 napojeni','NumberTitle','off')
