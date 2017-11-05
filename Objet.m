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
        
        %% 
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
            out = 1;
            switch nextMove
                case 'right'
                    if(obj.positionY == handles.ghost.positionY)
                        if(obj.positionX == handles.ghost.positionX-1)
                            out = 0;
                        end
                        if(obj.positionX == handles.pacman.positionX-1)
                            out = 0;
                        end
                    end
                case 'left'
                    if(obj.positionY == handles.ghost.positionY)
                        if(obj.positionX == handles.ghost.positionX+1)
                            out = 0;
                        end
                        if(obj.positionX == handles.pacman.positionX+1)
                            out = 0;
                        end
                    end
                case 'up'
                    if(obj.positionX == handles.ghost.positionX)
                        if(obj.positionY == handles.ghost.positionY-1)
                            out = 0;
                        end
                        if(obj.positionY == handles.pacman.positionY-1)
                            out = 0;
                        end
                    end
                case 'down'
                    if(obj.positionX == handles.ghost.positionX)
                        if(obj.positionY == handles.ghost.positionY+1)
                            out = 0;
                        end
                        if(obj.positionY == handles.pacman.positionY+1)
                            out = 0;
                        end 
                    end
            end
        end
        
        
        
        %% D?placement de l'objet
        
        function obj = goRight(handles, obj, w)
           if(obj.positionX < obj.sizeTab)
               if(canGoRight( obj, w))
                   if(obj.isObjectNext(handles,'right'))
                        obj.positionX = obj.positionX+1;
                   end
               end
           end
           displayObject(handles,obj);
        end
        
        function obj = goLeft(handles, obj, w)
           if(obj.positionX > 1)
               if(canGoLeft( obj, w))
                   if(obj.isObjectNext(handles,'left'))
                        obj.positionX = obj.positionX-1;
                   end
               end
           end
           displayObject(handles,obj);
        end
        
        function obj = goUp(handles, obj, w)
           if(obj.positionY < obj.sizeTab)
               if(canGoUp( obj, w))
                   if(obj.isObjectNext(handles,'up'))
                        obj.positionY = obj.positionY+1;
                   end
               end
           end
           displayObject(handles,obj);
        end
        
        function obj = goDown(handles, obj, w)
           if(obj.positionY > 1)
               if(canGoDown(obj, w))
                   if(obj.isObjectNext(handles,'down'))
                        obj.positionY = obj.positionY-1;
                   end
               end
           end
           displayObject(handles,obj);
        end
        

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