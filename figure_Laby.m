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

% Last Modified by GUIDE v2.5 09-Nov-2017 18:52:35

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
end

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
% creation of the differents elements (wrapper, ghost, pacman, walls,
% escape)
handles.wrapper = Wrapper(11, 9);
handles = createUIGhost(handles);
handles = createUIPacman(handles);
handles = createUIWalls(handles);
handles = createUIEscape(handles);
guidata(hObject,handles);    % OMFG !!!
%assignin ('base','handles',handles);
% UIWAIT makes figure_Laby wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = figure_Laby_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end
% ===============================================================

%%          Callbacks


%-- Callback for all the action's buttons
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
        #12 : step(not in in)

%}

% In the input vector, only one element can be equal to 1 (1 of n).

if(hObject.UserData~=12)
    handles.wrapper.in = zeros(1,length(handles.wrapper.in)) ;
    handles.wrapper.in(hObject.UserData) = 1;
end


handles.wrapper = handles.wrapper.orderer();
updateUI(handles, handles.wrapper.out);
guidata(hObject,handles);

end

% --- Callback for all connection
function connect_Callback(hObject, eventdata, handles)
%{
        hObject.UserData :
            100 : connectWalls
            101 : connectGhost
            102 : connectPacman
%}
handles.wrapper.updateConnexion(hObject.UserData-99,hObject.Value);
connection = '';
switch hObject.UserData
    case 100
        connection = 'wallsPanel';
    case 101 
        connection = 'ghostPanel';
    case 102 
        connection = 'pacmanPanel';
end

set(handles.(connection),'Visible',isOne(~hObject.Value));

guidata(hObject,handles);
end
% ===============================================================

%%          Creation of Pacman Ghost, Walls and the Escape


% --- Create a graphical element for ghost
function h = createUIPacman(handles)
hold on;
h = handles;
axes(h.axes1);
h.pacmanPositionInit  = [1 2];
h.pacmanColor         = [0 .5 0] ; % dark green
h.pacman   = plot( h.pacmanPositionInit(1)-.5,...
                   h.pacmanPositionInit(2)-.5,...
                   'Color',h.pacmanColor,...
                   'Marker','*' );
hold off;
end

% --- Create a graphical element for pacman
function h = createUIGhost(handles)
hold on;
h = handles;

axes(h.axes1);

h.ghostPositionInit  = [2 1];
h.ghostColor         = [0.83 .33 0.1] ; % strange orange
h.ghost   = plot( h.ghostPositionInit(1)-.5,...
                  h.ghostPositionInit(2)-.5,...
                  'Color',h.ghostColor,...
                  'Marker','*'   );
hold off;

end

% --- Create a graphical element for walls
function h = createUIWalls(handles)
h=handles;
h.walls.size =  max(size(h.wrapper.modelLaby.presentState.wallsV));

hold on;
axes(h.axes1);
% grid 
tickValuesX = 0:1:h.walls.size ;
tickValuesY = 0:1:h.walls.size ;
set(gca,'XTick',tickValuesX);
set(gca,'YTick',tickValuesY);
grid on

h.walls.color = 'b'; % blue
axis([0 h.walls.size 0 h.walls.size]);
% Borders
h.walls.border =  rectangle( 'Position',[0 0 h.walls.size h.walls.size],...
                             'EdgeColor',h.walls.color,...
                             'LineWidth',2);
