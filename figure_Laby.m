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

% Last Modified by GUIDE v2.5 03-Nov-2017 16:55:36

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

% Creer 
%       inst of wrapper into handles 
%       state with inside a inst
%                   pacman
%                   ghost
%                   walls
%                   escape
% Choose default command line output for figure_Laby
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

handles.wrapper = Wrapper(12, 3);
handles.state.pacman =  Objet(handles,'g*',5,5);% Create and add pacman into state
handles.state.ghost  =  Objet(handles,'y*',1,1);% Create and add pacman into state
handles.state.walls  =  Walls(handles);         % Create and add walls into state
handles.state.escape =  Escape(handles,'r',4,3);% Create and add escape into state
grid on;

guidata(hObject,handles);    % OMFG !!!

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

%-- callback for all the action buttons
function ui_Callback(hObject, eventdata, handles)
%{  
    hObject.UserData  can take value
    1  : initialization
    2  : wallDown
    3  : wallRight
    4  : pacmanLeftBut
    5  : pacmanUpBut
    6  : pacmanRightBut
    7  : pacmanDownBut
    8  : ghostLeftBut
    9  : ghostUpBut
    10 : ghostRightBut
    11 : ghostDownBut   
    12 : step
    100 : connectWalls
    101 : connectGhost
    102 : connectPacman
%}
% In the input vector, only one element can be equal to 1 (1 of n).
    handles.wrapper.in(hObject.UserData) =1 ;
    handles.wrapper.orderer(handles);
    guidata(hObject,handles); 
    
% end function UI_Callback(hObject, eventdata, handles)


function connect_Callback(hObject, eventdata, handles)
    Wbit = handles.wrapper.wallsBit;
    
    switch hObject.UserData
        case 100
            bitModif = 1;
handles.wrapper.updateConnexion(bitModif);
    guidata(hObject,handles); 


% --- Executes on button press in initialization.
function initialization_Callback(hObject, eventdata, handles)
            axes(handles.axes1) ;
cla                   ;  %% TODO
ghost = Objet(handles,'y*',1,1); 
pacman = Objet(handles,'g*',5,5);
    % Sauvegarde des walls initialis?s
    %% test 
    handles.etat.pacman = pacman;
    handles.etat.ghost = ghost;
    %handles.etat.escape = 
    %% fin test
w = Walls(handles);
visu = Visualization();
handles.visu = visu; %Ajoute visu aux handles
handles.w = w; % Ajoute le mur aux handles
handles.ghost = ghost;
handles.pacman = pacman;

visu.localWallsViewer(handles, 'ghost',ghost);
visu.localWallsViewer(handles, 'pacman',pacman);

handles.escape=Escape(handles,'r',4,3);
isEscaped(handles.escape,handles.pacman,handles);

handles.visu = handles.visu.caughtDetection(handles,handles.ghost,handles.pacman, handles.w);
handles.visu.ghostSeePacman(handles);

guidata(hObject,handles);    % Ca marche !! OMFG !!!

% hObject    handle to initialization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% ************************************************************************

            %% %%%%%%% Ghost %%%%%%%
            
                     
% --- Common actions between all the ghost move.            
function handles = ghostMoves(handles,w,visu,ghost)
    displayWall(handles,w);
    % Test de la detection Caught:
    visu.localWallsViewer(handles, 'ghost',ghost);

    handles.visu = visu;
    handles.ghost = ghost;
    handles.visu.ghostSeePacman(handles);
    handles.visu = handles.visu.caughtDetection(handles,handles.ghost,handles.pacman, handles.w);
 

