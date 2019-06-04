Ax=2;
fx=440;
phix=pi/2;
ti=0;
tf=2;
fm=44100;
tm=1/fm;
t=[ti:tm:tf];
x=Ax*sin(2*pi*fx*t+phix);
if Ax <= 1;
    X=x;
else;
    X=x/Ax;
end
audiowrite('ce_diapaso.wav',X,fm)
L=ceil(3/fx*fm);
plot(t(1:L),X(1:L))
sound(X,fm)