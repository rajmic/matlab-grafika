function demo_prevod_homog_na_kartezske
% DEMO prezentujici prevod z homogennich souradnic do kartezskych, ve 2D

% (c) 2012, Pavel Rajmic, UTKO FEKT VUT v Brne

%% sit bodu
% definice intervalu
xlow = -2;
xhigh = 2;
xstep = 1;
ylow = -1;
yhigh = 2;
ystep = 1;
wlow = 0.5;
whigh = 1.5;
wstep = 0.5;
%ekvidistantne:
x = xlow:xstep:xhigh;
y = ylow:ystep:yhigh; %-1:1:2; %-2:1:2;
w = wlow:wstep:whigh; %.5:0.5:1.5; %[-2, -1, 1:3]; %-2:1:2;
%nahodne:
% xpocet = 5;
% ypocet = 4;
% wpocet = 3;
% x = xlow + (xhigh-xlow).* rand(1,xpocet);
% y = ylow + (yhigh-ylow).* rand(1,ypocet);
% w = wlow + (whigh-wlow).* rand(1,wpocet);

% generovani site
[X,Y,W] = ndgrid(x,y,w);

%% Pocitani kartezskych z homogennich a vykresleni
Xcart = X ./ W; % po slozkach
Ycart = Y ./ W; % po slozkach
% Wcart = ones(size(W)); %podily nemusim pocitat, jsou to jednicky

f = figure;
% axis tight
% hold on
for cntx = 1:length(x)
    for cnty = 1:length(y)
        for cntw = 1:length(w)
           plot3( X(cntx,cnty,cntw), Y(cntx,cnty,cntw), W(cntx,cnty,cntw), 'rx' )
%             hold on
%             plot3( Xcart(cntx,cnty,cntw), Ycart(cntx,cnty,cntw), Wcart(cntx,cnty,cntw), 'bo' )
            rozdil_vektorX = Xcart(cntx,cnty,cntw)-X(cntx,cnty,cntw);
            rozdil_vektorY = Ycart(cntx,cnty,cntw)-Y(cntx,cnty,cntw);
            rozdil_vektorW = 1-W(cntx,cnty,cntw);
            h = quiver3(X(cntx,cnty,cntw), Y(cntx,cnty,cntw), W(cntx,cnty,cntw), rozdil_vektorX, rozdil_vektorY, rozdil_vektorW, 0);
            set(h,'Color',[0 0 1])
            hold on
        end
    end
end

grid on
% axis equal
axis tight

%% Vykresleni os
% x
xlabel('x')
minx = min(min(min(min(Xcart))),min(x));
maxx = max(max(max(max(Xcart))),max(x));
h = plot3([minx,maxx],[0,0],[0,0],'k');
% h = plot3([x(1),x(end)],[0,0],[0,0],'k');
set(h,'LineWidth',2)
% y
ylabel('y')
miny = min(min(min(min(Ycart))),min(y));
maxy = max(max(max(max(Ycart))),max(y));
h = plot3([0,0],[miny,maxy],[0,0],'k');
set(h,'LineWidth',2)
% w
zlabel('w')
minw = min(w);
maxw = max(w);
h = plot3([0,0],[0,0],[0,maxw],'k');
set(h,'LineWidth',2)
%upraveni rozsahu
set(gca,'ZLim',[0, max(max(w),1)])

%% Vykresleni roviny w=1
[Mx,My] = meshgrid([minx maxx],[miny maxy]);
mesh(Mx, My, ones(2,2), 'FaceColor', 'green', 'EdgeColor', 'none');
if ~isoctave
    alpha(0.2)
end
