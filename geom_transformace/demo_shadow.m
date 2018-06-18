%function [ ] = demo_shadow

%Provede transformaci vstupn� matice sou�adnic tak, aby vznikl jejich st�n.
%
%P��klad pou�it�: Vykreslen� st�nu p�smena R (viz data_pismenko) do figury
%s handle h=1 �ervenou barvou:
% body = data_pismenko();
% demo_shadow(1,body,'r')

% (c) 2009 Barto�
% (c) 2010, 2013 drobn� �pravy Rajmic

%% Vyber objektu
body = data_pismenko();
% body = data_domecek;

%%
close all
home

%% Vykreseleni originalu
body = cart2hom(body); % prevod na homogenni
h = figure;
plot_several_bezier_cubics(h, body', 'b');

%% Transforma�n� matice pro vytvo�eni st�nu
Atran  = translating_matrix(-2, -2, 0)
Ascale  = scaling_matrix([1 1.5 1 1])
Ashear  = shearing_matrix(0.85,'xy')
Atran2 = translating_matrix(2, 2, 0)
Atran3  = translating_matrix(1, 0.5, 0)

%vypocteni slozene transformacni matice
Ascale * Ashear % ukazka nekomutativity
Ashear * Ascale % ukazka nekomutativity
Atotal = Atran3 * Atran2 * Ashear * Ascale * Atran
body_new = Atotal*body;
body_new = hom2cart(body_new); % u afinnich transformaci prikaz neovlivni vysledek

%% Vykreseleni po transformaci
figure(h)
hold on
plot_several_bezier_cubics(h, body_new', 'r');
title('Puvodni a transformovany objekt')