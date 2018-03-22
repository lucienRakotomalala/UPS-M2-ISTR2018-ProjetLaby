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

% Last Modified by GUIDE v2.5 07-Feb-2018 18:58:01

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

    % Initial laby state
    %labyInit.wallsV_i =[1 1;0 1; 0 0];%laby 3x3
    %labyInit.wallsV_i = [1 0 0;1 0 0;0 0 1; 0 1 0];%laby 4x4 %  dimension can change
    %labyInit.wallsV_i =[1 0 1 0; 1 1 0 1; 0 0 0 0;0 1 1 1; 1 0 0 0]; %laby 5x5
    labyInit.wallsV_i =[1 0 0 0 0 0; 1 0 0 0 0 0; 1 1 1 0 1 0; 0 0 0 0 1 1; 0 0 0 0 0 0; 1 0 0 1 0 1;1 0 0 0 0 0]; %laby 7x7
    %labyInit.wallsH_i =    [1 0 0; 1 0 0];%laby 3x3  
    %labyInit.wallsH_i =    [0 0 1 0;  1 0 0 0; 0 1 0 1];%laby 4x4 %  dimension can change
    %labyInit.wallsH_i=[0 0 0 1 0; 0 1 0 1 0;0 1 0 1 0;0 1 0 0 1];%laby 5x5
    labyInit.wallsH_i=[0 0 0 0 0 1 1; 0 0 1 0 0 1 1;0 1 0 0 0 0 0;0 0 0 0 0 1 0;0 1 1 1 0 0 1;0 0 1 1 0 1 0];%laby 7x7
    
    labyInit.pacman_i = [2,	1]; % static dimension
% TODELETE    labyInit.ghost_i  = [3,1]; % static dimension
    labyInit.escape_i = {[7 7], 0}; % static dimension
 % TODELETE   labyInit.caught_i = 0; % static dimension

    % initial value of walls command
    wallsInit.wallsCommand_i = 0; % dimension can change
    % =0 : begin with right move 
    % =1 : begin with up move 

    % initial value of pacman command
    pacmanInit.pacmanCommand_i= zeros(1,5);% dimension can change

    % initial value of pacman command
 % TODELETE   ghostInit.ghostCommand_i= zeros(1,5);% dimension can change
    
    % initial value of stop
    stopInit.escape = 0;
 % TODELETE   stopInit.caught = 0;
    stopInit.pacman = 0;
  % TODELETE  stopInit.ghost  = 0;
% TODELETE    stopInit.numberOfPossibleCaught=3;
    
    handles.wrapper = Wrapper(11, 9, labyInit, wallsInit, pacmanInit, stopInit);
    handles = createUIWalls(handles);
  % TODELETE  handles = createUIGhost(handles);
    handles = createUIPacman(handles);
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
% TODELETE        8  : ghostLeftBut
  % TODELETE      9  : ghostUpBut
  % TODELETE      10 : ghostRightBut
  % TODELETE      11 : ghostDownBut
        #12 : step(not in in)

%}

    % In the input vector, only one element can be equal to 1 (1 of n).

    in = zeros(1,11);
    if(hObject.UserData~=12) % if not step
        in(hObject.UserData) = 1;
    end
    handles.wrapper = handles.wrapper.orderer(in);
    if(hObject.UserData==1) % if init
       handles = resetUIConnection(handles);
    end
    updateUI(handles, handles.wrapper.get_out());
    guidata(hObject,handles)
    %faire une fonction qui utilise stop pour arrete le laby
end

% --- Callback for all connection
function connect_Callback(hObject, eventdata, handles)
%{
        hObject.UserData :
            100 : connectWalls
 % TODELETE           101 : connectGhost
            102 : connectPacman
%}
    handles.wrapper= handles.wrapper.updateConnexion(hObject.UserData-99,hObject.Value); % 1:walls ; 2:ghost ; 3:pacman
    connection = '';
    hObject.UserData
    switch hObject.UserData
        case 100
            connection = 'wallsPanel';
