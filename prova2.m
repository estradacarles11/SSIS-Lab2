clear all;
clc;
disp('')
disp( 'MODULACION DE AMPLITUD (AM) EN MATLAB' )

N = input( 'Digite el Numero de muestas:  ' )                  
fs = input ( 'Digite la frecuencia de muestreo:  ')             
fc = input('Digite la frecuencia de la portadora:  ')                    
fm = input('Digite la frecuencia de la moduladora (informacion):  ')      
Ec = input('Digite el valor de la amplitud de la portadora:  ')                      
Em = input('Digite el valor de la amplitud de la Moduladora (informacion):  ')     
t = (0:N-1)/fs;

%      Modulacion de Amplitud

Eca = Ec*cos(2*pi*fc*t);
Emoduladora = Ec*cos(2*pi*fm*t);
A = Ec + Emoduladora;        % Creacion de la envolvente
m = A.*[cos(2*pi*fc*t)];     % Modulacion
Mf = 2/N*abs(fft(m,N));      % Espectro mediante fft
f = fs*(0:N/2)/N;            % Analisis del espectro

close all;

figure('Name','Portadora, Modulada, Amplitud modulada');
subplot(2,2,1); plot(t(1:N/10),Emoduladora(1:N/10));
title('Señal moduladora'), grid on, 
xlabel('Tiempo'), ylabel('Señal mopduladora(t)');

subplot(2,2,2); plot(t(1:N/10),Eca(1:N/10));
title('Señal Portadora'), grid on, xlabel('Tiempo'),
ylabel('Señal Portadora(t)');

subplot(2,2,3:4); plot(t(1:N/10),m(1:N/10),t(1:N/10),A(1:N/10),'r',t(1:N/10),-A(1:N/10),'r');
title('Señal modulada  AM' ), grid on, 
xlabel('Tiempo'), ylabel('Señal modulada(t)');