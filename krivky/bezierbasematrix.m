function M = bezierbasematrix(n)
% Funkce vrac� b�zovou matici M pro B�zierovu k�ivku n-t�ho ��du

% (c) 2013 Martin �ulc, Pavel Rajmic, VUT v Brn�


M = zeros(n+1,n+1);  %alokace pameti

for l = 1:(n+1) %pres vsechny radky
    for k = l:(n+1) %pouze sloupce od diagonaly (vcetne) a dal
        if (k <= n+2-l) %pouze nenulove prvky
            M(l,k) = (-1)^(n-l-k)... %vlastne (-1)^(n-l-k+2), ale dvojka neovlivni znamenko
            * factorial(n)/(factorial(k-1)*factorial(n-l-k+2)*factorial(l-1));
            M(k,l) = M(l,k); %doplneni symetrickeho prvku
        end
    end
end

%jeste by se asi dalo vyuzit symetrie Pascalova trojuhelnika, ale to zde
%implementovano neni a znatelne zrychleni by to asi prineslo pouze pro
%vysoke rady 'n'