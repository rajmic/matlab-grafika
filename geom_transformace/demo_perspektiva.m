% Ukazka zobrazeni 3D objektu v projektivni transformaci
% (stredovou ci rovnobeznou perspektivou)

% (c) 2012-2013 Jiri Kovarik, Pavel Rajmic, UTKO FEKT VUT v Brne

close all
clc


%% nacteni dat objektu
body = data_domecek;

%% zobrazeni domecku bez perspektivy
h = figure;
plot_several_bezier_cubics_3D(h, body', 'b');
title('Zobrazeni bez perspektivy')

%% vytvoreni projektivnich matic
Tproj = orthogonal_project_matrix(20);

%% prevod bodu sceny
bodyHom = cart2hom(body);
body_new = Tproj*bodyHom;
body_new = hom2cart(body_new,'shrink');

%% zobrazeni domecku s perspektivou
h = figure;
plot_several_bezier_cubics_3D(h, body_new', 'b');
title('Zobrazeni s rovnobeznou perspektivou')







%% natoceni objektu
bodyHom_trans = translating_matrix(-2, -2, 0) * bodyHom;
bodyHom_trans = rotating_matrix(90,[0 1 0]) * bodyHom_trans;
body = hom2cart(bodyHom_trans,'shrink');

%% zobrazeni domecku bez perspektivy
h = figure;
plot_several_bezier_cubics_3D(h, body', 'b');
title('Zobrazeni bez perspektivy')
grid on

%% vytvoreni projektivnich matic
%Tproj = perspect_project_matrix(0,0,20);
Tproj = orthogonal_project_matrix(20);

%% prevod bodu sceny
bodyHom = cart2hom(body);
body_new = Tproj*bodyHom;
body_new = hom2cart(body_new,'shrink');

%% zobrazeni domecku s perspektivou
h = figure;
plot_several_bezier_cubics_3D(h, body_new', 'b');
title('Zobrazeni s rovnobeznou perspektivou')








%% rotace
bodyHom_trans = rotating_matrix(45,[1 1 1]) * bodyHom;
body = hom2cart(bodyHom_trans,'shrink');

%% zobrazeni domecku bez perspektivy
h = figure;
plot_several_bezier_cubics_3D(h, body', 'b');
title('Zobrazeni bez perspektivy')
grid on

%% vytvoreni projektivnich matic
Tproj = orthogonal_project_matrix(20);

%% prevod bodu sceny
bodyHom = cart2hom(body);
body_new = Tproj*bodyHom;
body_new = hom2cart(body_new,'shrink');

%% zobrazeni domecku s perspektivou
h = figure;
plot_several_bezier_cubics_3D(h, body_new', 'b');
title('Zobrazeni s rovnobeznou perspektivou')





%% nacteni dat objektu
body = data_domecek;

%% posun dozadu
bodyHom = cart2hom(body);
bodyHom_trans = translating_matrix(0, 0, -7) * bodyHom;
body_trans = hom2cart(bodyHom_trans,'shrink');

%% zobrazeni domecku bez perspektivy
h = figure;
plot_several_bezier_cubics_3D(h, body_trans', 'b');
title('Zobrazeni bez perspektivy')

%% vytvoreni projektivni matice
Tproj = perspect_project_matrix(10);

%% prevod bodu sceny
bodyHom = cart2hom(body_trans);
body_new = Tproj*bodyHom;
body_new = hom2cart(body_new,'shrink');

%% zobrazeni domecku s perspektivou
h = figure;
plot_several_bezier_cubics_3D(h, body_new', 'b');
title('Zobrazeni se stredovou perspektivou')
set(gca,'ZLim',[0 0+eps])
