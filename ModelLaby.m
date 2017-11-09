classdef ModelLaby < ModelSED
    %MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        presentState;
    end
    
    methods

        % Entrée du model labyrinthe : in
        % Cette entrée correspond aux sorties des commandes de obj1 (pacman),
        % obj2(ghost) et des murs. Les commandes vont écrire sur le m^me vecteur : in,
        % en mettant la valeur de commande choisit à 1.
        
        
        % Librairie des commandes, vecteur in : Voir le Callback de
        % figure_Laby

        %% --- Evolution of the labyrinth 
        function nextState = f(obj, in)
            
            nextState = obj.presentState;
            if(in(1) == 1) % Initial
                
            end
            if(in(2) == 1) % Walls Vertical moves to the right
                        nextState.wallsV = [obj.presentState.wallsV(:,size(obj.presentState.wallsV,2)) obj.presentState.wallsV(:,1:size(obj.presentState.wallsV,2)-1)];       
            end
            if(in(3) == 1) % Walls Horizontal moves down
                        nextState.wallsH = [obj.presentState.wallsH(size(obj.presentState.wallsH,1),:); obj.presentState.wallsH(1:size(obj.presentState.wallsH,1)-1,:)];
            end
            if(in(4) == 1) % Pacman get left
                        
            end
             if(in(5) == 1) % Pacman get Up
                 
             end
             if(in(6) == 1) % Pacman get right
                
             end
             if(in(7) == 1) % Pacman get Down
                 
             end
             
             if(in(8) == 1) %Ghost get Left
                 
             end
             
             if(in(9) == 1) % Ghost get Up
                 
             end
             
             if(in(10) == 1) % Ghost get Right
                
             end
             
             if(in(11) == 1) % Ghost get Down
                 
             end
             %Default case
             if(in(:) == 0)
                 'Error'
                 nextState = obj.presentState;
             end
        end
        %% --- Memory 
        function m(obj,nextState, init)
            
            if(init == 1)
                obj.presentState.wallsV =  [1 0 0 0; 0 0 1 0; 1 0 0 0; 1 0 1 0; 0 0 1 0];
                obj.presentState.wallsH =  [1 0 1 0 1; 1 0 1 0 1; 1 0 1 0 1; 0 1 0 1 0]; 
                obj.presentState.pacman = [2 2];
                obj.presentState.ghost  = [5 5];
                obj.presentState.escape = 0;
                obj.presentState.caught = 0;
            else
                obj.presentState = nextState;
            end
        end
        %% -- Generation of the output 
        function  out = g(obj)
            % walls Around pacman
            Wup_pacman = [1; obj.presentState.wallsH(1:obj.presentState.pacman(1)-1, obj.presentState.pacman(2))];
            Wdown_pacman = [obj.presentState.wallsH(obj.presentState.pacman(1):size(obj.presentState.wallsH,1), obj.presentState.pacman(2)); 1];
            WLeft_pacman = [1 obj.presentState.wallsV(obj.presentState.pacman(1), 1:obj.presentState.pacman(2)-1)];
            WRight_pacman = [obj.presentState.wallsV(obj.presentState.pacman(1), obj.presentState.pacman(2):size(obj.presentState.wallsV,2)) 1];

            wallsAroundPacman = [Wup_pacman(end) Wdown_pacman(1) WLeft_pacman(end) WRight_pacman(1)]; % Walls Up, Down, Left and Right around the pacman
            
            % Sortie lue par les autres commandes (elles doievent le
            % considérer comme une entrée)
            out = {obj.presentState.pacman, obj.presentState.ghost, ...
                    obj.presentState.wallsV, obj.presentState.wallsH, ...
                    obj.presentState.caught, obj.presentState.escap, ...
                    wallsAroundPacman 
                  };        
        end
    
        %%
        function can = canGoLeft(obj, myObj, w)
                can=0;
                if(myObj.positionX>1)
                    if (w.verticalWalls(myObj.sizeTab-myObj.positionY+1, myObj.positionX-1)==0)
                        can=1;
                    end
                end
        end
                    %Autoriser deplacement Haut
        function can = canGoUp(obj, myObj, w)
            can=0;
            if(myObj.positionY<myObj.sizeTab)
                if (w.horizontalWalls(myObj.sizeTab-myObj.positionY, myObj.positionX)==0)
                    can=1;
                end
            end
        end
                %Autoriser deplacement Bas
        function can = canGoDown(obj, myObj, w)
            can=0;
            if(myObj.positionY>1)

                if (w.horizontalWalls(myObj.sizeTab-myObj.positionY+1, myObj.positionX)==0)
                    can=1;
                end
            end
        end
        
                %Autoriser deplacement Droite
        function can = canGoRight(obj, myObj, w)
            can=0;
            if(myObj.positionX<5)
                if (w.verticalWalls(myObj.sizeTab-myObj.positionY+1, myObj.positionX)==0)
                    can=1;
                end
            end
        end
    
  
    end
end

%% Princpe de la commande : 
% Lire les sories de model Laby communiqué avec le wrapper. (Est ce que le
% wrapper ne donne à la commande uniquement les sorties qu'il
% l'intéresse ??? )
% Aparir de ces sortie faire évoluer l'état : étatsSuivant = ...
% Dans cet état, pour un objet, on y trouve toutes les informaions que l'on
% souhaite enregistré.Sapeut etre sa position, ou bien le nombre de fois
% qu'il a pu avancer... Sa dépend de la construction de l'utomate ou MAE
% faite avant.
% Actionner la commande sur les entrées de model Laby, communiqué par le
% wrapper.