% --- Executes on button press in ghostRightBut.
function ghostRightBut_Callback(hObject, eventdata, handles)
    % hObject    handle to ghostRightBut (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    %visu = handles.visu;
    [visu,ghost,w] = getElement(handles,'visu','ghost','walls');
    ghost = goRight(handles, ghost, w);
    handles = ghostMoves(handles,w,visu,ghost);
    guidata(hObject, handles);


% --- Executes on button press in ghostUpBut.
function ghostUpBut_Callback(hObject, eventdata, handles)
    % hObject    handle to ghostUpBut (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [visu,ghost,w] = getElement(handles,'visu','ghost','walls');
    ghost = goUp(handles, ghost, w);
    handles = ghostMoves(handles,w,visu,ghost);
    guidata(hObject, handles);  


% --- Executes on button press in ghostLeftBut.
function ghostLeftBut_Callback(hObject, eventdata, handles)
    % hObject    handle to ghostLeftBut (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [visu,ghost,w] = getElement(handles,'visu','ghost','walls');
    ghost = goLeft(handles, ghost, w);
    handles = ghostMoves(handles,w,visu,ghost);
    guidata(hObject, handles);


% --- Executes on button press in ghostDownBut.
function ghostDownBut_Callback(hObject, eventdata, handles)
    % hObject    handle to ghostDownBut (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [visu,ghost,w] = getElement(handles,'visu','ghost','walls');
    ghost = goDown(handles, ghost, w);
    handles = ghostMoves(handles,w,visu,ghost);
    guidata(hObject, handles);

%% ************************************************************************    
    
    
                %% %%%%%%% Pacman %%%%%%%
    
    
function handles = pacmanMoves(handles,w,pacman)
     displayWall(handles,w);
     % Test de detection de escape de pacman
     isEscaped(handles.escape,pacman,handles);
     handles.visu.localWallsViewer(handles, 'pacman',pacman);
     handles.pacman = pacman;
     handles.visu.ghostSeePacman(handles);
     handles.visu = handles.visu.caughtDetection(handles,handles.ghost,handles.pacman, handles.w);
    
% --- Executes on button press in pacmanRightBut.
function pacmanRightBut_Callback(hObject, eventdata, handles)
    % hObject    handle to pacmanRightBut (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [pacman,w] = getElement(handles,'pacman','walls');
    pacman = goRight(handles, pacman, w);
    handles = pacmanMoves(handles,w,pacman);
    guidata(hObject, handles) ;


% --- Executes on button press in pacmanUpBut.
function pacmanUpBut_Callback(hObject, eventdata, handles)
    % hObject    handle to pacmanUpBut (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [pacman,w] = getElement(handles,'pacman','walls');
    pacman = goUp(handles, pacman, w);
    handles = pacmanMoves(handles,w,pacman);
    guidata(hObject, handles) ;
    eventdata.Source


% --- Executes on button press in pacmanLeftBut.
function pacmanLeftBut_Callback(hObject, eventdata, handles)
    % hObject    handle to pacmanLeftBut (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [pacman,w] = getElement(handles,'pacman','walls');
    pacman = goLeft(handles, pacman, w);
    handles = pacmanMoves(handles,w,pacman);
    guidata(hObject, handles);


% --- Executes on button press in pacmanDownBut.
function pacmanDownBut_Callback(hObject, eventdata, handles)
    % hObject    handle to pacmanDownBut (see GCBO)
    % eventdata  reserved  - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [pacman,w] = getElement(handles,'pacman','walls');
    pacman = goDown(handles, pacman, w);
    handles = pacmanMoves(handles,w,pacman);
    guidata(hObject, handles);
    
%% ************************************************************************

                %% %%%%%%% Walls %%%%%%%


    function handles = wallMoves(handles,w)
        displayWall(handles,w);
        handles.visu.localWallsViewer(handles, 'walls',w);
        handles.w = w; % Ajoute le mur aux handles
        handles.visu.ghostSeePacman(handles);
        'walls'
        handles.visu = handles.visu.caughtDetection(handles,handles.ghost,handles.pacman, handles.w);
        
% --- Executes on button press in wallDown.
function wallDown_Callback(hObject, eventdata, handles)
    % hObject    handle to wallDown (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    w = getElement(handles,'walls');
    w = setVerticalWalls(w);
    handles = wallMoves(handles,w);
    guidata(hObject,handles);    % �a marche !! OMFG !!
    
% --- Executes on button press in wallRight.
function wallRight_Callback(hObject, eventdata, handles)
% hObject    handle to wallRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[w] = getElement(handles,'walls');
w = setHorizontalWalls(w);
handles = wallMoves(handles,w); 
guidata(hObject,handles);    % Sa marche !! OMFG !!!
