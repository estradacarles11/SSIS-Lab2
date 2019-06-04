function start619

% Versió 2014b, desembre 2015
%******
% És pel cas en que es posi en un mateix directori el programa start619 i
% la carpeta Lab619. D'aquesta manera no ens hem de preocupar de cap canvi
% de path. Simplement ens hem de posar a MATLAB en el directori que conté
% start619 (i Lab619) i executar start619.
path_ini=cd;
path_619=cd;

ba=filesep;
path(path,path_619);
path(path,[path_619,ba,'Lab619',ba,'dades']);
path(path,[path_619,ba,'Lab619',ba,'dades',ba,'usuari']);
path(path,[path_619,ba,'Lab619',ba,'pracnou']);
path(path,[path_619,ba,'Lab619',ba,'pracajud']);
path(path,[path_619,ba,'Lab619',ba,'prac1nou']);
path(path,[path_619,ba,'Lab619',ba,'prac2nou']);
path(path,[path_619,ba,'Lab619',ba,'prac3nou']);
path(path,[path_619,ba,'Lab619',ba,'prac4nou']);
path(path,[path_619,ba,'Lab619',ba,'prac5nou']);
path(path,[path_619,ba,'Lab619',ba,'prac6nou']);
path(path,[path_619,ba,'Lab619',ba,'sis']);

cd([path_619,ba,'Lab619',ba,'pracajud'])
%******
%Totes les instruccions que queden entre ****** s'han de treure (posar%)
%per generar la versió compilada

%set(0,'DefaultUiControlFontName','arial','DefaultUiControlFontSize',10,'DefaultUiControlFontWeight','bold')
set(0,'showhiddenhandles','off')

f=openfig('fig0sis1v3','reuse');

m2=findobj('type','uimenu','label','de &619');
set(m2,'callback',['guardar_idioma(getidiom),close,clear all,cd(''',path_ini,''')'])
b=findobj('type','uicontrol');
set(b,'backgroundcolor',get(0,'defaultuicontrolbackgroundcolor'))
maxposicio(f)
if exist('idiomaxdefecte.mat','file')==2
    load idiomaxdefecte
    idifig0v2(idioma)
    hmE=findobj('label','&English');
    set(hmE,'userdata','')
    set(get(hmE,'parent'),'userdata',idioma)
end
set(f,'visible','on','keypress','gcf;','delete',['guardar_idioma(getidiom),clear,cd(''',path_ini,''')']);
%set(f,'visible','on','keypress','gcf;','delete',['guardar_idioma(getidiom),clear all,reset(0),cd(''',path_ini,''')']);
figure(f)