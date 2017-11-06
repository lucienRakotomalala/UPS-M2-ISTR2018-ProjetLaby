classdef Objet 
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
        
    properties
        positionX;  % Position dans le labyrinthe
        positionY;
        AllPoint = [];
        sizeTab = 5;
        color='g*';
    end
    
    methods
        %% Constructor method
        %   Set the position of the object desired
        %   
        %   Plot every position possible on the LAB 
        function obj = Objet(handles, color, positionX, positionY)
            obj.positionX = positionX;
            obj.positionY = positionY;
            x = 1:obj.sizeTab;
            y = 1:obj.sizeTab;
            k = 1;
            axes(handles.axes1);
            hold on 
            for i = x
                for j = y
                   obj.AllPoint = [obj.AllPoint; plot(i -0.5 ,j - 0.5, color)];
                   if(obj.positionX == i) && (obj.positionY==j)
                        set(obj.AllPoint(k,1),'visible','on');
                   else
                       set(obj.AllPoint(k,1),'visible','off');
                   end
                   k = k+1;
               end
           end
        end
        
        %% This funcion update the figure with a last version of the object
        function displayObject(handles, obj)
           axes(handles.axes1);
           hold on
           x = 1:obj.sizeTab;
           y = 1:obj.sizeTab;
           k = 1;
           for i = x
               for j = y
                   if((obj.positionX == i)&&(obj.positionY==j))
                        set(obj.AllPoint(k,1),'visible','on');
                   else
                       set(obj.AllPoint(k,1),'visible','off');
                   end
                   k = k+1;
                end
           end
            
          end
        %% Retourne 1 si le nextMove de l'objet ne l'amène pas sur un autre objet.
        function out = isObjectNext(obj,handles, nextMove)
            % design for 2 objects : pacman and ghost
            % switch : the next move of the object
            %       --> if pacman or ghost is on the next position desired by object
            %           return 0
            %           else return 1.
            out = 1;
            switch nextMove
                case 'right'
                    if(handles.pacman.positionY == handles.ghost.positionY)
                        if(obj.positionX == handles.ghost.positionX-1)
                            out = 0;
                        end
                        if(obj.positionX == handles.pacman.positionX-1)
                            out = 0;
                        end
                    end
                case 'left'
                    if(handles.pacman.positionY == handles.ghost.positionY)
                        if(obj.positionX == handles.ghost.positionX+1)
                            out = 0;
                        end
                        if(obj.positionX == handles.pacman.positionX+1)
                            out = 0;
                        end
                    end
                case 'up'
                    if(handles.pacman.positionX == handles.ghost.positionX)
                        if(obj.positionY == handles.ghost.positionY-1)
                            out = 0;
                        end
                        if(obj.positionY == handles.pacman.positionY-1)
                            out = 0;
                        end
                    end
                case 'down'
                    if(handles.pacman.positionX == handles.ghost.positionX)
                        if(obj.positionY == handles.ghost.positionY+1)
                            out = 0;
                        end
                        if(obj.positionY == handles.pacman.positionY+1)
                            out = 0;
                        end 
                    end
            end
        end
        
        
        
        %% Those functions move the position of the object and update the figure
        %   If the next Move is possible 
        %        AND there are no ghost or pacman on the case desire
        %   THEN    Move the object
           
        % Right Move
        function obj = goRight(handles, obj, myWalls)
            if(obj.canGoRight(myWalls))
                if(obj.isObjectNext(handles,'right'))
                    obj.positionX = obj.positionX+1;
               end
           end
           displayObject(handles,obj);
        end
        
        % Left Move
        function obj = goLeft(handles, obj, myWalls)
               if(obj.canGoLeft(myWalls))
                   if(obj.isObjectNext(handles,'left'))
                        obj.positionX = obj.positionX-1;
                   end
               end
           displayObject(handles,obj);
        end
        
        % Up Move
        function obj = goUp(handles, obj, myWalls)
            if(obj.canGoUp(myWalls))
                if(obj.isObjectNext(handles,'up'))
                    obj.positionY = obj.positionY+1;
                end
            end
            displayObject(handles,obj);
        end
        
        % Down Move
        function obj = goDown(handles, obj, myWalls)
            if(obj.canGoDown(myWalls))
                if(obj.isObjectNext(handles,'down'))
                    obj.positionY = obj.positionY-1;
                end
            end
            displayObject(handles,obj);
        end
        
        %% Those functions look if the next move desire is possible
        % Return 1 if the move desire is in the lab's size AND if there are
        %                                       no wall 
        
        %Autoriser deplacement Haut
        function can = canGoUp(obj, w)
            can=0;
            if(obj.positionY<obj.sizeTab)
                if (w.horizontalWalls(obj.sizeTab-obj.positionY, obj.positionX)==0)
                    can=1;
                end
            end
        end
        
        %Autoriser deplacement Bas
        function can = canGoDown(obj, w)
            can=0;
            if(obj.positionY>1)

                if (w.horizontalWalls(obj.sizeTab-obj.positionY+1, obj.positionX)==0)
                    can=1;
                end
            end
        end
        
        %Autoriser deplacement Droite
        function can = canGoRight(obj, w)
            can=0;
            if(obj.positionX<5)
                if (w.verticalWalls(obj.sizeTab-obj.positionY+1, obj.positionX)==0)
                    can=1;
                end
            end
        end
        
        %Autoriser deplacement Gauche
        function can = canGoLeft(obj, w)
            can=0;
            if(obj.positionX>1)
                if (w.verticalWalls(obj.sizeTab-obj.positionY+1, obj.positionX-1)==0)
                    can=1;
                end
            end
        end

    end
    
end