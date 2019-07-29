% Demo ukazuje subdivision algoritmus Catmull-Clark
% 2019 Matouš Vrbík, Pavel Rajmic, FEKT VUT v Brnì

% poèítá se vstupem jako s tìlesem, jehož všechny strany
% jsou topologicky ètyøúhelníky

close all
clear all

%% definice rohù
P1 = [-1 -1 -1];
P2 = [ 1 -1 -1];
P3 = [ 1  1 -1];
P4 = [-1  1 -1];
P5 = [-1 -1  1];
P6 = [ 1 -1  1];
P7 = [ 1  1  1];
P8 = [-1  1  1];

%% definice stran (body se pøekrývají)
plBottom = [ P1; P2; P3; P4 ];
plTop =    [ P5; P6; P7; P8];
plLeft=    [ P1; P4; P8; P5];
plRight=   [ P2; P3; P7; P6];
plNear=    [ P1; P2; P6; P5];
plFar=     [ P4; P3; P7; P8];

originalShape = cat(3,plBottom, plTop, plLeft, plRight, plNear, plFar);

%% vykreslení
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
% 1) vydìlit všechny hrany 2 - získáme nové body
% 2) pøepoèítat souøadnice
%   a) bod uprostøed pøedchozí stìny - ze 4 bodù té stìny
%   b) bod uprostøed hrany - ze 6 bodù sousedních stìn
%   c) bod, který je sám pùvodním bodem
%       i) sousedí-li se 3 stìnami - 7 bodù
%      ii) sousedí-li se 4 stìnami - 9 bodù
%     iii) sousedí-li s 5 stìnami - 11 bodù
% 3) z tìchto bodù udìlat nové stìny (poøád mít uložené ty staré)
 
% Pozn.: Toto vše udìlá funkce CatmullClarkSubdivide, ale první iterace je
% zde rozepsaná po krocích zvláš

%% 1 vydìlit hrany - nové body
% jako vstup slouží stìny pl(n,m) kde m = 3 (x,y,z) a n je poèet bodù,
% kterými je stìna vytyèena - krychle -> 4

% stìna n bodù, každý bod s každým - udìláme prùmìr jeho hodnot, každý bod
% dá n nových bodù (hodnì jich je duplicitních) 

% T B L R N F
disp('První iterace')
tic

newPlanePoints = divideSides(originalShape);

%teï je tøeba vytvoøit nové plochy - v pøípadì krychle vždy nové body
%dostaneme v poøadí - rozdìlená plocha, dle schématu
% 7 8 9
% 4 5 6
% 1 2 3
%takže mùžeme vytvoøit nové plochy [1 2 5 4], [2 3 6 5], [4 5 8 7], ....

%ale nejdøíve je pøepoèítáme z pùvodních bodù

%% 2) pøepoèet bodù
% u bodu 5 (uprostøed plochy) potøebuju jen tuto stìnu

% u bodù 2 4 6 8 (uprostøed strany) potøebuju 1 stìnu navíc - vezmu 2 body ze kterých
% vznikl, najdu stìnu, která tyto 2 body obsahuje

% u bodù 1 3 7 9 (rohy plochy) potøebuju 2 stìny navíc
% body pùvodní - najdu všechny stìny, kde tento bod je

newPlanePoints = calculateNewPointsCoordinates(originalShape,newPlanePoints);


%% 3) vytvoøení nových stìn


% pro ètverec dostanu 4 nové stìny pro jednu pùvodní
% => poèet nových stìn je 6*4

nPlanes = size(originalShape,3);

newShape = zeros(4,3,24);
% 7 8 9
% 4 5 6
% 1 2 3
%nové stìny budou [1 2 5 4] [2 3 6 5] [4 5 8 7], [5 6 9 8]

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

%% Další iterace
disp('Druhá iterace')
tic
secondIteration = CatmullClarkSubdivide(newShape,true);
toc

disp('Tøetí iterace')
tic
thirdIteration = CatmullClarkSubdivide(secondIteration,true);
toc