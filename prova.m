function varargout = FMM(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name', mfilename, ...
    'gui_Singleton', gui_Singleton, ...
    'gui_OpeningFcn', @FMM_OpeningFcn, ...
    'gui_OutputFcn', @FMM_OutputFcn, ...
    'gui_LayoutFcn', [] , ...
    'gui_Callback', []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
%==================================================================
function FMM_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
global L_medio; %Mitad de la cantidad de muestras a recolectar
L_medio=1000;
global Nfft; %Cantidad de puntos para calcular la FFT
Nfft=2048;
global fm; %Frecuencia de muesreo según Nyquist
fm=80000; %Frecuencia de muesreo según Nyquist
global treq; %Tiempo requerido para recolectar L muestras
treq=2*L_medio/fm; %Tiempo requerido para recolectar L muestras
global fs;
fs=((2*L_medio-1)/treq); %División de tiempo para recolectar L muestras
global n; %Vector de muestras a recolectar
n=0:1/fs:treq;
global t1; %Vector en cantidad de muestras recolectadas
t1=0:length(n)-1;
%Vector de frecuencias para los espectros en frecuencia
global M;
M=Nfft/2;
faux(M+1:Nfft)=0:M-1; %Vector de frecuencias desordenado
faux(1:M)=-M:-1; %Vector de frecuencias ordenado
global f;
f=fm*faux/(Nfft); %Vector de frecuencias normalizado
x=0;
axes(handles.axes1)
plot(n,x)
title('Dominio del tiempo');
xlabel('Tiempo [S]');
AXIS([0 0.006 -1 1])
set(handles.axes1,'XMinorTick','on')
grid on
axes(handles.axes2)
plot(f,x)
title('Domininio del la Frecuencia');
xlabel('Frecuencia [Hz]');
AXIS([0 2000 0 1])
set(handles.axes2,'XMinorTick','on')
grid on
%==================================================================
function varargout = FMM_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
%==================================================================
function am_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
%==================================================================
function am_Callback(hObject, eventdata, handles)
Val=get(hObject,'String');
NewVal = str2double(Val);
handles.am=NewVal;
guidata(hObject,handles);
%==================================================================
function fm_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
%==================================================================
function fm_Callback(hObject, eventdata, handles)
Val=get(hObject,'String');
NewVal = str2double(Val);
handles.fm=NewVal;
guidata(hObject,handles);
%==================================================================
function ap_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
%==================================================================
function ap_Callback(hObject, eventdata, handles)
Val=get(hObject,'String');
NewVal = str2double(Val);
handles.ap=NewVal;
guidata(hObject,handles);
%==================================================================
function fp_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
%==================================================================
function fp_Callback(hObject, eventdata, handles)
Val=get(hObject,'String');
NewVal = str2double(Val);
handles.fp=NewVal;
guidata(hObject,handles);
%==================================================================
function im_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
%==================================================================
function im_Callback(hObject, eventdata, handles)
Val=get(hObject,'String');
NewVal = str2double(Val);
handles.im=NewVal;
guidata(hObject,handles);
%==================================================================
function psmensaje_Callback(hObject, eventdata, handles)
global L_medio;
global Nfft;
global fm;
global treq;
global fs;
global n;
global t1;
global M;
global f;
A=handles.am;
F=handles.fm;
%Se genera la señal a modular
Am=A; %Amplitud de la señal a modular
wm=2*pi*F; %Frecuencia de la señal a modular
phi=0; %Fase de la señal a modular
mt=Am*cos(wm*n+phi); %Señal a modular
axes(handles.axes1)
plot(n,mt,'linewidth', 3, 'color', 'black')
title('Dominio del tiempo de la señal mensaje');
xlabel('Tiempo [S]');
ylabel('Amplitud m(t) ');
texto=strcat('mensaje de ', num2str(F), 'Hz');
legend(texto);
AXIS([0 2*(1/F) -A A]);
set(handles.axes1,'XMinorTick','on')
grid on
%**************************************************************************
Y1=fft(mt,Nfft); %FFT de Nfft puntos para la señal FM
Y1=fftshift(Y1); %Reordenamiento de los valores de la FFT
length(Y1);
norm1=max(abs(Y1)); %Para normalizar el espectro en magnitud
Yf1=unwrap(angle(Y1)); %Cálculo de las componentes de fase de la señal
axes(handles.axes2)
plot(f,abs(Y1)/norm1,'linewidth', 3, 'color', 'black');
legend('Espectro de m(t)');
title('Espectro continuo en magnitud de la señal mensaje');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud normalizada |FFT|');
legend('Espectro Mensaje m(t)');
xlim([-8*F 8*F]);
grid on;
%==================================================================
function psportadora_Callback(hObject, eventdata, handles)
global L_medio;
global Nfft;
global fm;
global treq;
global fs;
global n;
global t1;
global M;
global f;
A=handles.ap;
F=handles.fp;
Ac=A; %Amplitud de la señal portadora
wc=2*pi*F; %Frecuencia de la señal portadora
st=Ac*cos(wc*n); %Señal FM
axes(handles.axes1)
plot(n,st,'linewidth',3, 'color', 'black')
title('Dominio del tiempo de señal portadora');
xlabel('Tiempo [S]');
ylabel('Amplitud de c(t)');
texto=strcat('portadora de ', num2str(F), 'Hz');
legend(texto);
AXIS([0 2*(1/F) -A A])
set(handles.axes1,'XMinorTick','on')
grid on
%**************************************************************************
Y1=fft(st,Nfft); %FFT de Nfft puntos para la señal FM
Y1=fftshift(Y1); %Reordenamiento de los valores de la FFT
norm1=max(abs(Y1)); %Para normalizar el espectro en magnitud
Yf1=unwrap(angle(Y1)); %Cálculo de las componentes de fase de la señal
axes(handles.axes2)
plot(f,abs(Y1)/norm1, 'linewidth', 3, 'color', 'black');
title('Espectro continuo en magnitud de la señal portadora');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud normalizada |FFT|');
legend('Espectro Portadora c(t)');
xlim([-8*F 8*F]);
grid on;
%**************************************************************************
function pssmodulada_Callback(hObject, eventdata, handles)
global L_medio;
global Nfft;
global fm;
global treq;
global fs;
global n;
global t1;
global M
global f;
A=handles.am;
F=handles.fm;
inm=handles.im;
A2=handles.ap;
F2=handles.fp;
Am=A; %Amplitud de la señal a modular
wm=2*pi*F; %Frecuencia de la señal a modular
phi=0; %Fase de la señal a modular
mt=Am*cos(wm*n+phi); %Señal a modular
%Parametros necesarios para la modulación FM
beta=inm; %Indice de modulación
kw=beta*wm/Am; %Desviación de frecuencia
phi=-pi/2; %Se desfasa la señal
mt1=Am*cos(wm*n+phi); %Se utiliza la señal original para generar el
desf=beta*mt1; %Desfase de la portadora
%Se genera la señal FM
Ac=A2; %Amplitud de la señal portadora
wc=2*pi*F2; %Frecuencia de la señal portadora
st=Ac*cos(wc*n+desf); %Señal FM
indk=beta;
gfm = modulate(mt,wc/(2*pi),fm,'fm',indk);
axes(handles.axes1)
plot(n,gfm,'linewidth', 3, 'color', 'black');
title('Señal FM resultante a partir de m(t)');
xlabel('Tiempo [S]');
ylabel('s(t)');
texto=strcat('señal modulada con beta = ', num2str(beta));
legend(texto );
grid on;
%¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿
Y1=fft(gfm,Nfft); %FFT de Nfft puntos para la señal FM
Y1=fftshift(Y1); %Reordenamiento de los valores de la FFT
norm1=max(abs(Y1)); %Para normalizar el espectro en magnitud
Yf1=unwrap(angle(Y1)); %Cálculo de las componentes de fase de la señal
axes(handles.axes2)
plot(f,abs(Y1)/norm1, 'linewidth', 3, 'color', 'black');
title('Espectro continuo en magnitud de la señal resultante FM');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud normalizada |FFT|');
legend('Espectro FM');
xlim([-35*F 35*F]);
grid on;
function pssdmodulada_Callback(hObject, eventdata, handles)
global L_medio;
global Nfft;
global fm;
global treq;
global fs;
global n;
global t1;
global M;
global f;
A=handles.am;
F=handles.fm;
inm=handles.im;
A2=handles.ap;
F2=handles.fp;
Am=A; %Amplitud de la señal a modular
wm=2*pi*F; %Frecuencia de la señal a modular
phi=0; %Fase de la señal a modular
mt=Am*cos(wm*n+phi); %Señal a modular
%Parametros necesarios para la modulación FM
beta=inm; %Indice de modulación
kw=beta*wm/Am; %Desviación de frecuencia
phi=-pi/2; %Se desfasa la señal
mt1=Am*cos(wm*n+phi); %Se utiliza la señal original para generar el
desf=beta*mt1; %Desfase de la portadora
%Se genera la señal FM
Ac=A2; %Amplitud de la señal portadora
wc=2*pi*F2; %Frecuencia de la señal portadora
st=Ac*cos(wc*n+desf); %Señal FM
indk=beta;
gfm = modulate(mt,wc/(2*pi),fm,'fm',indk);
rmt1=5*demod(gfm,wc/(2*pi),fm,'fm');
axes(handles.axes1)
plot(n,rmt1, 'linewidth', 3, 'color', 'black');
title('Señal FM generada a partir de m(t)');
xlabel('Tiempo[S]');
ylabel('s(t)');
legend('Señal Recuperada');
grid on;
%¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿
Y1=fft(rmt1,Nfft); %FFT de Nfft puntos para la señal FM
Y1=fftshift(Y1); %Reordenamiento de los valores de la FFT
norm1=max(abs(Y1)); %Para normalizar el espectro en magnitud
Yf1=unwrap(angle(Y1)); %Cálculo de las componentes de fase de la señal
axes(handles.axes2)
plot(f,abs(Y1)/norm1, 'linewidth', 3, 'color', 'black');
title('Espectro continuo en magnitud de la señal portadora');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud normalizada |FFT|');
legend('Espectro de señal recuperada');
xlim([-35*F 35*F]);
grid on;
function pushbutton5_Callback(hObject, eventdata, handles)
global L_medio;
global Nfft;
global fm;
global treq;
global fs;
global n;
global t1;
global M;
global f;
A=handles.am;
F=handles.fm;
inm=handles.im;
A2=handles.ap;
F2=handles.fp;
Am=A; %Amplitud de la señal a modular
wm=2*pi*F; %Frecuencia de la señal a modular
phi=0; %Fase de la señal a modular
mt=Am*cos(wm*n+phi); %Señal a modular
%Parametros necesarios para la modulación FM
beta=inm; %Indice de modulación
kw=beta*wm/Am; %Desviación de frecuencia
phi=-pi/2; %Se desfasa la señal
mt1=Am*cos(wm*n+phi); %Se utiliza la señal original para generar el
desf=beta*mt1; %Desfase de la portadora%Se genera la señal FM
Ac=A2; %Amplitud de la señal portadora
wc=2*pi*F2; %Frecuencia de la señal portadora
st=Ac*cos(wc*n+desf); %Señal FM
indk=beta;
gfm = modulate(mt,wc/(2*pi),fm,'fm',indk);
rmt1=27*demod(gfm,wc/(2*pi),fm,'fm');
axes(handles.axes1)
plot(n,mt, 'linewidth', 3, 'color', 'black');
title('Señal Original vrs Señal demodulafa');
xlabel('Tiempo [S]');
ylabel('s(t)');
legend('Señal Original');
grid on;
axes(handles.axes2)
plot(n, rmt1, 'linewidth', 3, 'color', 'blue');
title('Señal FM generada a partir de m(t)');
xlabel('Tiempo[s]');
ylabel('s(t)')
legend('Señal Recuperada');
grid on;