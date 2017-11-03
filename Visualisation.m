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
        
        function obj = actuVisu(newPacman,newGhost, newMurs)
        %fonction qui affiche les murs que pacman voit
            obj.pacman =newPacman;
            obj.ghost=newGhost;
            obj.murs=newMurs;
        end
        
        %%  Vue des murs de l'objet :
        % Fonction :    Actualise la figure avec les murs affichées
        %               Actualise l'objet appelé dans la classe
        %               Visualisation.
        % Entrées : handles de la figure
        %           objet de visualisation
        %           string pour indiquer quel objet 
        % Sortie :  Aucune
        function  vue_pacman(obj,handles, myObj)
            
           [myVisu, myWall, myGhost] = getElement(handles, 'visu', 'murs','ghost');
            if(deplacementHautPossible(myObj, myWall) == 0) %il y a un mur
                display('Mur Haut')
                set(handles.PacmanUp,'BackgroundColor','b');
            else
                set(handles.PacmanUp,'BackgroundColor',[0.8 0.8 0.8]);
            end
            
            if(deplacementBasPossible(myObj, myWall)==0)
                set(handles.PacmanDown,'BackgroundColor','b');
                display('Mur Bas')
            else
                set(handles.PacmanDown,'BackgroundColor',[0.8 0.8 0.8]);
            end
            
            if(deplacementGauchePossible(myObj, myWall)==0)
                display('Mur Gauche')
                set(handles.PacmanLeft,'BackgroundColor','b');
            else
                set(handles.PacmanLeft,'BackgroundColor',[0.8 0.8 0.8]);
            end
            
            if(deplacementDroitePossible(myObj, myWall)==0)
                display('Mur Droite')
                set(handles.PacmanRight,'BackgroundColor','b');
            else
                set(handles.PacmanRight,'BackgroundColor',[0.8 0.8 0.8]);
            end
            myVisu.pacman = myObj;
            myVisu.ghost = myGhost;
            visu = myVisu;
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


