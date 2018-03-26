function varargout = LabyMenu(varargin)
% LABYMENU MATLAB code for LabyMenu.fig
%      LABYMENU, by itself, creates a new LABYMENU or raises the existing
%      singleton*.
%
%      H = LABYMENU returns the handle to a new LABYMENU or the handle to
%      the existing singleton*.
%
%      LABYMENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LABYMENU.M with the given input arguments.
%
%      LABYMENU('Property','Value',...) creates a new LABYMENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LabyMenu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LabyMenu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LabyMenu

% Last Modified by GUIDE v2.5 22-Mar-2018 11:12:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LabyMenu_OpeningFcn, ...
                   'gui_OutputFcn',  @LabyMenu_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before LabyMenu is made visible.
function LabyMenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LabyMenu (see VARARGIN)

% Choose default command line output for LabyMenu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LabyMenu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LabyMenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OneEasy.
function OneEasy_Callback(hObject, eventdata, handles)
% hObject    handle to OneEasy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   
setappdata(0,'init',init);
figure_Laby();
 %handles.walls.horizontals




% --- Executes on button press in TwoHard.
function TwoHard_Callback(hObject, eventdata, handles)
% hObject    handle to TwoHard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in TwoMedium.
function TwoMedium_Callback(hObject, eventdata, handles)
% hObject    handle to TwoMedium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in TwoEasy.
function TwoEasy_Callback(hObject, eventdata, handles)
% hObject    handle to TwoEasy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in OneMedium.
function OneMedium_Callback(hObject, eventdata, handles)
% hObject    handle to OneMedium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in OneHard.
function OneHard_Callback(hObject, eventdata, handles)
% hObject    handle to OneHard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
