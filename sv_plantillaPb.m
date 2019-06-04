function sv_plantillaPb(freq,ate,dB)
% sv_plantillaPb(freq,ate,dB)
%    funció que dibuixa,una plantilla passa baixes, per 0<=f<=fm/2.
%    Si ja s'ha representat el mòdul d'una resposta en freqüència la plantilla hi queda superposada.
% Les freqüències s'especifiquen en Hz freq=[fp,fa,fm]. Si només es fa
% servir freq=[Fp,Fa] es considera fm=1
% Les atenuacions s'especifiquen en dB ate=[ap,aa]
% dB=1, o qualsevol valor per representar la plantilla de Guany en dB
%
% Autor: Sisco Vallverdú, 15-11-2017
hold on
ap=ate(1);
aa=ate(2);
dp=(10^(ap/20)-1)/(10^(ap/20)+1);
mma=1+dp;
mmi=1-dp;
da=10^(-aa/20);
fp=freq(1);
fa=freq(2);
if length(freq)==2, fm=1; else fm=freq(3); end
if fm<fa; fm=2*(fp+fa), end
if nargin==3
    ap1=20*log10(mma);
    ap2=20*log10(mmi);
    plot([0,fp],[ap1,ap1],'g')
    plot([0,fp,fp],[ap2,ap2,-aa],'g')
    plot([fa,fa,fm/2],[ap1,-aa,-aa],'r')
    plot([0,fp,(fp+fa)/2],[0,0,-aa],'-.k')
else
    plot([0,fp],[mma,mma],'g')
    plot([0,fp,fp],[mmi,mmi,0],'g')
    plot([fa,fa,fm/2],[mma,da,da],'r')
    plot([0,fp,fa,fm/2],[1,1,0,0],'-.k')
end
hold off
