classdef Visualisation
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        pacman;
        ghost;
        murs;
        
        mange;
    end
    
    methods
        
        %constructeur
        function obj=Visualisation(pacman,ghost,murs)
            obj.pacman = pacman;
            obj.ghost=ghost;
            obj.murs=murs;
            obj.mange = 0;
        end
        
        function obj = actuVisu(newPacman,newGhost, newMur)
            %fonction qui affiche les murs que pacman voit
            obj.pacman =new;
            obj.ghost=newGhost;
            obj.murs=murs;
        end
        
        function updateWallView(obj,elementToSet,boolCondition)
            if(boolCondition == 0) %il y a un mur
                set(elementToSet,'BackgroundColor','b');
            else
                set(elementToSet,'BackgroundColor',[0.8 0.8 0.8]);
            end
        end
        
        %%  Vue des murs de l'objet :
        % Fonction :    Actualise la figure avec les murs affichï¿½es        %               Actualise l'objet appelï¿½ dans la classe        %               Visualisation.
        % Entrï¿½es : handles de la figure        %           objet de visualisation
        %           string pour indiquer quel objet
        % Sortie :  Aucune
        function  localWallsViewer(obj,handles, strObject,modifObj)
            
            % 1 : Identifier l'object qui a changé  (strObject : 'pacman', 'ghost', 'murs')
            % 2 : appliquer les modifs de la visualisation ( modifObj : pacman, ghost, murs)
            
            % 1 : cas pacman a bougé
            if(strcmp('pacman',strObject)) % if is a pacman or a wall
                [myWall] = getElement(handles, 'murs');
                
                pacmanWallsView(obj,handles,modifObj,myWall);
            end
            % 2 : cas ghost a bougé
            if(strcmp('ghost',strObject)) % if is a pacman or a wall
                [myWall] = getElement(handles, 'murs');
                
                ghostWallsView(obj,handles,modifObj,myWall);
            end
            if(strcmp('murs',strObject))
                [myPacman, myGhost] = getElement(handles, 'pacman', 'ghost');
                
                ghostWallsView(obj,handles,myGhost,modifObj);
                pacmanWallsView(obj,handles,myPacman,modifObj);
            end
        end
        
        function pacmanWallsView(obj,handles,objct,walls)
            obj.updateWallView(handles.PacmanUp,deplacementHautPossible(objct, walls))
            obj.updateWallView(handles.PacmanDown,deplacementBasPossible(objct, walls))
            obj.updateWallView(handles.PacmanLeft,deplacementGauchePossible(objct, walls))
            obj.updateWallView(handles.PacmanRight,deplacementDroitePossible(objct, walls))
        end
        function ghostWallsView(obj,handles,objct,walls)
            obj.updateWallView(handles.GhostUp,deplacementHautPossible(objct, walls))
            obj.updateWallView(handles.GhostDown,deplacementBasPossible(objct, walls))
            obj.updateWallView(handles.GhostLeft,deplacementGauchePossible(objct, walls))
            obj.updateWallView(handles.GhostRight,deplacementDroitePossible(objct, walls))
        end
        %%
        function obj = detection_manger(obj,chat,souris, mur)
            
            % Test sur la position en X
            if ((souris.positionX == chat.positionX+1)&&(souris.positionY == chat.positionY))
                % Test si le chat peutr aller vers la souris
                if(deplacementDroitePossible(chat, mur))
                    obj.mange = obj.mange+1;
                    display('souris a droite')
                end
            end
            if ((souris.positionX == chat.positionX-1)&&(souris.positionY == chat.positionY))
                % Test si le chat peutr aller vers la souris
                if(deplacementGauchePossible(chat, mur))
                    display('souris a gauche')
                    obj.mange = obj.mange+1;
                end
            end
            % Test sur la position en Y
            if ((souris.positionY == chat.positionY+1)&&(souris.positionX == chat.positionX))
                % Test si le chat peutr aller vers la souris
                if(deplacementHautPossible(chat, mur))
                    obj.mange = obj.mange+1;
                    display('souris en haut')
                end
            end
            if ((souris.positionY == chat.positionY-1)&&(souris.positionX == chat.positionX))
                % Test si le chat peutr aller vers la souris
                if(deplacementBasPossible(chat, mur))
                    obj.mange = obj.mange+1;
                    display('souris en bas')
                end
            end
        end
    end
end


