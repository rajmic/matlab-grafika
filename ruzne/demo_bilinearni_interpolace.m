%Demonstruje bilinearni interpolaci
%Zejmena ukazuje, ze vznika kvadraticka plocha; pouze v kolmych smerech
%jsou vzdycky usecky

% 2013-14 Pavel Rajmic, VUT v Brne

% inspirovano zde: http://en.wikipedia.org/wiki/File:Bilininterp.png

X = [0 1];
Y = [0 1];

[Xcoarse, Ycoarse] = meshgrid(X,Y);
DataCoarse = [ 197 0; 180 255];
[Xfine, Yfine] = meshgrid(linspace(0,1,50), linspace(0,1,50));

DataBilinearFine = interp2(Xcoarse, Ycoarse, DataCoarse, Xfine, Yfine, 'linear');

figure
stem3(X(1), Y(1), DataCoarse(1,1), 'fill')
hold on
stem3(X(2), Y(1), DataCoarse(1,2), 'fill')
stem3(X(1), Y(2), DataCoarse(2,1), 'fill')
stem3(X(2), Y(2), DataCoarse(2,2), 'fill')
surf(Xfine, Yfine, DataBilinearFine); 
colormap(jet);
if ~isoctave
    shading flat; 
    alpha(0.75)
end

axis tight

figure
imshow(DataBilinearFine, [min(min(DataBilinearFine)), max(max(DataBilinearFine))])
axis image 
