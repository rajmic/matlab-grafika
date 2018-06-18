%ukazka pro porovnani rucniho vypoctu waveletove transformace s konvolucnim
%pristupem

x = [56 40 8 24 48 48 40 6]
h = [1,1]/2 % prumer
conv(x,h)
g=[-1,1] % rozdil
conv(x,g)