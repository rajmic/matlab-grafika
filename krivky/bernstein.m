function b = bernstein(k,n,t)

% vrati hodnoty k-teho Bernsteinova polynomu radu n v casovych bodech t

%sloupec
t = t(:);

%podle definice
b = nchoosek(n,k) * (t.^k .* (1-t).^(n-k));

%podle meho propoctu
suma = 0;
for i=0:(n-k)
    suma = suma + (-1)^i * nchoosek(n-k,i) * nchoosek(n,k) * t.^(i+k);
end

%rozdil
rozdil = b-suma