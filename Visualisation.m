classdef Visualisation
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        pacman;
        ghost;
        murs;
        
        mange = 0;
    end
    
    methods
        
        %constructeur
        function obj=Visualisation(pacman,ghost,murs)
            obj.pacman = pacman;
            obj.ghost=ghost;
            obj.murs=murs;
        end
        
        %fonction qui affiche les murs que pacman voit
        function  vue_pacman(obj)
            if(pacman.deplacementHautPossible()==0) %il y a un mur
                set(handles.PacmanUp,'BackgroundColor','b');
            else
                set(handles.PacmanUp,'BackgroundColor',[0.8 0.8 0.8]);
            end
            
            if(pacman.deplacementBasPossible()==0)
                set(handles.PacmanDown,'BackgroundColor','b');
            else
                set(handles.PacmanDown,'BackgroundColor',[0.8 0.8 0.8]);
            end
            
            if(pacman.deplacementGauchePossible()==0)
                set(handles.PacmanLeft,'BackgroundColor','b');
            else
                set(handles.PacmanLeft,'BackgroundColor',[0.8 0.8 0.8]);
            end
            
            if(pacman.deplacementDroitePossible()==0)
                set(handles.PacmanRight,'BackgroundColor','b');
            else
                set(handles.PacmanRight,'BackgroundColor',[0.8 0.8 0.8]);
            end
        end
        
        function obj = detection_manger(obj,chat,souris, mur)
            % Test sur la position en X
            if (souris.positionX == chat.positionX+1)
                % Test si le chat peutr aller vers la souris
                if(chat.deplacementDroitePossible(chat, mur))
                   obj.mange = obj.mange+1; 
                end
            end
            if (souris.positionX == chat.positionX-1)
                % Test si le chat peutr aller vers la souris
                if(chat.deplacementGauchePossible(chat, mur))
                   obj.mange = obj.mange+1; 
                end
            end            
        end
    end
end


