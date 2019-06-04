% Autor: Carles Estrada i Adrià Febrer
% Desmodulació d'un arxiu de so multiplexat
%
clear, close all
%
% Lectura de l'arxiu d'àudio
[y,fm]=audioread('ce_multiplex.wav');
y=y(:)';
Ly=length(y);
%
% Creació de variables necessàries per controlar el temps
Tm=1/fm;
T=(Ly-1)*Tm;
t=0:Tm:T;
Lt=length(t);
%
%Transformada de Fourier
Ti=1;
Tf=Ti+0.025;
Li=uint32((Ti/Tm));
Lf=uint32((Tf/Tm));
tt=Ti:Tm:Tf;
yy=y(Li:Lf)';
f=0:fm/2/1000*1.2:fm/2*1.2;
ff=0:5:24000;
Y1=ce_tf(yy,tt,ff);
%
%Demodulador
f0=5000
f1=15000
y0=y.*cos(2*pi*f0*t);
y1=y.*cos(2*pi*f1*t);%Les dimensions de y han de ser iguals a les de t
%sound(y0,fm)

%Experiment
%y2=y;
%y2(1:2:end)=-y2(1:2:end);
%sound(y2,fm) %Es sent igual



%Representaciï¿½ grï¿½fica
figure
subplot(2,1,1)
plot(tt,yy)
subplot(2,1,2)
%plot([ff,fff],[abs(Y1)',abs(Y2)'])
plot(fff,abs(Y2)')