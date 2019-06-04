% Autor: Sisco Vallverd�
% Versi� de referencia curs T17 (cal completar el codi)
% An�lisi par�metres sinusoide
%
clc, clear, close all  % Esborrat de variables i gr�fics anteriors
%
% Lectura del fitxer wav
[nom,cami]=uigetfile('*.wav');   % Selecci� fitxer .wav
[x,fm]=audioread([cami,nom]);    % importaci� de senyal i freq. mostratge
%
%Preparaci� de variables d'an�lisi
x=x(:)';  % Garantim que el senyal x sigui un vector fila
Tm=1/fm;  % temps de mostratge
Lx=length(x); % nombre de mostres del senyal
T=(Lx-1)*Tm;  % Durada del senyal en segons
t=0:Tm:T;  % Eix de temps
%
% Escoltem el senyal
sound(x,fm)
%
% Primera representaci� gr�fica
subplot(211), plot(t,x);
title(['Senyal del fitxer ',nom])
xlabel('t')


% An�lisi amplitud (es pot comprovar amb el gr�fic)
A1=max(x);  % mesurem l'amplitud amb el m�xim
A2=-min(x);  % mesurem l'amplitud amb el m�nim
A3=max(abs(x));  % mesurem l'amplitud amb el valor absolut m�xim
Px=x*x'/Lx;     % Estimaci� de la pot�ncia del senyal
A4=COMPLETAR;  % Amplitud a partir de la pot�ncia
%
%Mostrem els resultats d'amplitud
disp('La mesura de l''amplitud amb diferents prcediments �s:')
disp(['A, com a m�xim de x(t), A1=',num2str(A1)])
disp(['A, com m�nim de x(t), A2=',num2str(A2)])
disp(['A, com el m�xim valor absolut de x(t), A3=',num2str(A3)])
disp(['A, a partir de la pot�ncia mitjana de x(t), A4=',num2str(A4)])

% Mesura de freq��ncia (o per�ode)
% Cerca de les mostres on hi ha un canvi de signe
Zc=[];   % Inicialitzaci� de la variable on comptem les mostres entre canvis
for n=2:Lx  % Es recorre tot el vector x 
    if (sign(x(n))*sign(x(n-1)))<0 % Si hi ha canvi de signe
        Zc=[Zc,n];    % Afegim a Zc en quina posici� es produeix el canvi de signe
    end
end
Nz=COMPLETAR;  % Mesura de distancia entre dos zeros
Tx=COMPLETAR; % Periode estimat del senyal
fx=1/Tx; % Freq��ncia del senyal
disp(['La freq��ncia estimada per creuament per zeros �s: fx=',num2str(fx),' Hz'])

% Representem 3 per�odes
L3=ceil(Tx*fm*3); % Nombre de mostres que hi ha en tres per�odes del senyal
subplot(212), plot(t(1:L3),x(1:L3))
title('Representaci� de tres per�odes')
xlabel('t')

% Mesura de la fase
phix=COMPLETAR;
if x(2)>x(1), phix=-phix; end  % Comprovaci� del signe de la fase
disp(['La fase �s phix=',num2str(phix*180/pi),' �'])