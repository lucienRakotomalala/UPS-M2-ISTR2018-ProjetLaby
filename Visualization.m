classdef Visualization
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        caught;
    end
    
    methods
        
        %constructeur
        function obj=Visualization()
            obj.caught = 0;
        end
        %% Returns 1 if ghost sees pacman on his right, else return 0.
        function seen = isSeenRight(obj,pacman,ghost,walls)
            % if( pacman is on the same line and at the right of ghost and
            %     without walls between them)
            %     seen = 1;
            % else
            %     seen = 0;
            % end
            seen = 0;
            if ( ( pacman.positionY == ghost.positionY )  && (pacman.positionX > ghost.positionX ) )
                if(sum(walls.verticalWalls(walls.labSize-ghost.positionY+1, ghost.positionX : pacman.positionX-1  ) )==0 ) % TODO : no walls between them                    
                    seen= 1;
                end
            end
        end
        %% Return 1 if ghost sees pacman on his left, else return 0.
        function seen = isSeenLeft(obj,pacman,ghost,walls)
            % if( pacman is on the same line and at the left of ghost and
            %     without walls between them)
            %     seen = 1;
            % else
            %     seen = 0;
            % end
            seen = 0;
            if ( ( pacman.positionY == ghost.positionY )  && (pacman.positionX < ghost.positionX ) )
                if(sum(walls.verticalWalls(walls.labSize-ghost.positionY+1, pacman.positionX : ghost.positionX-1  ) )==0 ) % TODO : no walls between them
                    seen= 1;
                end
            end
        end
        %% Return 1 if ghost sees pacman below him, else return 0.
        function seen = isSeenDown(obj,pacman,ghost,walls)
            % if( pacman is on the same colonn and below the ghost and
            %     without walls between them)
            %     seen = 1;
            % else
            %     seen = 0;
            % end
            seen = 0;
            
            yGhost  = walls.labSize- ghost.positionY +1;
            yPacman = walls.labSize- pacman.positionY +1;
            
             if ( ( pacman.positionX == ghost.positionX )  && (yPacman > yGhost) )
                if(sum(walls.horizontalWalls( yGhost : yPacman-1 , ghost.positionX) )==0 ) % TODO : no walls between them
                    seen= 1;
                 end
            end
        end
        %% Return 1 if ghost sees pacman on top of him, else return 0. 
        function seen = isSeenUp(obj,pacman,ghost,walls)
            % if( pacman is on the same colonn and above the ghost and
            %     without walls between them)
            %     seen = 1;
            % else
            %     seen = 0;
            % end
            seen = 0;
            yGhost  = walls.labSize- ghost.positionY +1;
            yPacman = walls.labSize- pacman.positionY +1;
            if ( ( pacman.positionX ==ghost.positionX )  && (yPacman < yGhost) )
                if(sum(walls.horizontalWalls( yPacman : yGhost-1  , ghost.positionX) )==0 ) % TODO : no walls between them
                    seen= 1;                    
                end
            end
        end
        
        %% This function show when Ghost see pacman
        function ghostSeePacman(obj,handles)
            
            obj.updatePresenceDetectorDisplay(handles.SeeRight  , ~isSeenRight(  obj,handles.pacman,handles.ghost,handles.w));
            obj.updatePresenceDetectorDisplay(handles.SeeLeft   , ~isSeenLeft(   obj,handles.pacman,handles.ghost,handles.w));
            obj.updatePresenceDetectorDisplay(handles.SeeUp     , ~isSeenUp(     obj,handles.pacman,handles.ghost,handles.w));
            obj.updatePresenceDetectorDisplay(handles.SeeDown   , ~isSeenDown(   obj,handles.pacman,handles.ghost,handles.w));
        end
        %% This function update the color of a UI element
        function updatePresenceDetectorDisplay(obj,elementToSet,boolCondition)
            if(boolCondition == 0) %il y a un mur
                set(elementToSet,'BackgroundColor','b');
            else
                set(elementToSet,'BackgroundColor',[0.8 0.8 0.8]);
            end
        end
        
        %%  Vue des walls de l'objet :
        % Fonction :    Actualise la figure avec les walls affich�es        %               Actualise l'objet appel� dans la classe        %               Visualization.
        % Entr�es : handles de la figure        %           objet de visualisation
        %           string pour indiquer quel objet
        % Sortie :  Aucune
        function  localWallsViewer(obj,handles, strObject,modifObj)
            
            % 1 : Identifier l'object qui a chang�  (strObject : 'pacman', 'ghost', 'walls')
            % 2 : appliquer les modifs de la visualisation ( modifObj : pacman, ghost, walls)
            
            % 1 : cas pacman a boug�
            if(strcmp('pacman',strObject)) % if is a pacman or a wall
                [myWall] = getElement(handles, 'walls');
                
                pacmanWallsView(obj,handles,modifObj,myWall);
            end
            % 2 : cas ghost a boug�
            if(strcmp('ghost',strObject)) % if is a pacman or a wall
                [myWall] = getElement(handles, 'walls');
                
                ghostWallsView(obj,handles,modifObj,myWall);
            end
            if(strcmp('walls',strObject))
                [myPacman, myGhost] = getElement(handles, 'pacman', 'ghost');
                
                ghostWallsView(obj,handles,myGhost,modifObj);
                pacmanWallsView(obj,handles,myPacman,modifObj);
            end
        end
        %% This function show the walls around pacman
        function pacmanWallsView(obj,handles,objct,walls)
            obj.updatePresenceDetectorDisplay(handles.PacmanUp,canGoUp(objct, walls))
            obj.updatePresenceDetectorDisplay(handles.PacmanDown,canGoDown(objct, walls))
            obj.updatePresenceDetectorDisplay(handles.PacmanLeft,canGoLeft(objct, walls))
            obj.updatePresenceDetectorDisplay(handles.PacmanRight,canGoRight(objct, walls))
        end
        
        %% This function show the walls around ghost
        function ghostWallsView(obj,handles,objct,walls)
            obj.updatePresenceDetectorDisplay(handles.GhostUp,canGoUp(objct, walls))
            obj.updatePresenceDetectorDisplay(handles.GhostDown,canGoDown(objct, walls))
            obj.updatePresenceDetectorDisplay(handles.GhostLeft,canGoLeft(objct, walls))
            obj.updatePresenceDetectorDisplay(handles.GhostRight,canGoRight(objct, walls))
        end
        %% This function count and show when ghost caught pacman
        function obj = caughtDetection(obj,handles,ghost,pacman, walls)
            newStr = handles.Caught.String(1:end-1);
            newClr = [.8 .8 .8];
            % Test sur la position en X
            if ((pacman.positionX == ghost.positionX+1)&&(pacman.positionY == ghost.positionY))
                % Test si le chat peutr aller vers la souris
                if(canGoRight(ghost, walls))
                    obj.caught = obj.caught+1;
                     newClr = 'r';
                end
            end
            if ((pacman.positionX == ghost.positionX-1)&&(pacman.positionY == ghost.positionY))
                % Test si le chat peutr aller vers la souris
                if(canGoLeft(ghost, walls))
                    obj.caught = obj.caught+1;
                    newClr = 'r';
                end
            end
            % Test sur la position en Y
            if ((pacman.positionY == ghost.positionY+1)&&(pacman.positionX == ghost.positionX))
                % Test si le chat peutr aller vers la souris
                if(canGoUp(ghost, walls))
                    obj.caught = obj.caught+1;
                    newClr = 'r';
                end
            end
            if ((pacman.positionY == ghost.positionY-1)&&(pacman.positionX == ghost.positionX))
                % Test si le chat peutr aller vers la souris
                if(canGoDown(ghost, walls))
                    obj.caught = obj.caught+1;
                    newClr = 'r';
                end
            end
            set(handles.Caught,'BackgroundColor',newClr);
            set(handles.Caught,'String',strcat(newStr,int2str(obj.caught)));
        end
    end
end


