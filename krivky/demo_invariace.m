function demo_invariace

% DEMO ukazující pøípad invariance a neinvariance vùèi transformaci, ve 2D
% (c) 2010-2012 Štefek, Rajmic, VUT v Brnì

close all
clc

% set( 0, 'DefaultAxesFontName', 'Arial CE');



% ---------------------------------------------------
% invariance kružnice vùèi posunutí
stred = [1 1]; %stred
r = 3; %polomer
posun = [-2 5]; %posunuti
pocetBodu = 40; %pocet bodu pri vykreslovani

% vykresleni ridicich bodu
figure();
plot(stred(1),stred(2),'b+','MarkerSize',10, 'LineWidth', 3);
hold on
axis equal

% body podel kruznice
[tx,ty] = circle(stred,r,pocetBodu);
plot(tx,ty,'bo');
 
% transformace ridiciho bodu
stredTrans = stred + posun;
plot(stredTrans(1),stredTrans(2),'r+','MarkerSize',10, 'LineWidth', 3);

% vypocitani bodu podel kruznice z transformovanych ridicich bodu
[ttx,tty] = circle(stredTrans,r,pocetBodu);
plot(ttx,tty,'r.');

% transformace pro kazdy bod
tkonMnoz = [tx'+posun(1); ty'+posun(2)];

%   vykresleni
plot(tkonMnoz(1,:)',tkonMnoz(2,:)','ro');
grid on;
title('Invariance kruznice vuci posunuti')
xlabel('x [-]  \rightarrow');
ylabel('y [-]  \rightarrow');
grid on
legend('Ridici body','Body vypoctene z ridicich bodu','Ridici body po transformaci',...
    'Body vypoctene z novych ridicich bodu', 'Body vypoctene jednotlivym posunem')




%---------------------------------------------------
% %% invariance Bézierovky vùèi posunutí

p1 =[-2 1]; %ridici body
p2 =[2 4]; %ridici body
p3 = [4 1]; %ridici body
p4 = [6 -5]; %ridici body
posun = [1 5]; %posunuti
pocetBodu=13;

% vykresleni ridicich bodu
figure();
plot([p1(1) p2(1) p3(1) p4(1)],[p1(2) p2(2) p3(2) p4(2)],'b+','MarkerSize',10, 'LineWidth', 3);
hold on

% body podel krivky
t = linspace(0,1,pocetBodu);
[tx,ty] = cubicbezier(p1,p2,p3,p4,t);
plot(tx,ty,'bo');

% transformace ridicich bodu
p1trans = p1 + posun;
p2trans = p2 + posun;
p3trans = p3 + posun;
p4trans = p4 + posun;

plot([p1trans(1) p2trans(1) p3trans(1) p4trans(1)], [p1trans(2) p2trans(2) p3trans(2) p4trans(2)],...
        'r+', 'MarkerSize', 10, 'LineWidth', 3);

% vypocitani bodu krivky z transformovanych ridicich bodu
[ttx,tty] = cubicbezier(p1trans,p2trans,p3trans,p4trans,t);
plot(ttx,tty,'r.');

% transformace pro kazdy bod
tkonMnoz = [tx'+posun(1); ty'+posun(2)];
plot(tkonMnoz(1,:),tkonMnoz(2,:),'ro');
% grid on;
title('Invariance Bezierovy krivky vuci posunuti')
xlabel('x [-]  \rightarrow');
ylabel('y [-]  \rightarrow');
grid on
legend('Ridici body','Body vypoctene z ridicich bodu','Ridici body po transformaci',...
    'Body vypoctene z novych ridicich bodu', 'Body vypoctene jednotlivym posunem')




% ---------------------------------------------------
%% invariance úseèky vùèi rotaci
p1 =[1 1]; %koncove body
p2 =[2 4]; %koncove body
uhel = pi/4; %rotace
pocetBodu=13; % pocet bodu pri vykreslovani

% vykresleni ridicich bodu
figure();
plot([p1(1) p2(1)],[p1(2) p2(2)],'b+','MarkerSize',10, 'LineWidth', 3);
hold on;

% body podel usecky
ix=linspace(p1(1),p2(1),pocetBodu);
iy=linspace(p1(2),p2(2),pocetBodu);
plot(ix,iy,'bo');

% transformace ridicich bodu
rot_matrix = [cos(uhel) -sin(uhel); sin(uhel) cos(uhel)];
p1trans = p1 * rot_matrix;
p2trans = p2 * rot_matrix;
    
% vykresleni tranformovanych ridicich bodu
plot([p1trans(1) p2trans(1)],[p1trans(2) p2trans(2)], 'r+', 'MarkerSize', 10, 'LineWidth', 3);
    
