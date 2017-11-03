classdef Escape
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        positionX;  % Position dans le labyrinthe
        positionY;
        AllPoint = [];
        labSize = 5;
    end
    
    methods
        % Constructor
        function obj=Escape(handles, color, xPosition, yPosition)
            obj.positionX = xPosition;
            obj.positionY = yPosition;
            axes(handles.axes1);
            set(handles.Escape,'BackgroundColor',[.8 .8 .8]);
            set(handles.Escape,'String','Escaped Pacman :');
            hold on
            % x  bas drte
            rectangle('Position',[xPosition-1+.2 , yPosition-1+.2, .6 , .6 ],...
                'Curvature',.1, 'EdgeColor',color,'FaceColor',color);
            text(xPosition-.799 , yPosition-.5,  'Escape',...
                'Color','w',    'FontSize',8   , 'FontWeight','bold');
            hold off
        end
        
        function escaped = isEscaped(obj,pacman,handles)
            if ( (obj.positionX == pacman.positionX) && (obj.positionY == pacman.positionY) )
                escaped = 1; % pacman is on the escape position
                set(handles.Escape,'BackgroundColor','r');
                set(handles.Escape,'String','Escaped Pacman : Yes');
            else
                escaped = 0;% pacman isn't on the escape position
                set(handles.Escape,'BackgroundColor',[.8 .8 .8]);
                
            end
        end
    end
end

