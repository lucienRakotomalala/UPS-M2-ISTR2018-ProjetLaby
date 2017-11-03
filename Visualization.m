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
        % --- 
        function seen = isSeenRight(obj,pacman,ghost,walls)
        % if( pacman is on the same line and at the right of ghost and
        %     without walls between them)
        %     seen = 1;
        % else 
        %     seen = 0;
        % end
        seen = 0;
            if ( ( pacman.positionY ==ghost.positionY )  && (pacman.positionX >ghost.positionX ) )
                if( ) % TODO : no walls between them   
                    seen= 1;
                end
                
            end
        
        end
        
        function seen = isSeenLeft(obj,pacman,ghost,walls)
        end

        function seen = isSeenDown(obj,pacman,ghost,walls)
        end
        function seen = isSeenUp(obj,pacman,ghost,walls)
        end

        
        function updateWallView(obj,elementToSet,boolCondition)
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
        
        function pacmanWallsView(obj,handles,objct,walls)
            obj.updateWallView(handles.PacmanUp,canGoUp(objct, walls))
            obj.updateWallView(handles.PacmanDown,canGoDown(objct, walls))
            obj.updateWallView(handles.PacmanLeft,canGoLeft(objct, walls))
            obj.updateWallView(handles.PacmanRight,canGoRight(objct, walls))
        end
        function ghostWallsView(obj,handles,objct,walls)
            obj.updateWallView(handles.GhostUp,canGoUp(objct, walls))
            obj.updateWallView(handles.GhostDown,canGoDown(objct, walls))
            obj.updateWallView(handles.GhostLeft,canGoLeft(objct, walls))
            obj.updateWallView(handles.GhostRight,canGoRight(objct, walls))
        end
        %%
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


