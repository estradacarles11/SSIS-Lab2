%Senyal temporal
A=0.7;
fo=440;
phix=0;
ti=0;
T=0.025;
fm=8000;
tm=1/fm;
t=[ti:tm:T];
xx=A*cos(2*pi*fo*t+phix);
if A <= 1;
    x=xx;
else;
    x=xx/A;
end

%Transformada de Fourier
f=0:2:2000;
X=ce_tf(x,t,f);
Xt=T*A/2*(sinc((f-fo)*T)+sinc((f+fo)*T));

%Representació gràfica
subplot(211), plot(t,x);
xlabel('t (segons)'),title('Senyal mostrejat')
subplot(212)
plot(f,[abs(X)';abs(Xt)]);
xlabel('f (Hz)'),title('Comparació T. Fourier aproximada (blau) amb la teòrica')