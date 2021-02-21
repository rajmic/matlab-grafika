% DEMO: Jakoby orotuje kosinusovku kolem pocatku, coz vytvori kalich

% (c) 2021 Pavel Rajmic, UTKO FEKT VUT v Brne

close all

z = pi:pi/8:2*pi; % jemnost vzorkovani krivky
r = 1.5 + cos(z); % vytvoreni hodnot polomeru na krivce (jako funkce r(z))
[X,Y,Z] = cylinder(r,20);  % vygenerovani souradnic site

h = mesh(X,Y,Z);  % vykresleni site
set(h,'EdgeColor',[0 0 0], 'FaceColor','none');
xlabel('x')
ylabel('y')
zlabel('z')
% view(40,15)
% axis tight

hold on

h = plot3(X(:,1),Y(:,1),Z(:,1));
set(h,'LineWidth',3,'Color',[0.8500 0.3250 0.0980]);