% vytvoreni bodu primky z transformovanych ridicich bodu
itrx=linspace(p1trans(1),p2trans(1),pocetBodu);
itry=linspace(p1trans(2),p2trans(2),pocetBodu);
plot(itrx,itry,'r.');
    
% transformace pro kazdy bod
tkonMnoz=([ix; iy]'* rot_matrix)';
plot(tkonMnoz(1,:),tkonMnoz(2,:),'ro');
grid on;
title('Invariance usecky vuci rotaci')
xlabel('x [-]  \rightarrow');
ylabel('y [-]  \rightarrow');
grid on
axis equal
legend('Ridici body','Body vypoctene z ridicich bodu','Ridici body po transformaci',...
    'Body vypoctene z novych ridicich bodu', 'Body vypoctene jednotlivym posunem')



%---------------------------------------------------
%% invariance Bézierovky vùèi rotaci

p1 =[-2 1]; %ridici body
p2 =[2 4]; %ridici body
p3 = [4 1]; %ridici body
p4 = [6 -5]; %ridici body
uhel = pi/6; %rotace
pocetBodu=13;

% vykresleni ridicich bodu
figure();
plot([p1(1) p2(1) p3(1) p4(1)],[p1(2) p2(2) p3(2) p4(2)],'b+','MarkerSize',10, 'LineWidth', 3);
hold on

% body podel krivky
t = linspace(0,1,pocetBodu);
[tx,ty] = cubicbezier(p1,p2,p3,p4,t);
plot(tx,ty,'bo');

% transformace ridicich bodu
rot_matrix = [cos(uhel) -sin(uhel); sin(uhel) cos(uhel)];
p1trans = p1 * rot_matrix;
p2trans = p2 * rot_matrix;
p3trans = p3 * rot_matrix;
p4trans = p4 * rot_matrix;

plot([p1trans(1) p2trans(1) p3trans(1) p4trans(1)], [p1trans(2) p2trans(2) p3trans(2) p4trans(2)],...
        'r+', 'MarkerSize', 10, 'LineWidth', 3);

% vypocitani bodu krivky z transformovanych ridicich bodu
[ttx,tty] = cubicbezier(p1trans,p2trans,p3trans,p4trans,t);
plot(ttx,tty,'r.');

% transformace pro kazdy bod
tkonMnoz = ([tx ty] * rot_matrix)';
plot(tkonMnoz(1,:),tkonMnoz(2,:),'ro');
% grid on;
title('Invariance Bezierovy krivky vuci rotaci')
xlabel('x [-]  \rightarrow');
ylabel('y [-]  \rightarrow');
grid on
legend('Ridici body','Body vypoctene z ridicich bodu','Ridici body po transformaci',...
    'Body vypoctene z novych ridicich bodu', 'Body vypoctene jednotlivym posunem')


%---------------------------------------------------
%% NEinvariance Bézierovky vùèi nelinearni transformaci
% Transformace je v tomto pripade nelinearni zobrazeni x(t) > x(t^mocnina)

p1 =[2 1]; %ridici body
p2 =[2 4]; %ridici body
p3 = [4 1]; %ridici body
p4 = [6 -5]; %ridici body
mocnina = 1.5;
pocetBodu=13;

% vykresleni ridicich bodu
figure();
plot([p1(1) p2(1) p3(1) p4(1)],[p1(2) p2(2) p3(2) p4(2)],'b+','MarkerSize',10, 'LineWidth', 3);
hold on

% body podel krivky
t = linspace(0,1,pocetBodu);
[tx,ty] = cubicbezier(p1,p2,p3,p4,t);
plot(tx,ty,'bo');

% transformace ridicich bodu
p1trans = p1;
p2trans = p2;
p3trans = p3;
p4trans = p4;
p1trans(1) = p1(1)^mocnina;
p2trans(1) = p2(1)^mocnina;
p3trans(1) = p3(1)^mocnina;
p4trans(1) = p4(1)^mocnina;
plot([p1trans(1) p2trans(1) p3trans(1) p4trans(1)], [p1trans(2) p2trans(2) p3trans(2) p4trans(2)],...
        'r+', 'MarkerSize', 10, 'LineWidth', 3);
    
% vypocitani bodu krivky z transformovanych ridicich bodu
[ttx,tty] = cubicbezier(p1trans,p2trans,p3trans,p4trans,t);
plot(ttx,tty,'r.');

% transformace pro kazdy bod
tkonMnoz = ([tx.^mocnina ty])';
plot(tkonMnoz(1,:),tkonMnoz(2,:),'ro');
% grid on;
title('Neinvariance Bezierovy krivky vuci mocninne transformaci')
xlabel('x [-]  \rightarrow');
ylabel('y [-]  \rightarrow');
grid on
legend('Ridici body','Body vypoctene z ridicich bodu','Ridici body po transformaci',...
    'Body vypoctene z novych ridicich bodu', 'Body vypoctene jednotlivym posunem')

