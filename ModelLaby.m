classdef ModelLaby < ModelSED
    %MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        presentState;
    end
    
    methods

        % Entrï¿½e du model labyrinthe : in
        % Cette entrï¿½e correspond aux sorties des commandes de obj1 (pacman),
        % obj2(ghost) et des murs. Les commandes vont ï¿½crire sur le m^me vecteur : in,
        % en mettant la valeur de commande choisit ï¿½ 1.
        
        
        % Librairie des commandes, vecteur in : Voir le Callback de
        % figure_Laby
        function obj = ModelLaby(obj)
            obj.m(0,1);     % Pas de next State. Initialisation uniquement.
        end

        %% --- Evolution of the labyrinth 
        %   This function countains all evolution possible of laby.
        %
        %   1 part : All the walls move allowed
        %   2 part : All Pacman Move
        %   3 part : All Ghost Move
        %   4 part : Evolution of caught
        function nextState = f(obj, in)
            
            nextState = obj.presentState;
            if(in(1) == 1) % Initial
                
            end
            %% Walls Evolution 
            %
            %   next Walls become an offset matrix of Walls 
            %
            if(in(2) == 1) % Walls Vertical moves to the right
                        nextState.wallsV = [obj.presentState.wallsV(size(obj.presentState.wallsV,1),:); obj.presentState.wallsV(1:size(obj.presentState.wallsV,1)-1,:)];     
            end
            if(in(3) == 1) % Walls Horizontal moves down
                        nextState.wallsH = [obj.presentState.wallsH(:,size(obj.presentState.wallsH,2)) obj.presentState.wallsH(:,1:size(obj.presentState.wallsH,2)-1)];
            end
            
            %% Object Evolution
            % Creation of a upper wall matrix modelling the walls and all
            % contours of the laby
            theWallsAroundV =  myWallsAround(obj.presentState.wallsV);
            theWallsAroundH =  myWallsAround(obj.presentState.wallsH);
            %%
            if(in(4) == 1) % Pacman get left
                        thePacmanWallsV = theWallsAroundV;
                        thePacmanWallsV(obj.presentState.ghost(2)+1,obj.presentState.ghost(1):obj.presentState.ghost(1)+1) = 1;
                        wallLeft = thePacmanWallsV(obj.presentState.pacman(2)+1, 1:obj.presentState.pacman(1));
                        nextState.pacman(1) = obj.presentState.pacman(1) - 1 + wallLeft(end);
            end
             if(in(5) == 1) % Pacman get Up
                        thePacmanWallsH = theWallsAroundH;
                        thePacmanWallsH(obj.presentState.ghost(2):obj.presentState.ghost(2)+1,obj.presentState.ghost(1)+1) = 1;
                        wallUp = thePacmanWallsH(1:obj.presentState.pacman(2), obj.presentState.pacman(1)+1);
                        nextState.pacman(2) = obj.presentState.pacman(2) - 1 + wallUp(end);
             end
             if(in(6) == 1) % Pacman get right
                        thePacmanWallsV = theWallsAroundV;
                        thePacmanWallsV(obj.presentState.ghost(2)+1,obj.presentState.ghost(1):obj.presentState.ghost(1)+1) = 1;
                        wallRight = thePacmanWallsV(obj.presentState.pacman(2)+1, obj.presentState.pacman(1)+1:size(thePacmanWallsV,2));
                        nextState.pacman(1) = obj.presentState.pacman(1) + 1 - wallRight(1);
             end
             if(in(7) == 1) % Pacman get Down
                        thePacmanWallsH = theWallsAroundH;
                        thePacmanWallsH(obj.presentState.ghost(2):obj.presentState.ghost(2)+1,obj.presentState.ghost(1)+1) = 1;
                        wallDown = thePacmanWallsH(obj.presentState.pacman(2)+1:size(thePacmanWallsH,1), obj.presentState.pacman(1)+1);
                        nextState.pacman(2) = obj.presentState.pacman(2) + 1 - wallDown(1);
             end
             %%
             if(in(8) == 1) %Ghost get Left
                        theGhostWallsV = theWallsAroundV;
                        theGhostWallsV(obj.presentState.pacman(2)+1,obj.presentState.pacman(1):obj.presentState.pacman(1)+1) = 1;
                        wallLeft = theGhostWallsV(obj.presentState.ghost(2)+1, 1:obj.presentState.ghost(1));
                        nextState.ghost(1) = obj.presentState.ghost(1) - 1 + wallLeft(end);
             end
             
             if(in(9) == 1) % Ghost get Up
                        theGhostWallsH = theWallsAroundH;
                        theGhostWallsH(obj.presentState.pacman(2):obj.presentState.pacman(2)+1,obj.presentState.pacman(1)+1) = 1;
                        wallUp = theGhostWallsH(1:obj.presentState.ghost(2), obj.presentState.ghost(1)+1);
                        nextState.ghost(2) = obj.presentState.ghost(2) - 1 + wallUp(end);
             end
             
             if(in(10) == 1) % Ghost get Right
                        theGhostWallsV = theWallsAroundV;
                        theGhostWallsV(obj.presentState.pacman(2)+1,obj.presentState.pacman(1):obj.presentState.pacman(1)+1) = 1;
                        wallRight = theGhostWallsV(obj.presentState.ghost(2)+1, obj.presentState.ghost(1)+1:size(theGhostWallsV,2));
                        nextState.ghost(1) = obj.presentState.ghost(1) + 1 - wallRight(1);  
             end
             
             if(in(11) == 1) % Ghost get Down
                        theGhostWallsH = theWallsAroundH;
                        theGhostWallsH(obj.presentState.pacman(2):obj.presentState.pacman(2)+1,obj.presentState.pacman(1)+1) = 1;
                        wallDown = theGhostWallsH(obj.presentState.ghost(2)+1:size(theGhostWallsH,1), obj.presentState.ghost(1)+1);
                        nextState.ghost(2) = obj.presentState.ghost(2) + 1 - wallDown(1);
             end
             nextState.caught = obj.presentState.caught;
             %Default case
             if(in(:) == 0)
                 %error('Error');
                 nextState = obj.presentState;
             end
        end
        %% --- Memory 
        % Déroulement de la fonction :
        % If initialisation required : 
        %   Then : do it with initial value declared here
        %   
        %   Else : calculate the new State with implementation of nxtState 
           %        calculate caught 
        function m(obj,nextState, init)
            
            if(init == 1)
                obj.presentState.wallsV =  [0 0 1 0 ; 0 1 1 0; 0 0 0 0; 0 0 0 0; 0 0 0 0];
                obj.presentState.wallsH =  [1 1 0 0 0; 0 1 0 0 0; 0 0 0 0 0; 0 0 0 0 0]; 
                obj.presentState.pacman = [1 1];
                obj.presentState.ghost  = [2 2];
                obj.presentState.escape = {[4 4], 0};
                obj.presentState.caught = 0;
            else

                obj.presentState = nextState;
                
                

                obj.presentState.caught = nextState.caught + ...                                Maybe we should use WallsBetween function
                           (obj.sameY_position*obj.wallsVBetweenOne(obj.presentState.pacman, obj.presentState.ghost)) + ...
                           (obj.sameY_position*obj.wallsVBetweenOne(obj.presentState.ghost, obj.presentState.pacman)) + ...
                           (obj.sameX_position*obj.wallsHBetweenOne(obj.presentState.ghost, obj.presentState.pacman)) + ...
                           (obj.sameX_position*obj.wallsHBetweenOne(obj.presentState.pacman, obj.presentState.ghost));
            end
        end
        %% -- Generation of the output 
        % Creation of a output vctor contains :
        %       pacman position (X,Y)
        %       Ghost  position (X,Y)
        %       WallsV matrix
        %       WallsH matrix
        %       Counter of caught
        %       Boolean of escape
        %       Vector with wallsAroundPacman
        %       Vector with wallsAroundGhost
        %       Vector with ghostSeesPacman
        %
        function  out = g(obj)
            % walls Around pacman
            Wup_pacman = [1; obj.presentState.wallsH(1:obj.presentState.pacman(2)-1, obj.presentState.pacman(1))];
            Wdown_pacman = [obj.presentState.wallsH(obj.presentState.pacman(2):size(obj.presentState.wallsH,1), obj.presentState.pacman(1)); 1];
            WLeft_pacman = [1 obj.presentState.wallsV(obj.presentState.pacman(2), 1:obj.presentState.pacman(1)-1)];
            WRight_pacman = [obj.presentState.wallsV(obj.presentState.pacman(2), obj.presentState.pacman(1):size(obj.presentState.wallsV,2)) 1];

            wallsAroundPacman = [Wup_pacman(end) Wdown_pacman(1) WLeft_pacman(end) WRight_pacman(1)]; % Walls Up, Down, Left and Right around the pacman
            
            Wup_ghost = [1; obj.presentState.wallsH(1:obj.presentState.ghost(2)-1, obj.presentState.ghost(1))];
            Wdown_ghost = [obj.presentState.wallsH(obj.presentState.ghost(2):size(obj.presentState.wallsH,1), obj.presentState.ghost(1)); 1];
            WLeft_ghost = [1 obj.presentState.wallsV(obj.presentState.ghost(2), 1:obj.presentState.ghost(1)-1)];
            WRight_ghost = [obj.presentState.wallsV(obj.presentState.ghost(2), obj.presentState.ghost(1):size(obj.presentState.wallsV,2)) 1];

            wallsAroundGhost = [Wup_ghost(end) Wdown_ghost(1) WLeft_ghost(end) WRight_ghost(1)]; % Walls Up, Down, Left and Right around the pacman
            
            obj.presentState.escape{2} = logical(not(obj.presentState.escape{1}(1) - obj.presentState.pacman(1)))*logical(not(obj.presentState.escape{1}(2) - obj.presentState.pacman(2)));
            
            % Ghost Sees pacman : logical equation which test two direction
            % and two position : ghost first orpacman first
            
            ghostSeesPacman = [ obj.sameX_position*obj.wallsHBetween(obj.presentState.pacman,obj.presentState.ghost), ...
                                obj.sameX_position*obj.wallsHBetween(obj.presentState.ghost,obj.presentState.pacman), ...
                                obj.sameY_position*obj.wallsVBetween(obj.presentState.pacman,obj.presentState.ghost),...
                                obj.sameY_position*obj.wallsVBetween(obj.presentState.ghost,obj.presentState.pacman)];  
            
            % Sortie lue par les autres commandes (elles doievent le
            % considï¿½rer comme une entrï¿½e)
            out = {obj.presentState.pacman, obj.presentState.ghost, ...
                    obj.presentState.wallsV, obj.presentState.wallsH, ...
                    obj.presentState.caught, obj.presentState.escape{2}, ...
                    wallsAroundPacman , wallsAroundGhost, ghostSeesPacman
                  };        
        end
        
        %% Function that return 1 if ghots and pacman are on the same X colonn
        function out = sameX_position(obj)
           out = logical(not(obj.presentState.ghost(1) - obj.presentState.pacman(1)));
        end
        
        %% Function that return 1 if ghots and pacman are on the same Y line
        function out = sameY_position(obj)
           out = logical(not(obj.presentState.ghost(2) - obj.presentState.pacman(2)));
        end
        
        %% Function which return if a vertical wall is between obj1 and obj2.
        function outV = wallsVBetween (obj, obj1, obj2)
            if(obj1(1)>obj2(1))
                outV = 0;
            else
                outV = logical(not(sum(obj.presentState.wallsV(obj1(2),obj1(1):obj2(1)-1))));
            end
        end
        
        %% Function which return if a horizontal wall is between obj1 and obj2.
        function outH = wallsHBetween (obj, obj1, obj2)
            if(obj1(2)>obj2(2))
                outH = 0;
            else
                outH = logical(not(sum(obj.presentState.wallsH(obj1(2):obj2(2)-1,obj2(1)))));
            end
        end
        
        %%  Function which return 1 if obj1 and obj2 are near in X axis 
        %   and there no wall between then 
        function outV = wallsVBetweenOne(obj, obj1, obj2)
           if(obj1(1)+1 == obj2(1))
               outV = obj.wallsVBetween(obj1, obj2);
           else
               outV = 0;
           end
        end
        
        %%  Function which return 1 if obj1 and obj2 are near in Y axis 
        %   and there no wall between then 
        function outH = wallsHBetweenOne(obj, obj1, obj2)
           if(obj1(2)+1 == obj2(2))
               outH = obj.wallsHBetween(obj1, obj2);
           else
               outH = 0;
           end
        end
    
    end
end

%% Princpe de la commande : 
% Lire les sories de model Laby communiquï¿½ avec le wrapper. (Est ce que le
% wrapper ne donne ï¿½ la commande uniquement les sorties qu'il
% l'intï¿½resse ??? )
% Aparir de ces sortie faire ï¿½voluer l'ï¿½tat : ï¿½tatsSuivant = ...
% Dans cet ï¿½tat, pour un objet, on y trouve toutes les informaions que l'on
% souhaite enregistrï¿½.Sapeut etre sa position, ou bien le nombre de fois
% qu'il a pu avancer... Sa dï¿½pend de la construction de l'utomate ou MAE
% faite avant.
% Actionner la commande sur les entrï¿½es de model Laby, communiquï¿½ par le
% wrapper.

