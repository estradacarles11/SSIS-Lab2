[nom,cami]=uigetfile('*.wav');   % Selecció fitxer .wav
[x,fm]=audioread([cami,nom]);    % importació de senyal i freq. mostratge

x=x(:)';
Tm=1/fm;
Lx=length(x);
T=(Lx-1)*Tm;
t=0:Tm:T;

A1=max(x);
A2=-min(x);
A3=max(abs(x));
Px=x*x'/Lx;
A4=sqrt(2*Px);

Zc=[];   % Inicialització de la variable on comptem les mostres entre canvis
for n=2:Lx  % Es recorre tot el vector x 
    if (sign(x(n))*sign(x(n-1)))<0 % Si hi ha canvi de signe
        Zc=[Zc,n];    % Afegim a Zc en quina posició es produeix el canvi de signe
    end
end

Lz=length(Zc);
Zs=0;
for n=2:Lz
    Zs=Zs+Tm*Zc(n)-Tm*Zc(n-1);
end
Nz=Zs/(Lz-1);
Tx=2*Nz;
fx=1/Tx

plot(t,x)

if x(Zc(1)) == 0
    tc=Zc(1)+1
else
    tc=Zc(1)
end

if x(tc) < 0
    sx=Tx/2
else
    sx=Tx
end

sx=sx-Tm*(Zc(1)-2)

disp(['sx=',num2str(sx)])

phix=arcsin(sx/Tx)