% internal walls
h.walls.horizontals = []; % horizontals walls
h.walls.verticals = []; % verticals walls
y = 0:h.walls.size-1;
 for k = 1 : h.walls.size -1
    h.walls.verticals = [h.walls.verticals , line(  [k k],[y' y'+1],...
                                                        'linewidth',2,...
                                                        'visible', 'off',...
                                                        'Color',h.walls.color)];
                                                    
    h.walls.horizontals   = [h.walls.horizontals   ; line(  [y' y'+1],[k k],...
                                                        'linewidth',2,...
                                                        'visible', 'off',...
                                                        'Color',h.walls.color)' ];
 end
h.walls.verticals = flipud(h.walls.verticals);
h.walls.horizontals = flipud(h.walls.horizontals);
hold off;
end

% --- Create a graphical element for the escape
function h = createUIEscape(handles)
hold on;

h= handles;
axes(h.axes1);
% set(h.Escape,'BackgroundColor',[.8 .8 .8]);
% set(h.Escape,'String','Escaped Pacman :');
 h.escape.position = h.wrapper.modelLaby.presentState.escape{1}; % need to take the good one into h.wrapper.modelLaby. ... 
 h.escape.color = 'r';
 h.escape.rect =  rectangle('Position',[ h.escape.position(1)-1+.2 ,  h.escape.position(2)-1+.2, .6 , .6 ],...
                            'Curvature',.1, 'EdgeColor',h.escape.color,'FaceColor',h.escape.color);
 h.escape.text =  text( h.escape.position(1)-.799 ,  h.escape.position(2)-.5,  'Escape',...
                       'Color','w',...
                       'FontSize', 8,...
                       'FontWeight','bold');

hold off;
end
% ===============================================================

%%          Update UI 


% --- Update all UI elements
function updateUI(handles,out)

 updateUIPlayer( handles,'pacman', out{1});      %(1,2)
 updateUIPlayer( handles,'ghost', out{2});
 updateUIWalls( handles.walls , out{3},out{4});           %(3,4)
 updateUICaught(handles.Caught ,out{5});        %(5)
 updateUIEscape(handles.Escape,out{6});          %(6)
 updateUIWallsAround(handles,'Pacman',out{7}); %(7) for pacman
 updateUIWallsAround(handles,'Ghost',out{8});  %(8) for ghost
 updateUIWallsAround(handles,'See',out{9});    %(9) for ghost see pacman
 
end

% --- Update graphical place of a player (ghost or pacman).
function updateUIPlayer( handles,strPlayer, position)
y = handles.walls.size - position(2)+1; 
set(handles.(strPlayer),'XData',position(1)-.5,'YData',y-.5);
end

% ----Update graphical element for caught.
function updateUICaught(elementToSet,caughtInt)

clr = [.8 .8 .8];
strD = '';
if (caughtInt>0)
    clr = 'r';
    strD = int2str(caughtInt);
end
set(elementToSet,'BackgroundColor',clr)
set(elementToSet,'String',strcat(elementToSet.UserData,strD))
end

% ----Update graphical element for escape.
function updateUIEscape(elementToSet,boolState)

clr = [.8 .8 .8];
strD = get(elementToSet,'String');
if (boolState == 1)
    clr = 'r';
    strD = strcat(strD,' YES');
end
set (elementToSet,'BackgroundColor',clr)
set (elementToSet,'String',strD);
end

% --- Update up down left and right walls around a element (pacman, ghost,
% ghost sees pacman).
function updateUIWallsAround(handles,strElement,wallsAround) %(7,8,9)    
updatePresenceDetectorDisplay(handles.( strcat(strElement,'Up'))   , wallsAround(1));
updatePresenceDetectorDisplay(handles.( strcat(strElement,'Down')) , wallsAround(2));
updatePresenceDetectorDisplay(handles.( strcat(strElement,'Left')) , wallsAround(3));
updatePresenceDetectorDisplay(handles.( strcat(strElement,'Right')), wallsAround(4));
end

% --- Update graphicals elements for the walls.
function updateUIWalls( wallsUI , vertWalls,horizWalls)
for h = 1:wallsUI.size-1
    for k = 1:wallsUI.size
        set(wallsUI.horizontals(h , k)  , 'Visible' , isOne(horizWalls( h , k)));
        set(wallsUI.verticals(  k , h)  , 'Visible' , isOne(vertWalls(  k ,  h)));
    end
end
end

% --- Convert 1 in 'on and 0 in 'off'.
function strOnOff = isOne(boolCond)
strOnOff = 'off';
if (boolCond == 1)
    strOnOff = 'on';
end
end

% --- Change the background color of the UI Element according to the state 
% of the binary condition.
function updatePresenceDetectorDisplay(elementToSet,boolCondition)
if(boolCondition > 0)
    set(elementToSet,'BackgroundColor','b');
else
    set(elementToSet,'BackgroundColor',[0.8 0.8 0.8]);
end
end




%{
% --- Executes on button press in initialization.
function initialization_Callback(hObject, eventdata, handles)
            axes(handles.axes1) ;
cla                   ;  %% TODO
ghost = Objet(handles,'y*',1,1);
pacman = Objet(handles,'g*',5,5);
    % Sauvegarde des walls initialis?s
    %% test
    handles.etat.pacman = pacman;
    handles.etat.ghost  = ghost;
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
%}
