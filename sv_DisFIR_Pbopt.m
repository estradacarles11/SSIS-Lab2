function h=sv_DisFIR_Pbopt(freq,ate)
% sv_DisFIR_Pbopt(freq,ate)
%    funci� que calcula un filtre FIR �ptim passa baixes i dibuixa la seva resposta en freq��ncia (lineal i en dB), amb una plantilla passa baixes, per 0<=f<=fm/2.
% Les freq��ncies s'especifiquen en Hz freq=[fp,fa,fm]. Si nom�s es fa
% servir freq=[Fp,Fa] es considera fm=1
% Les atenuacions s'especifiquen en dB ate=[ap,aa]
% Aquesta funci� fa servir les fuyncions:
%   sv_plantillaPb per dibuixar la plantilla d'especificaions
%   firpm per calcular la resposta impulsional del filtre
% Autor: Sisco Vallverd�, 15-11-2017

% Disseny del filtre
% Especificaci� Banda de pas i atenuada
% Freq��ncies l�mit banda de pas i atenuada
ap=ate(1);
aa=ate(2);
dp=(10^(ap/20)-1)/(10^(ap/20)+1);
da=10^(-aa/20);
fp=freq(1);
fa=freq(2);
if length(freq)==2, fm=1; eif='F'; else fm=freq(3); eif='f'; end
N=2048; % Dimensi� de la DFT
F=(0:N/2)/N;  % Eix de freq. 0<=F<=0.5
flimit=[0,fp,fa,fm/2]/fm;   % freq. l�mits de les banes
% Especificaci� de m�dul
Hmlimit=[1,1,0,0];       % M�dul ideal en el l�mit de cada banda
pond=[da,dp];
% C�lcul iteratiu de l�ordre
M1=0;
M=input('Ordre del filtre=');   
while M1~=M,
%t=(0:M)*Tm;
h=firpm(M,2*flimit,Hmlimit,pond);
H=fft(h,N);  % C�lcul de la DFT
Hm=abs(H(1:N/2+1)); 

figure(1)
subplot(211), % Representaci� de m�dul (lineal)
plot(F*fm,Hm), title(['|H(',eif,')| d''ordre M=',num2str(M)]), xlabel(eif)
sv_plantillaPb([fp,fa,fm],[ap,aa])

subplot(212), % Representaci� de guany (dB)
plot(F*fm,20*log10(Hm)), title(['G_d_B(',eif,') d''ordre M=',num2str(M)]), xlabel(eif)
axis([0,fm/2,-aa*1.5,ap]);
sv_plantillaPb([fp,fa,fm],[ap,aa],1)
M1=M;
M=input('Ordre del filtre='); % Surt de bucle si ordre igual a anterior;
if isempty(M), M=M1; end
end
figure
stem(0:M,h)
title(['h[n], de L=',num2str(M+1),' mostres'])
xlabel('n')