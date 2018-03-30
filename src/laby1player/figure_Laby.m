%> @filename figure_Laby.m

% ================================================================
%> @brief Script linked to the graphical interface whitch contain all the graphical functions.
%> This file contain also the instance of Wrapper class. All the handles of graphical elements and instance of class are stored into the "handles" structure.



% ================================================================
%> @brief function call when figure_Laby si open. It's initialize the UI.
%> @param varargin Several inputs.
%> @return varargout Several Outputs.
% ================================================================
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
% ================================================================
%> @brief initialization function.
%> It's where is initialize the parameters of the labyrinth and all the commands in the section "INITIAL PARAMETERS OF THE LABYRINTH  AND THE COMMANDS".
%> @param hObject    handle to figure
%> @param eventdata  reserved - to be defined in a future version of MATLAB
%> @param handles    structure with handles and user data (see GUIDATA)
%> @param varargin   command line arguments to figure_Laby (see VARARGIN)
% ================================================================
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
    % creation of the differents elements (wrapper, ghost, pacman, walls,
    % escape)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INITIAL PARAMETERS OF THE LABYRINTH  AND THE COMMANDS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Initial laby state

    % Verticals walls   (dimension can change)
    labyInit.wallsV_i =[1 0 1 0; 1 1 0 1; 0 0 0 0;0 1 1 1; 1 0 0 0]; %laby 5x5
    % labyInit.wallsV_i =[1 1;0 1; 0 0];%laby 3x3
    %labyInit.wallsV_i = [1 0 0;1 0 0;0 0 1; 0 1 0];%laby 4x4 %  dimension can change
    %labyInit.wallsV_i =[1 0 0 0 0 0; 1 0 0 0 0 0; 1 1 1 0 1 0; 0 0 0 0 1 1; 0 0 0 0 0 0; 1 0 0 1 0 1;1 0 0 0 0 0]; %laby 7x7

    % Horizontals walls  (dimension can change)
    labyInit.wallsH_i=[0 0 0 1 0; 0 1 0 1 0;0 1 0 1 0;0 1 0 0 1];%laby 5x5
    %labyInit.wallsH_i =  [1 0 0; 1 0 0]; %laby 3x3
    %labyInit.wallsH_i =  [0 0 1 0;  1 0 0 0; 0 1 0 1];%laby 4x4
    %labyInit.wallsH_i=   [0 0 0 0 0 1 1; 0 0 1 0 0 1 1;0 1 0 0 0 0 0;0 0 0 0 0 1 0;0 1 1 1 0 0 1;0 0 1 1 0 1 0];%laby 7x7
    % Pacman position (static dimension)
    labyInit.pacman_i = [2,	1];
    % Escape position (static dimension)
    labyInit.escape_i = {[5 5], 0};

    %%%%%%%%% commands

    % Initial value of walls command
    wallsInit.wallsCommand_i = 0;
    % =0 : begin with right move
    % =1 : begin with up move

    % Initial value of pacman command (if command change, dimension can change, else not)
    pacmanInit.pacmanCommand_i= zeros(1,5);

    % initial value of stop
    stopInit.escape = 0;
    stopInit.pacman = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
% ================================================================
%> @brief Automatic generated function by GUI
%> @param hObject    handle to figure
%> @param eventdata  reserved - to be defined in a future version of MATLAB
%> @param handles    structure with handles and user data (see GUIDATA)
%> @return varargout  cell array for returning output args (see VARARGOUT);
% ================================================================
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
% ===============================================================
%> @brief Callback for all the action's buttons (see detailed explications).
%> in the following image, buttons marked with a black arrow lanch this Callback. \n
%> \image html img_fig_lab.png "button's type of GUI"
%> \image latex img_fig_lab.png "button's type of GUI" width=10cm
%> This callback lanch orderer method of Wrapper class, which allows the simulation to evolve.
%> @param hObject    handle to actived button
%> @param eventdata  reserved - to be defined in a future version of MATLAB
%> @param handles    structure with handles and user data (see GUIDATA)
% ===============================================================
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
        8  : empty
        9  : empty
        10 : empty
        11 : empty
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
% ===============================================================
%> @brief Callback for all the connection's buttons (see detailed explications).
%> in the following image, buttons marked with a red arrow lanch this Callback. \n
%> \image html img_fig_lab.png "button's type of GUI"
%> \image latex img_fig_lab.png "button's type of GUI" width=8cm
%> This callback lanch updateConnexion method of Wrapper class, which modify what command are automatic.
%> @param hObject    handle to actived button
%> @param eventdata  reserved - to be defined in a future version of MATLAB
%> @param handles    structure with handles and user data (see GUIDATA)
% ===============================================================
function connect_Callback(hObject, eventdata, handles)
%{
        hObject.UserData :
            100 : connectWalls
            101 : empty
            102 : connectPacman
%}
    handles.wrapper= handles.wrapper.updateConnexion(hObject.UserData-99,hObject.Value); % 1:walls ; 2:nothing ; 3:pacman
    connection = '';
    hObject.UserData
    switch hObject.UserData
        case 100
            connection = 'wallsPanel';
        case 102
            connection = 'pacmanPanel';
    end

    set(handles.(connection),'Visible',isOne(~hObject.Value));
    if(handles.wrapper.wallsBit || handles.wrapper.pacmanBit )
        set(handles.step,'Visible','on');
    else
        set(handles.step,'Visible','off');
    end
    guidata(hObject,handles);
