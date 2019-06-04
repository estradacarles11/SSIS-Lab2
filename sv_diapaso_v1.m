% Autor Sisco Vallverdú, 26-09-2017
% Programa de generació d'un to pur
% Exemple per Senyals i Sistemes
%
% Esborrat de variables, tancament de finestres i neteja finestra ordres
clear, close all, clc
%
%Paràmetres de la sinusoide
A=input('Amplitud de la sinusoide, A=');	 	% Un valor adequat és A=1
if isempty(A), A=1, end   % Valor per defecte
fx=input('Freqüencia, en Hz, del senyal, fx=');	% El diapasó més habitual vibra a 440Hz
if isempty(fx), fx=440, end   % Valor per defecte
phix=input('Fase, en radians, del senyal, phix=');	% El diapasó més habitual vibra a 440Hz
if isempty(phix), phix=-pi/2, end   % Valor per defecte
Ti=input('Instant inicial, en segons, del senyal, Ti=');	% Sol considerar-se Ti=0 
if isempty(Ti), Ti=0, end   % Valor per defecte
Tf=input('Instant final, en segons, del senyal, Tf=');	 % Cal generar un senyal de durada T=Tf-Ti~ 1s
if isempty(Tf), Tf=1.5, end   % Valor per defecte
%
% variables de treball
fm=44100;	% freqüència de mostratge, o nombre de mostres/segon
Tm=1/fm; 	% període de mostratge
Tx=1/fx;    % Període del senyal
t=Ti:Tm:Tf;	% valors de la variable t en que es calcula la funció
x=A*cos(2*pi*fx*t+phix); 	% senyal generat
%
% Escoltem el resultat
sound(x,fm)	% el senyal es podrà escoltar per auriculars o per l’altaveu de l’ordinador

% Representació gràfica d'un segment de tres períodes de senyal amb stem i
% plot
L=ceil(3*Tx*fm);  % Nombre de mostre d'un interval de 3 períodes
subplot(211),     %Divideix la finestra en una quadrícula de 2x1 espais i dibuixa al primer
stem(t(1:L),x(1:L))		% Representació dels L primers valors de senyal
xlabel('t, en segons')		% etiqueta a l’eix d’ordenades
ylabel('x(t)')			% etiqueta a l’eix d’abscisses
title(['Sinusoide de freqüència f_x=',num2str(fx),' Hz'])	% Títol del gràfic
subplot(212),     %Divideix la finestra en una quadrícula de 2x1 espais i dibuixa al segon
plot(t(1:L),x(1:L))		% Representació dels L primers valors de senyal
xlabel('t, en segons')		% etiqueta a l’eix d’ordenades
ylabel('x(t)')			% etiqueta a l’eix d’abscisses

% Guardem el resultat en un fitxer .wav
nom=['sv_so',num2str(fx),'.wav'];   % Nom del fitxer de so
if A>1, x=x/A; end    % Escalem el senyal, si cal, per que no es produeixi saturació
audiowrite(nom,x,fm)   % Exportació del senyal x i la freq. mostratge a un fitxer .wav
