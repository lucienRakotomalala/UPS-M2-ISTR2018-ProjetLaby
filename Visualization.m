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
        %% ---
        function noSeen = isSeenRight(obj,pacman,ghost,walls)
            % if( pacman is on the same line and at the right of ghost and
            %     without walls between them)
            %     noSeen = 0;
            % else
            %     noSeen = 1;
            % end
            noSeen = 1;
            %disp(fprintf('Same line %d \n',pacman.positionY ==ghost.positionY));
            
            %disp(fprintf('Pacman is on the left ghost %d\n',pacman.positionX >ghost.positionX ));
            %disp(fprintf('x : %d , y : (%d:%d)  \n',walls.labSize-ghost.positionY+1,ghost.positionX , pacman.positionX-1 ));
            
            if ( ( pacman.positionY ==ghost.positionY )  && (pacman.positionX >ghost.positionX ) )
                if(sum(walls.verticalWalls(walls.labSize-ghost.positionY+1, ghost.positionX : pacman.positionX-1  ) )==0 ) % TODO : no walls between them
                    %disp(fprintf('x : %d , y : (%d:%d)  \n',walls.labSize-ghost.positionY+1,ghost.positionX , pacman.positionX-1 ));
                    %disp(fprintf('walls %d\n',sum(walls.verticalWalls(walls.labSize-ghost.positionY+1, ghost.positionX : pacman.positionX-1  ) )==0 ));
                    
                    noSeen= 0;
                end
            end
        end
        %%
        function noSeen = isSeenLeft(obj,pacman,ghost,walls)
            % if( pacman is on the same line and at the left of ghost and
            %     without walls between them)
            %     noSeen = 0;
            % else
            %     noSeen = 1;
            % end
            noSeen = 1;
            if ( ( pacman.positionY ==ghost.positionY )  && (pacman.positionX <ghost.positionX ) )
                if(sum(walls.verticalWalls(walls.labSize-ghost.positionY+1, pacman.positionX : ghost.positionX-1  ) )==0 ) % TODO : no walls between them
                    noSeen= 0;
                end
            end
        end
        %%
        function noSeen = isSeenDown(obj,pacman,ghost,walls)
            % if( pacman is on the same colonn and below the ghost and
            %     without walls between them)
            %     noSeen = 0;
            % else
            %     noSeen = 1;
            % end
            noSeen = 1;
            disp(fprintf('Same colonn %d ',pacman.positionX ==ghost.positionX ));
            disp(fprintf('Pacman is below %d',pacman.positionY > ghost.positionY ));
            disp(fprintf('x : (%d:%d) , y : %d  ',ghost.positionY , pacman.positionY-1,ghost.positionX));            walls.horizontalWalls(ghost.positionY : pacman.positionY-1, ghost.positionX)
            if ( ( pacman.positionX ==ghost.positionX )  && (pacman.positionY > ghost.positionY ) )
                if(sum(walls.horizontalWalls(ghost.positionY : pacman.positionY-1, ghost.positionX) )==0 ) % TODO : no walls between them
                    noSeen= 0;
                    disp('isDown')
                end
            end
        end
        %%
        function noSeen = isSeenUp(obj,pacman,ghost,walls)
            
            % if( pacman is on the same colonn and above the ghost and
            %     without walls between them)
            %     noSeen = 0;
            % else
            %     noSeen = 1;
            % end
            noSeen = 1;
            disp(fprintf('Same colonn %d ',pacman.positionX ==ghost.positionX ));
            disp(fprintf('Pacman is below %d',pacman.positionY < ghost.positionY  ));
            disp(fprintf('x : (%d:%d) , y : %d ',pacman.positionY , ghost.positionY-1, ghost.positionX));
            disp('up')
            walls.horizontalWalls(pacman.positionY : ghost.positionY-1, ghost.positionX)
            if ( ( pacman.positionX ==ghost.positionX )  && (pacman.positionY < ghost.positionY ) )
                if(sum(walls.horizontalWalls(pacman.positionY : ghost.positionY-1, ghost.positionX) )==0 ) % TODO : no walls between them
                    noSeen= 0;
                    disp('isUp')
                    
                end
            end
        end
        
        %% This function show when Ghost see pacman
        function ghostSeePacman(obj,handles)
            clc
            obj.updatePresenceDetectorDisplay(handles.SeeRight  , isSeenRight(  obj,handles.pacman,handles.ghost,handles.w));
            obj.updatePresenceDetectorDisplay(handles.SeeLeft   , isSeenLeft(   obj,handles.pacman,handles.ghost,handles.w));
            obj.updatePresenceDetectorDisplay(handles.SeeUp     , isSeenUp(     obj,handles.pacman,handles.ghost,handles.w));
            obj.updatePresenceDetectorDisplay(handles.SeeDown   , isSeenDown(   obj,handles.pacman,handles.ghost,handles.w));
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
        % Fonction :    Actualise la figure avec les walls affichï¿½es        %               Actualise l'objet appelï¿½ dans la classe        %               Visualization.
        % Entrï¿½es : handles de la figure        %           objet de visualisation
        %           string pour indiquer quel objet
        % Sortie :  Aucune
        function  localWallsViewer(obj,handles, strObject,modifObj)
            
            % 1 : Identifier l'object qui a changé  (strObject : 'pacman', 'ghost', 'walls')
            % 2 : appliquer les modifs de la visualisation ( modifObj : pacman, ghost, walls)
            
            % 1 : cas pacman a bougé
            if(strcmp('pacman',strObject)) % if is a pacman or a wall
                [myWall] = getElement(handles, 'walls');
                
                pacmanWallsView(obj,handles,modifObj,myWall);
            end
            % 2 : cas ghost a bougé
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
        function obj = caughtDetection(obj,ghost,pacman, walls)
            
            % Test sur la position en X
            if ((pacman.positionX == ghost.positionX+1)&&(pacman.positionY == ghost.positionY))
                % Test si le chat peutr aller vers la souris
                if(canGoRight(ghost, walls))
                    obj.caught = obj.caught+1;
                    display('souris a droite')
                end
            end
            if ((pacman.positionX == ghost.positionX-1)&&(pacman.positionY == ghost.positionY))
                % Test si le chat peutr aller vers la souris
                if(canGoLeft(ghost, walls))
                    display('souris a gauche')
                    obj.caught = obj.caught+1;
                end
            end
            % Test sur la position en Y
            if ((pacman.positionY == ghost.positionY+1)&&(pacman.positionX == ghost.positionX))
                % Test si le chat peutr aller vers la souris
                if(canGoUp(ghost, walls))
                    obj.caught = obj.caught+1;
                    display('souris en haut')
                end
            end
            if ((pacman.positionY == ghost.positionY-1)&&(pacman.positionX == ghost.positionX))
                % Test si le chat peutr aller vers la souris
                if(canGoDown(ghost, walls))
                    obj.caught = obj.caught+1;
                    display('souris en bas')
                end
            end
        end
    end
end