end
% ===============================================================

%%          Creation of the Pacman, the Walls and the Escape

% --- Create a graphical element for ghost
% ===============================================================
%> @brief Creation of the graphical object "pacman".
%> The pacman is created by using the patch function and store into the handle in 'pacman'.
%> @param handles    structure with handles and user data (see GUIDATA)
%> @return h the updated structure with handles and user data (see GUIDATA)
% ===============================================================
function h = createUIPacman(handles)
    hold on;
    h = handles;
    axes(h.axes1);
    h.pacmanPositionInit  = [1 2];% initial position of the pacman object in the labyrinth
    h.pacmanColor         = [0 .5 0] ; % dark green
    nbPts = 32; %number of point who compose the pacman
    rayon = 1/3; %size
    %%%%%%%%

    pos = pi/6:(5/3*pi)/(nbPts-1) :11/6*pi;
    x = [0,rayon*cos(pos)]     + h.pacmanPositionInit(1)-.5;
    y = [0,rayon*sin(pos)]     + h.pacmanPositionInit(2)-.5;
    h.pacman = patch(x,y,h.pacmanColor);
    %%%%%%%%%
    hold off;
end



% --- Create a graphical element for walls
% ===============================================================
%> @brief Creation of the graphical objects "walls".
%> The walls are created as two line elmenents matrix. They are stored into handles in 'walls'. \n
%> The first matrix is for the verticals walls and named 'horizontals' and the second called 'verticals' for the verticals walls.\n
%> All possible walls are created and it is by making them visible or invisible that they appear or disappear.
%> @param handles    structure with handles and user data (see GUIDATA)
%> @return h the updated structure with handles and user data (see GUIDATA)
% ===============================================================
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
% ===============================================================
%> @brief Creation of the graphical objects "escape".
%> The escape is created whit a rectangle and and text box. It's stored into handles in 'escape'. \n
%> @param handles    structure with handles and user data (see GUIDATA)
%> @return h the updated structure with handles and user data (see GUIDATA)
% ===============================================================
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
% ===============================================================
%> @brief This function update all graphicals element who can change.
%> With the input called 'out', this function lanch all the functions who update a specific graphical element.
%> @param handles Structure with handles and user data (see GUIDATA)
%> @param out Cell who contain all informations needed from the wrapper for update the graphical interface.
% ===============================================================
function updateUI(handles,out)

    updateUIPlayer( handles,'pacman', out{1});      %(1,2)
    updateUIWalls( handles.walls , out{3},out{4});           %(3,4)
    %
    updateUIActiveCammand(handles);
    updateUIButton(handles);
    %
    updateUIEscape(handles.Escape,out{6});          %(6)
    updateUIWallsAround(handles,'Pacman',out{7}); %(7) for pacman
end

% --- Update visibility of command panel for only see the possibles
% commands on the good time
% ===============================================================
%> @brief Update visibility of control panel, connection and step button.
%> This function show or hide the control's panels and the connection's buttons according whit who will move. It also show step button if a command is connected. \n
%> Example : if is pacman time to move and command is not connected, this function hide walls and step element and show pacman one's.
%> @param handles    structure with handles and user data (see GUIDATA)
% ===============================================================
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
     if(handles.wrapper.pacmanBit == 1) % si connect�
         set(handles.pacmanPanel,'Visible','off');
         set(handles.step,'Visible','on');
     else % si pas connect�
         set(handles.pacmanPanel,'Visible','on');
         set(handles.step,'Visible','off');
     end
    else
     set(handles.connectPacman,'Visible','off');
     set(handles.pacmanPanel,'Visible','off');
    end

    %% walls
    if(handles.wrapper.whoPlay == 0 )% si a son tour
     set(handles.connectWalls,'Visible','on');
     if(handles.wrapper.wallsBit == 1) % si connect�
         set(handles.wallsPanel,'Visible','off');
         set(handles.step,'Visible','on');
     else % si pas connect�
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
% ===============================================================
%> @brief Show the needed moving buttons.
%> This function show the direction's buttons allows by the output informations of modelLaby and hide the others one.
%> @param handles    structure with handles and user data (see GUIDATA)
% ===============================================================
function updateUIButton(handles)
    player = {'pacman'};
    possibleMoves = cell(1,4);
        possibleMoves(1,:)=cell(strcat(player ,{'Up','Down','Left','Right'},'But'));


        for i = 1:max(size(possibleMoves,2))
            set(handles.(possibleMoves{1,i}) ,'Visible',isOne(~handles.wrapper.out{7}(i)));
        end

end

% --- Update graphical place of a player (only pacman in this case).
% ===============================================================
%> @brief Update graphical place of a player (only pacman in this case).
%> This function, with the actual position (present in the handles) and the new one as a input, move object. \n
%> The dynamics of movement is defined by this foncion \f$ out(t) = \frac{\frac{om+1}{om*e^{cv*t}+1}-1}{om} \f$
%> for \f$ t \in [0,1]\f$, \f$ om = 72.89105\f$ and \f$ cv = -11.27357 \f$.
%> \image html obj_dynamic.png "Dynamics of movement"
%> \image latex obj_dynamic.png "Dynamics of movement" width=8cm
%> @param strPlayer String contain the exact name of the object to move.
%> @param position new position of the object. format : [x y]
%> @param handles    structure with handles and user data (see GUIDATA)
% ===============================================================
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
