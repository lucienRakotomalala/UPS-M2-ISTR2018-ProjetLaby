classdef Visualisation
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        pacman;
        ghost;
        murs;
   
    end
    
    methods
        
        %constructeur
        function obj=Visualisation(handles,pacman,ghost,murs)
            obj.pacman = pacman;
            obj.ghost = ghost;
            obj.murs=murs;
            
        end
        
        %fonction qui affiche les murs que pacman voit
        function  vue_pacman(handles,obj)
            
            
            if(deplacementHautPossible(handles, obj.pacman, obj.murs) == 0) %il y a un mur
                set(handles.PacmanUp,'BackgroundColor','b');
            else
                set(handles.PacmanUp,'BackgroundColor',[0.8 0.8 0.8]);
            end
            
            if(deplacementBasPossible(handles, obj.pacman, obj.murs)==0)
                set(handles.PacmanDown,'BackgroundColor','b');
            else
                set(handles.PacmanDown,'BackgroundColor',[0.8 0.8 0.8]);
            end
            
            if(deplacementGauchePossible(handles, obj.pacman, obj.murs)==0)
                set(handles.PacmanLeft,'BackgroundColor','b');
            else
                set(handles.PacmanLeft,'BackgroundColor',[0.8 0.8 0.8]);
            end
            
            if(deplacementDroitePossible(handles, obj.pacman, obj.murs)==0)
                set(handles.PacmanRight,'BackgroundColor','b');
            else
                set(handles.PacmanRight,'BackgroundColor',[0.8 0.8 0.8]);
            end
        end
    end
end


