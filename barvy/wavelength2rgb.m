function [R, G, B] = wavelength2rgb(WL)

% Prevadi vlnovou delku na RGB hodnoty na zaklade zjednoduseneho
% modelu lidskeho videni (tri druhy cipku)
%
% WL........vlnova delka; muze byt i vektor hodnot, potom R, G, B jsou sloupce
% R, G, B...skalovano 0-255
%
% Inspirovano temito zdroji:
% http://scslin.blogspot.sk/2011/12/matlab-calculate-rbg-of-visible.html
% http://www.midnightkite.com/index.aspx?AID=0&URL=ColorScience
% http://www.physics.sfasu.edu/astro/color/spectra.html

% 2013 Pavel Rajmic


if any(WL<380 | WL>780)
    error('Mimo rozsah 380 az 780 nm')
end

lWL = length(WL);

% allocating memory
R = zeros(1, lWL);
G = zeros(1, lWL);
B = zeros(1, lWL);

% finding the RGB values for a wavelenght
for cnt = 1:lWL
    wl = WL(cnt);
    
    if (wl>=380 && wl<=440)
        r = -1.*(wl-440)/(440-380);
        g = 0;
        b = 1;
    end
    if (wl>=440 && wl<=490)
        r = 0;
        g = (wl-440)/(490-440);
        b = 1;
    end
    if (wl>=490 && wl<=510)
        r = 0;
        g = 1;
        b = -1.*(wl-510)/(510-490);
    end
    if (wl>=510 && wl<=580)
        r = (wl-510)/(580-510);
        g = 1;
        b = 0;
    end
    if (wl>=580 && wl<=645)
        r = 1;
        g = -1.*(wl-645)/(645-580);
        b = 0;
    end
    if (wl>=645 && wl<=780)
        r = 1;
        g = 0;
        b = 0;
    end
    
    % LET THE INTENSITY SSS FALL OFF NEAR THE VISION LIMITS
    if (wl>700)
        SSS = 0.3+0.7* (780-wl)/(780-700);
    elseif (wl<420)
        SSS = .3+.7*(wl-380)/(420-380);
    else
        SSS = 1;
    end
    
    % filling output
    R(cnt) = r * SSS;
    G(cnt) = g * SSS;
    B(cnt) = b * SSS;
end

% scaling and rounding
R = round(R * 255);
G = round(G * 255);
B = round(B * 255);

% making columns
R = R(:);
G = G(:);
B = B(:);