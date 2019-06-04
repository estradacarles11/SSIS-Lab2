% Autor: Carles Estrada i Adri� Febrer
% Creaci� d'un senyal multiplexat provinent de dos arxius de so.
%
clear, close all % Esborrat de variables i gr�fics anteriors.
%
% Lectura d'arxius d'�udio.
[x1,fm1]=audioread('Joy Division - Love Will Tear Us Apart.wav');
[x2,fm2]=audioread('The Night We Met - Cover Song Lord Huron.wav');
%
%Determinaci� de dues freq��ncies prou separades:
F0=5000;
F1=15000;
%
% Comprovaci� de freq��ncies de mostratge, han de ser iguals per poder seguir.
if fm1==fm2, fm=fm1; end 
%
% Creaci� de variables necess�ries per controlar el temps
Tm=1/fm; % Per�ode de mostratge
T=20; % Duraci� del senyal
ti=30; % Temps inicial
tf=ti+T; % Temps final
t=ti:Tm:tf; % Vector temps
ni=ti/Tm; % �ndex temps inicial
nf=tf/Tm; % �ndex temps final
L=length(t); % Longitud vector temps
%
% Transformar so stereo -> mono
x11=x1(ni:nf,1)';
x12=x1(ni:nf,2)';
x1=(x11+x12)/2;
%
x21=x2(ni:nf,1)';
x22=x2(ni:nf,2)';
x2=(x21+x22)/2;
%
% Creaci� filtre
fp=4500; % Freq. l�mit de la banda de pas
fa=5500; % Freq. l�mit de la banda atenuada
freq=[fp,fa,fm]; % Vector d'especificaci� de bandes freq�encials
%
ap=1; % Atenuaci� l�mit a la banda de pas
aa=60; % Atenuaci� l�mit a la banda atenuada
ate=[ap,aa]; % Vector d'especificaci� d'atenuacions
%
h=sv_DisFIR_Pbopt(freq,ate); % Filtre (Ordre 100)
Lh=length(h);
%
%Aplicaci� del filtre i modulaci�
n=0:L+Lh-2;
%
xx1=conv(x1,h);
c1=cos(2*pi*F0*Tm*n);
xxx1=xx1.*c1;
%
xx2=conv(x2,h);
c2=cos(2*pi*F1*Tm*n);
xxx2=xx2.*c2;
%
% Normalitzaci� dels dos senyals
%
min1=min(xxx1);
max1=max(xxx1);
min2=min(xxx2);
max2=max(xxx2);
%
xxx1=2*(xxx1-min1)/(max1-min1)-1; 
xxx2=2*(xxx2-min2)/(max2-min2)-1;
%
% Multiplexat
%
m=xxx1+xxx2;
minm=min(m);
maxm=max(m);
m=2*(m-minm)/(maxm-minm)-1; % Normalitzaci� del senyal multiplexat
%
%Creaci� d'arxiu d'�udio
audiowrite('ce_multiplex.wav',m,fm)
%sound(m,fm)