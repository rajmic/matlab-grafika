% Demo ukazuje subdivision algoritmus Catmull-Clark
% 2019 Matou� Vrb�k, Pavel Rajmic, FEKT VUT v Brn�

% po��t� se vstupem jako s t�lesem, jeho� v�echny strany
% jsou topologicky �ty��heln�ky

close all
clear all

%% definice roh�
P1 = [-1 -1 -1];
P2 = [ 1 -1 -1];
P3 = [ 1  1 -1];
P4 = [-1  1 -1];
P5 = [-1 -1  1];
P6 = [ 1 -1  1];
P7 = [ 1  1  1];
P8 = [-1  1  1];

%% definice stran (body se p�ekr�vaj�)
plBottom = [ P1; P2; P3; P4 ];
plTop =    [ P5; P6; P7; P8];
plLeft=    [ P1; P4; P8; P5];
plRight=   [ P2; P3; P7; P6];
plNear=    [ P1; P2; P6; P5];
plFar=     [ P4; P3; P7; P8];

originalShape = cat(3,plBottom, plTop, plLeft, plRight, plNear, plFar);

%% vykreslen�
patch(plBottom(:,1),plBottom(:,2),plBottom(:,3),'red');
patch(plTop(:,1),plTop(:,2),plTop(:,3),'red');
patch(plLeft(:,1),plLeft(:,2),plLeft(:,3),'red');
patch(plRight(:,1),plRight(:,2),plRight(:,3),'red');
patch(plNear(:,1),plNear(:,2),plNear(:,3),'red');
patch(plFar(:,1),plFar(:,2),plFar(:,3),'red');
camproj('perspective')
view(-27,25)

% close all;


%% postup
% 1) vyd�lit v�echny hrany 2 - z�sk�me nov� body
% 2) p�epo��tat sou�adnice
%   a) bod uprost�ed p�edchoz� st�ny - ze 4 bod� t� st�ny
%   b) bod uprost�ed hrany - ze 6 bod� sousedn�ch st�n
%   c) bod, kter� je s�m p�vodn�m bodem
%       i) soused�-li se 3 st�nami - 7 bod�
%      ii) soused�-li se 4 st�nami - 9 bod�
%     iii) soused�-li s 5 st�nami - 11 bod�
% 3) z t�chto bod� ud�lat nov� st�ny (po��d m�t ulo�en� ty star�)
 
% Pozn.: Toto v�e ud�l� funkce CatmullClarkSubdivide, ale prvn� iterace je
% zde rozepsan� po kroc�ch zvl᚝

%% 1 vyd�lit hrany - nov� body
% jako vstup slou�� st�ny pl(n,m) kde m = 3 (x,y,z) a n je po�et bod�,
% kter�mi je st�na vyty�ena - krychle -> 4

% st�na n bod�, ka�d� bod s ka�d�m - ud�l�me pr�m�r jeho hodnot, ka�d� bod
% d� n nov�ch bod� (hodn� jich je duplicitn�ch) 

% T B L R N F
disp('Prvn� iterace')
tic

newPlanePoints = divideSides(originalShape);

%te� je t�eba vytvo�it nov� plochy - v p��pad� krychle v�dy nov� body
%dostaneme v po�ad� - rozd�len� plocha, dle sch�matu
% 7 8 9
% 4 5 6
% 1 2 3
%tak�e m��eme vytvo�it nov� plochy [1 2 5 4], [2 3 6 5], [4 5 8 7], ....

%ale nejd��ve je p�epo��t�me z p�vodn�ch bod�

%% 2) p�epo�et bod�
% u bodu 5 (uprost�ed plochy) pot�ebuju jen tuto st�nu

% u bod� 2 4 6 8 (uprost�ed strany) pot�ebuju 1 st�nu nav�c - vezmu 2 body ze kter�ch
% vznikl, najdu st�nu, kter� tyto 2 body obsahuje

% u bod� 1 3 7 9 (rohy plochy) pot�ebuju 2 st�ny nav�c
% body p�vodn� - najdu v�echny st�ny, kde tento bod je

newPlanePoints = calculateNewPointsCoordinates(originalShape,newPlanePoints);


%% 3) vytvo�en� nov�ch st�n


% pro �tverec dostanu 4 nov� st�ny pro jednu p�vodn�
% => po�et nov�ch st�n je 6*4

nPlanes = size(originalShape,3);

newShape = zeros(4,3,24);
% 7 8 9
% 4 5 6
% 1 2 3
%nov� st�ny budou [1 2 5 4] [2 3 6 5] [4 5 8 7], [5 6 9 8]

for originalPlane=0:(nPlanes-1)
newShape(:,:,originalPlane*4+1) = [newPlanePoints(1,:,originalPlane+1); newPlanePoints(2,:,originalPlane+1); 
    newPlanePoints(5,:,originalPlane+1) ;newPlanePoints(4,:,originalPlane+1)];
newShape(:,:,originalPlane*4+2) = [newPlanePoints(2,:,originalPlane+1); newPlanePoints(3,:,originalPlane+1); 
    newPlanePoints(6,:,originalPlane+1); newPlanePoints(5,:,originalPlane+1)];
newShape(:,:,originalPlane*4+3) = [newPlanePoints(4,:,originalPlane+1); newPlanePoints(5,:,originalPlane+1); 
    newPlanePoints(8,:,originalPlane+1); newPlanePoints(7,:,originalPlane+1)];
newShape(:,:,originalPlane*4+4) = [newPlanePoints(5,:,originalPlane+1); newPlanePoints(6,:,originalPlane+1); 
    newPlanePoints(9,:,originalPlane+1); newPlanePoints(8,:,originalPlane+1)];
end

%% 4) vykreslit
nNewPlanes = size(newShape,3);

figure()
for i=1:nNewPlanes
   patch(newShape(:,1,i),newShape(:,2,i),newShape(:,3,i),'red');    
end
camproj('perspective')        
view(-27,25)
toc

%% Dal�� iterace
disp('Druh� iterace')
tic
secondIteration = CatmullClarkSubdivide(newShape,true);
toc

disp('T�et� iterace')
tic
thirdIteration = CatmullClarkSubdivide(secondIteration,true);
toc