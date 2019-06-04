% Exemple Disseny de filtre Passa-Baixes
% Especificaci� Banda de pas i atenuada
% Freq��ncies l�mit banda de pas i atenuada
clear, close all
fm=44100; % Freq. Mostratge
fp=5000; % Freq. l�mit de la banda de pas
fa=6000; % Freq. l�mit de la banda atenuada
freq=[fp,fa,fm]; % Vector d'especificaci� de bandes freq�encials

% fp=input('L�mit superior de la banda de pas fp=');
% if isempty(fp), fp=8000; end
% fa=input('L�mit inferior de la banda atenuada fa=');
% if isempty(fa), fa=12000; end
% ap=input('Atenuaci� m�xima la banda de pas fp=');
% if isempty(ap), ap=3; end
% aa=input('Atenuaci� m�nima la banda atenuada fa=');
% if isempty(aa), aa=60; end
% Especificaci� de m�dul
ap=1; % Atenuaci� l�mit a la banda de pas
aa=60; % Atenuaci� l�mit a la banda atenuada
ate=[ap,aa];     % Vector d'especificaci� d'atenuacions
% Disseny del filtre
h=sv_DisFIR_Pbopt(freq,ate);  % C�lcul de la resposta impulsional
% Senyal de prova del filtre de Lx mostres
Lx=1000;
n=0:Lx-1;
F1=(fp/fm)/10;   % Freq��ncia a la banda de pas
F2=(fa/fm)*1.5;   % Freq��ncia a la banda atenuada
x=3*cos(2*pi*F1*n)+5*cos(2*pi*F2*n); % Senyal entrada
y=conv(x,h);   % Senyal sortida filtre
figure   % Representaci� entrada i sortida
subplot(211), plot(x), title('Senyal entrada')
subplot(212), plot(y), title('Senyal sortida')