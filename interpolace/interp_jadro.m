function y = interp_jadro(x, type, param)
% Vycisli interpolacni jadro zvoleneho druhu v bodech x
%
% type....'neigh'....metoda nejblizsiho souseda
%         'linear'...linearni
%         'quad'.....kvadraticka
%         'cubic'....kubicka
%         'sinc'.....sinc (sinus cardinalis)
%
% param...optional parameter (scalar)

% (c) 2020 Lubomir Skvarenina, Pavel Rajmic, VUT v Brne

if nargin < 3
    a = -1/2;
else
    a = param;
end
    
y = zeros(size(x));

switch type
    case 'neigh'    
        y( abs(x) <= 1/2 ) = 1;
    case 'linear'
        y( 0<=x & x<1 ) = 1 - x( 0<=x & x<1 );
        y( -1<x & x<0 ) = 1 + x( -1<x & x<0 );
    case 'cubic' %pouziva dodatecny parametr
        condition = ( abs(x)<1 );
        y( condition ) = (a+2)*abs(x(condition)).^3 - (a+3)*abs(x(condition)).^2 + 1;
        condition = ( 1<=abs(x) & abs(x)<2 );
        y( condition ) = a*abs(x(condition)).^3 - 5*a*abs(x(condition)).^2 + 8*a*abs(x(condition)) - 4*a;
    case 'sinc'
        y = sinc(x);
end

end