%% NEinvariance Bezierovky vuci stredovemu promitani

p1 = [2 4 -6]; %ridici body
p2 = [2 3 -7]; %ridici body
p3 = [4 7 -6]; %ridici body
p4 = [3 3 -5]; %ridici body
pocetBodu=17;

% vykresleni ridicich bodu
figure();
plot3([p1(1) p2(1) p3(1) p4(1)],[p1(2) p2(2) p3(2) p4(2)],[p1(3) p2(3) p3(3) p4(3)],'b+','MarkerSize',10, 'LineWidth', 3);
hold on

% body podel krivky
t = linspace(0,1,pocetBodu);
[tx,ty,tz] = cubicbezier3D(p1,p2,p3,p4,t);
plot3(tx,ty,tz,'bo');

% vytvoreni projektivni matice
Tproj = perspect_project_matrix(10);
%projekce ridicich bodu
p1trans = hom2cart( Tproj * cart2hom(p1)', 'shrink')';
p2trans = hom2cart( Tproj * cart2hom(p2)', 'shrink')';
p3trans = hom2cart( Tproj * cart2hom(p3)', 'shrink')';
p4trans = hom2cart( Tproj * cart2hom(p4)', 'shrink')';
%jejich vykresleni
plot3([p1trans(1) p2trans(1) p3trans(1) p4trans(1)], [p1trans(2) p2trans(2) p3trans(2) p4trans(2)],...
      [p1trans(3) p2trans(3) p3trans(3) p4trans(3)],  'r+', 'MarkerSize', 10, 'LineWidth', 3);

% vypocitani bodu krivky z transformovanych ridicich bodu
[ttx,tty,ttz] = cubicbezier3D(p1trans,p2trans,p3trans,p4trans,t);
plot3(ttx,tty,ttz,'r.');

% transformace pro kazdy bod krivky
tkonMnoz = hom2cart(Tproj * cart2hom([tx ty tz]'), 'shrink');
plot3(tkonMnoz(1,:),tkonMnoz(2,:),tkonMnoz(3,:),'ro');
% grid on;
title('(Ne)invariance Bezierovy krivky vuci stredovemu promitani')
xlabel('x');
ylabel('y');
zlabel('z');
grid on
legend('Ridici body','Body vypoctene z ridicich bodu','Ridici body po transformaci',...
    'Body vypoctene z novych ridicich bodu', 'Body vypoctene jednotlivym posunem')


