% demonstrace vyzarovaciho zakona v Matlabu

close all
clc

%% nastaveni parametru
lambda = 1:10:1600; %vlnove delky (nm)
teplota = 3000:1000:6000; %teploty (K)

%% vypocet
psd = cerne_teleso(teplota, lambda)

%% vykresleni
figure
plot(lambda,psd)
legend(num2str(teplota')) %('T1','T2','T3',1)  
title('Zareni cerneho telesa')
xlabel('\lambda [nm]')
ylabel('spektralni intenzita')
% ylabel('u(\lambda) [kJ/nm]')

% hranice viditelneho spektra
%390--720 nm
mm = max(max(psd));
hold on
plot([390 390],[0, mm],'k--')
plot([720 720],[0, mm],'k--')

axis tight
