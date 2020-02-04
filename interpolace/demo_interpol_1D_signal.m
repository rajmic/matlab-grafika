% Demo ukazuje interpolaci 1D signalu ruznymi metodami

% (c) 2020 Lubomir Skvarenina, Pavel Rajmic, VUT v Brne

%% Cistka
clear all;
close all;
clc;

%% Nastaveni
V = [145 140    80   120   104   116   133   141    55 80  110]; %hodnoty k interpolaci
X = 0:length(V)-1; % jejich indexy
dx = 0.001; % jemnost interpolantu
Xq = 0:dx:length(V)-1;
start_index = 2; %hranice vykresleni
stop_index = 9;
 
%% Vypocet
F1 = griddedInterpolant(X,V,'nearest');
Vq1 = F1(Xq());
F2 = griddedInterpolant(X,V,'linear');
Vq2 = F2(Xq);
F3 = griddedInterpolant(X,V,'cubic');
Vq3 = F3(Xq);

%% Vykresleni
f1 = figure('name','Jednorozmerna interpolace','NumberTitle','off');
plot(Xq,Vq1,'-k',Xq,Vq2,'-b',Xq,Vq3,'-r') %,...
            %'MarkerFaceColor',[1 1 0],'MarkerEdgeColor',[0 0 0],'LineWidth',1)
hold on
stem(X,V,'filled')
axis([start_index,stop_index,50,150])
legend('Nejbl. soused', 'Linearni','Kubicka','Interp. hodnoty'); %,'Location','EastOutside');
grid off;
% xlabel('x')
% ylabel('f(x)')