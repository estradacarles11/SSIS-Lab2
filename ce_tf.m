function X=ce_tf(x,t,f)
Tm=t(2)-t(1);
F=exp(-j*2*pi*f(:)*t(:)');
X=Tm*F*x(:);