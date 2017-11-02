classdef Sortie
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        positionX;  % Position dans le labyrinthe
        positionY;
        AllPoint = [];
        taille_lab = 5;
        color='g*';
    end
    
    methods
        % Constructor
        function obj=Sortie(handles, color, xPosition, yPosition)
            obj.positionX = xPosition;
            obj.positionY = yPosition;
            axes(handles.axes1);
            hold on
            % x  bas drte
            rectangle('Position',[xPosition-1+.2 , yPosition-1+.2, .6 , .6 ],...
                'Curvature',.1, 'EdgeColor',color,'FaceColor',color);
            text(xPosition-.799 , yPosition-.5,  'Escape',...
                'Color','w',    'FontSize',8   , 'FontWeight','bold');
            hold off
        end
        
%         function escaped = isEscaped(obj,pacman,handles)
%             if ( obj.positionX == pacman.positionX && obj.positionY == pacman.positionY)
%                 escaped = 1; % pacman is on the escape position
%                 set(handles.Sortie,'BackgroundColor','r');
%                 
%             else
%                 escaped = 0;% pacman isn't on the escape position
%             end
%         end
    end
end

