function varargout = figure_Laby(varargin) 
% FIGURE_LABY MATLAB code for figure_Laby.fig
%      FIGURE_LABY, by itself, creates a new FIGURE_LABY or raises the existing
%      singleton*.
%
%      H = FIGURE_LABY returns the handle to a new FIGURE_LABY or the handle to
%      the existing singleton*.
%
%      FIGURE_LABY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIGURE_LABY.M with the given input arguments.
%
%      FIGURE_LABY('Property','Value',...) creates a new FIGURE_LABY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before figure_Laby_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to figure_Laby_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help figure_Laby

% Last Modified by GUIDE v2.5 02-Nov-2017 15:58:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @figure_Laby_OpeningFcn, ...
                   'gui_OutputFcn',  @figure_Laby_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% Endialization code - DO NOT EDIT


% --- Executes just before figure_Laby is made visible.
function figure_Laby_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to figure_Laby (see VARARGIN)

% Choose default command line output for figure_Laby
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
handles.sortie.String = 'Ma Sortie';
% For the exit

gost = Objet(handles,'y*',1,1);
pacman = Objet(handles,'g*',5,5);
% Sauvegarde des murs initialis?s
m = Murs(handles);
handles.m = m; % Ajoute le mur aux handles
handles.gost = gost;
handles.pacman = pacman;
guidata(hObject,handles);    % Ca marche !! OMFG !!!

grid on

% UIWAIT makes figure_Laby wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = figure_Laby_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in initialisation.
function initialisation_Callback(hObject, eventdata, handles)
% hObject    handle to initialisation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla
ghost = Objet(handles,'y*',1,1); 
pacman = Objet(handles,'g*',5,5);
    % Sauvegarde des murs initialis?s
m = Murs(handles);
visu = Visualisation( pacman, ghost, m);
handles.visu = visu; %Ajoute visu aux handles
handles.m = m; % Ajoute le mur aux handles
handles.ghost = ghost;
handles.pacman = pacman;
handles.sortie=Sortie(handles,'r',4,3);
guidata(hObject,handles);    % Ca marche !! OMFG !!!
%{
function ghostMoves()
    %% TODO 
end
function pacmanMoves()
    %% TODO 
end
%}
% --- Executes on button press in D2.
function D2_Callback(hObject, eventdata, handles)
% hObject    handle to D2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%visu = handles.visu;
[visu,ghost,m] = getElement(handles,'visu','ghost','murs');
ghost = goDroite(handles, ghost, m);
displayWall(handles,m);
% Test de la detection mang� :
visu = detection_manger(visu, ghost, handles.pacman, m);
MANGER = visu.mange;

handles.visu = visu;
handles.ghost = ghost;

guidata(hObject, handles);





% --- Executes on button press in H2.
function H2_Callback(hObject, eventdata, handles)
% hObject    handle to H2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[visu,ghost,m] = getElement(handles,'visu','ghost','murs');

ghost = goHaut(handles, ghost, m);
displayWall(handles,m);
% Test de la detection mang� :
visu = detection_manger(visu, ghost, handles.pacman, m);
MANGER = visu.mange
handles.visu = visu;

handles.ghost = ghost;
guidata(hObject, handles); %pas de ;



% --- Executes on button press in G2.
function G2_Callback(hObject, eventdata, handles)
% hObject    handle to G2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[visu,ghost,m] = getElement(handles,'visu','ghost','murs');

ghost = goGauche(handles, ghost, m);
displayWall(handles,m);
% Test de la detection mang� :
visu = detection_manger(visu, ghost, handles.pacman, m);
MANGE = visu.mange
handles.visu = visu;

handles.ghost = ghost;
guidata(hObject, handles);


% --- Executes on button press in B2.
function B2_Callback(hObject, eventdata, handles)
% hObject    handle to B2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[visu,ghost,m] = getElement(handles,'visu','ghost','murs');

ghost = goBas(handles, ghost, m);
displayWall(handles,m);
% Test de la detection mang� :
visu = detection_manger(visu, ghost, handles.pacman, m);
MANGE = visu.mange
handles.visu = visu;

handles.ghost = ghost;
guidata(hObject, handles);


% --- Executes on button press in D1.
function D1_Callback(hObject, eventdata, handles)
% hObject    handle to D1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[pacman,m] = getElement(handles,'pacman','murs');

pacman = goDroite(handles, pacman, m);
displayWall(handles,m);
isEscaped(handles.sortie,pacman,handles);
    
handles.pacman = pacman;
guidata(hObject, handles)


% --- Executes on button press in H1.
function H1_Callback(hObject, eventdata, handles)
% hObject    handle to H1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[pacman,m] = getElement(handles,'pacman','murs');

pacman = goHaut(handles, pacman, m)

displayWall(handles,m)
isEscaped(handles.sortie,pacman,handles);
handles.pacman = pacman;
guidata(hObject, handles)



% --- Executes on button press in G1.
function G1_Callback(hObject, eventdata, handles)
% hObject    handle to G1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[pacman,m] = getElement(handles,'pacman','murs');
pacman = goGauche(handles, pacman, m);
displayWall(handles,m)
isEscaped(handles.sortie,pacman,handles);
handles.pacman = pacman;

guidata(hObject, handles)


% --- Executes on button press in B1.
function B1_Callback(hObject, eventdata, handles)
% hObject    handle to B1 (see GCBO)
% eventdata  reserved  - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[pacman,m] = getElement(handles,'pacman','murs');

pacman = goBas(handles, pacman, m)
displayWall(handles,m)
isEscaped(handles.sortie,pacman,handles);
handles.pacman = pacman;

guidata(hObject, handles)


% --- Executes on button press in wallDown.
function wallDown_Callback(hObject, eventdata, handles)
% hObject    handle to wallDown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m = getElement(handles,'murs');
m = set_MursVerticaux(m);
displayWall(handles,m);
handles.m = m; % Ajoute le mur aux handles
guidata(hObject,handles);    % Sa marche !! OMFG !!!

% --- Executes on button press in wallRight.
function wallRight_Callback(hObject, eventdata, handles)
% hObject    handle to wallRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[m] = getElement(handles,'murs');
m = set_MursHorizontaux(m);
displayWall(handles,m);
handles.m = m; % Ajoute le mur aux handles
guidata(hObject,handles);    % Sa marche !! OMFG !!!