%         case 101 
%             connection = 'ghostPanel';
        case 102 
            connection = 'pacmanPanel';
    end

    set(handles.(connection),'Visible',isOne(~hObject.Value));
    if(handles.wrapper.wallsBit || handles.wrapper.pacmanBit ) %% mod to || si gestion de commande partielle
        set(handles.step,'Visible','on');
    else 
        set(handles.step,'Visible','off');
    end
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
    nbPts = 32;
    rayon = 1/3;
    %%%%%%%%

    pos = pi/6:(5/3*pi)/(nbPts-1) :11/6*pi;
    x = [0,rayon*cos(pos)]     + h.pacmanPositionInit(1)-.5;
    y = [0,rayon*sin(pos)]     + h.pacmanPositionInit(2)-.5;
    h.pacman = patch(x,y,h.pacmanColor);
    %%%%%%%%%
    hold off;
end

% --- Create a graphical element for pacman
%% TODELETE function h = createUIGhost(handles)
%     nbPts = 32; % Definition of object
%     %%%%%
%     h = handles;
%     h.ghostPositionInit  = [2 1];
%     h.ghostColor         = [0.83 .33 0.1] ; % strange orange
% 
%     circle = 1/4;
%     hold on;
% 
%     pos = linspace(0,pi,nbPts);
% 
%     % Ghost cape
%     x_v = linspace(h.ghostPositionInit(1)-.5 - circle, h.ghostPositionInit(1)-.5 + circle, nbPts);
%     y_v = h.ghostPositionInit(2)-.5-circle + circle*.25*sin(linspace(pi,8*pi,length(x_v)));
% 
%     % All point
%     x = [h.ghostPositionInit(1)-.5 [circle*cos(pos)+ h.ghostPositionInit(1)-.5] ... Head of ghost
%         h.ghostPositionInit(1)-.5 h.ghostPositionInit(1)-.5-circle ... Made a line which separate the ghost in two parts
%         h.ghostPositionInit(1)-.5-circle ...
%         x_v ...     Cape
%         h.ghostPositionInit(1)-.5+circle h.ghostPositionInit(1)-.5+circle];
% 
%     y = [h.ghostPositionInit(2)-.5 [circle*sin(pos)+h.ghostPositionInit(2)-.5] ...
%         h.ghostPositionInit(2)-.5 h.ghostPositionInit(2)-.5...
%         h.ghostPositionInit(2)-.5-circle ...
%         y_v ...
%         h.ghostPositionInit(2)-.5-circle h.ghostPositionInit(2)-.5];
% 
%     axes(h.axes1);
%     h.ghost = patch(x,y,h.ghostColor);
%     hold off;
% end

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
    assignin('base','handles',handles);
    h= handles;
    axes(h.axes1);

    % set(h.Escape,'BackgroundColor',[.8 .8 .8]);
    % set(h.Escape,'String','Escaped Pacman :');
     h.escape.position = h.wrapper.modelLaby.presentState.escape{1}; % need to take the good one into h.wrapper.modelLaby. ... 
     y = h.walls.size - h.escape.position(2)+1;
     assignin('base','rec',[ y-.8 ,  h.escape.position(2)-1+.2 , .6 , .6 ]);

     h.escape.color = 'r';
     h.escape.rect =  rectangle('Position',[ h.escape.position(1)-.8 ,  y-.8 , .6 , .6 ],...
                                'Curvature',.1, 'EdgeColor',h.escape.color,'FaceColor',h.escape.color);
     h.escape.text =  text( h.escape.position(1)-.799 ,  y-.5,  'Escape',...
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
  % TODELETE  updateUIPlayer( handles,'ghost', out{2});
    updateUIWalls( handles.walls , out{3},out{4});           %(3,4)
    % 
    updateUIActiveCammand(handles);
    updateUIButton(handles);
    %

  % TODELETE  updateUICaught(handles.Caught ,out{5},handles.wrapper.get_stop());        %(5)
    updateUIEscape(handles.Escape,out{6});          %(6)
    updateUIWallsAround(handles,'Pacman',out{7}); %(7) for pacman
 % TODELETE   updateUIWallsAround(handles,'Ghost',out{8});  %(8) for ghost
 % TODELETE   updateUIWallsAround(handles,'See',out{9});    %(9) for ghost see pacman
end

% --- Update visibility of command panel for only see the possibles
% commands on the good time
function updateUIActiveCammand(handles)
%% the plan !
% if XX commanded && him time to play 
    % show him panel
 % else 
    % unshow him panel
 % end
 
    %% pacman 

    if(handles.wrapper.whoPlay == 1 )% si a son tour
     set(handles.connectPacman,'Visible','on');
     if(handles.wrapper.pacmanBit == 1) % si connecté
         set(handles.pacmanPanel,'Visible','off');
         set(handles.step,'Visible','on');
     else % si pas connecté
         set(handles.pacmanPanel,'Visible','on');
         set(handles.step,'Visible','off');
     end
    else
     set(handles.connectPacman,'Visible','off');
     set(handles.pacmanPanel,'Visible','off');
    end

%     %% ghost % TODELETE
% 
%     if(handles.wrapper.whoPlay == 2 )% si a son tour
%      set(handles.connectGhost,'Visible','on');
%      if(handles.wrapper.ghostBit == 1) % si connecté
%          set(handles.ghostPanel,'Visible','off');
%          set(handles.step,'Visible','on');
%      else % si pas connecté
%          set(handles.ghostPanel,'Visible','on');
%          set(handles.step,'Visible','off');
%      end
%     else
%      set(handles.connectGhost,'Visible','off');
%      set(handles.ghostPanel,'Visible','off');
%     end 

    %% walls
    if(handles.wrapper.whoPlay == 0 )% si a son tour
     set(handles.connectWalls,'Visible','on');
     if(handles.wrapper.wallsBit == 1) % si connecté
         set(handles.wallsPanel,'Visible','off');
         set(handles.step,'Visible','on');
     else % si pas connecté
         set(handles.wallsPanel,'Visible','on');
         set(handles.step,'Visible','off');
     end
    else
     set(handles.connectWalls,'Visible','off');
     set(handles.wallsPanel,'Visible','off');
    end
end


% --- Update visibility of moving command button in function of possibles
% moves
function updateUIButton(handles)
    player = {'pacman'};
    possibleMoves = cell(1,4);
        possibleMoves(1,:)=cell(strcat(player ,{'Up','Down','Left','Right'},'But'));
    

        for i = 1:max(size(possibleMoves,2)) 
            set(handles.(possibleMoves{1,i}) ,'Visible',isOne(~handles.wrapper.out{7}(i)));
        end
    
end

% --- Update graphical place of a player (ghost or pacman).
function updateUIPlayer( handles,strPlayer, position)
%smooth movement !! see visupacman,section :'Smooth movement for parman and
%ghost'
    nMvs = 20;
    Xpts = get(handles.(strPlayer),'XData');
    initXpos = Xpts(1)+.5;

    Ypts = get(handles.(strPlayer),'YData');
    initYpos =  Ypts(1) + .5; 
    %
    if( (position(1)-initXpos)~=0  || (handles.walls.size - position(2)+1- initYpos)~=0 )
        t = linspace(0,1,nMvs);
        om = 72.89105;
        cv = -11.27357;
        smoothMve = ((om+1)./(om*exp(cv*t)+1)-1)/om;
        smoothMve(end)=1;
        for i = 1: nMvs
            pause(.1/nMvs);
            set(handles.(strPlayer),...
                'XData', Xpts + smoothMve(i)*(position(1)-initXpos),...
                'YData', Ypts + smoothMve(i)*(handles.walls.size - position(2)+1- initYpos));
        end
    end
end


% ----Update graphical element for caught.
% % TODELETE function updateUICaught(elementToSet,caughtInt,stp)
%     clr = [.8 .8 .8];
%     strD = '';
%     if (caughtInt>0)
%         strD = int2str(caughtInt);
%     end
%     if (stp(2))
%            clr = 'r';
%     end
%     set(elementToSet,'BackgroundColor',clr)
%     set(elementToSet,'String',strcat(elementToSet.UserData,strD))
% end

% ----Update graphical element for escape.
function updateUIEscape(elementToSet,boolState)
    clr = [.8 .8 .8];
    strD = get(elementToSet,'UserData');
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

% --- Convert 1 in 'on' and 0 in 'off'.
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

% --- Reset all connections 
function h = resetUIConnection(handles)
    h = handles;
    % Show all actions panel (ghost, pacman, walls).
    set(h.wallsPanel, 'Visible','on');
    set(h.pacmanPanel,'Visible','on');
    % TODELETE set(h.ghostPanel, 'Visible','on');

    % Set off all connection buttons.
    set(h.connectWalls, 'Value',0);
    set(h.connectPacman,'Value',0);
    % TODELETE set(h.connectGhost, 'Value',0);

    % Set unvisible step button
    set(h.step,'Visible','off');

    % Set all connection bit to 0 into wrapper
    h.wrapper.wallsBit  = 0;
    h.wrapper.pacmanBit = 0;
% TODELETE    h.wrapper.ghostBit  = 0;
end
    
