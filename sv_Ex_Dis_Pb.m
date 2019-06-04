% Exemple Disseny de filtre Passa-Baixes
% Especificació Banda de pas i atenuada
% Freqüències límit banda de pas i atenuada
clear, close all
fm=44100; % Freq. Mostratge
fp=5000; % Freq. límit de la banda de pas
fa=6000; % Freq. límit de la banda atenuada
freq=[fp,fa,fm]; % Vector d'especificació de bandes freqüencials

% fp=input('Límit superior de la banda de pas fp=');
% if isempty(fp), fp=8000; end
% fa=input('Límit inferior de la banda atenuada fa=');
% if isempty(fa), fa=12000; end
% ap=input('Atenuació màxima la banda de pas fp=');
% if isempty(ap), ap=3; end
% aa=input('Atenuació mínima la banda atenuada fa=');
% if isempty(aa), aa=60; end
% Especificació de mòdul
ap=1; % Atenuació límit a la banda de pas
aa=60; % Atenuació límit a la banda atenuada
ate=[ap,aa];     % Vector d'especificació d'atenuacions
% Disseny del filtre
h=sv_DisFIR_Pbopt(freq,ate);  % Cálcul de la resposta impulsional
% Senyal de prova del filtre de Lx mostres
Lx=1000;
n=0:Lx-1;
F1=(fp/fm)/10;   % Freqüència a la banda de pas
F2=(fa/fm)*1.5;   % Freqüència a la banda atenuada
x=3*cos(2*pi*F1*n)+5*cos(2*pi*F2*n); % Senyal entrada
y=conv(x,h);   % Senyal sortida filtre
figure   % Representació entrada i sortida
subplot(211), plot(x), title('Senyal entrada')
subplot(212), plot(y), title('Senyal sortida')