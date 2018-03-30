%> @file ModelLaby.m

%> @brief Class which contains the "fmg" structure of the labyrinth for 2 players

%> Input :  necessary information for compute the next state of the model\n
%>\n
%> Output : output's action of the model\n
%> \n          
%> State :   minimal information necessary who evolute 
% ======================================================================
classdef ModelLaby < ModelSED
    %ModelLaby Class which contains the "fmg" structure of the labyrinth 
    %   This class contains 3 method useful : f(), m() and g() to describe the evolution of the labyrinth.
    
    properties
		%> Data Structure of the current state of Labyrinth. \n It contains "wallsV", "wallsH" (2 matrix for the walls), "ghost", "pacman" and "escape" , a Cartesian position of current position of ghost, pacman and escape. \n There is also 3 vectors : 'wallsAroundPacman', 'wallsAroundGhost' and 'ghostSeesPacman' A vector indicating the presence of a wall around the Pacman and ghost for the 4 directions Up Down Left Right
        presentState;
		%> Data Structure of the initial state of Labyrinth. It contains "wallsV", "wallsH" (2 matrix for the walls), "escape" and "pacman", a Cartesian position of current position of escape and pacman and 'wallsAroundPacman' A vector indicating the presence of a wall around the Pacman for the 4 directions Up Down Left Right
        initialState;
    end
    
    methods

        % Labyrinth Model Input : in
		% This input corresponds to command's outputs of obj1 (Pacman),
        % obj2(ghost) and walls. Commands will write  on the same vector "in"  
		% by setting the command value to 1.
        
        
        % Command library, vector in : See Callback of
        % figure_Laby
% ======================================================================   
%> @brief Class constructor of 
%> @param wallsV_init Contain a matrix (N, N-1) of Initial Vertical Walls.
%> @param wallsH_init Contain a matrix (N-1, N) of Initial Horizontal Walls.
%> @param pacman_init Contain a vector (x, y) of Initial Position of Pacman.
%> @param pacman_init Contain a vector (x, y) of Initial Position of Ghost.
%> @param escape_init Contain a vector (x, y) of Escape 's Position.
%> @param caught_init Contain a integer of the number of times the Pacman was caught by the ghost.
%> @return instance of the ModelLaby class.
% ======================================================================
        function obj = ModelLaby(wallsV_init,wallsH_init,pacman_init,ghost_init,escape_init,caught_init)
            obj.initialState.wallsV =  wallsV_init;
            obj.initialState.wallsH = wallsH_init; 
            obj.initialState.pacman = pacman_init;
            obj.initialState.ghost  = ghost_init;
            obj.initialState.escape = escape_init;
            obj.initialState.caught = caught_init;
            
            obj.m(0,1);     % NO next State. Initialization only.
        end


% ======================================================================   
%> @brief Compute the evolution of the model.
%> @param obj The instance which will evolve.
%> @param in Input needed for the computing. 
%> @retval nextState Next instance of the ModelLaby class.
% ======================================================================
        function nextState = f(obj, in)
        %% --- Evolution of the labyrinth 
        %   This function contains all evolution possible of laby.
        %
        %   1 part : All the walls move allowed
        %   2 part : All Pacman Move
        %   3 part : All Ghost Move
        %   4 part : Evolution of caught   
            nextState = obj.presentState;
            
            %% Walls Evolution 
            %
            %   next Walls become an offset matrix of Walls 
            %
            if(in(2) == 1) % Walls Horizontal moves to the right
                        nextState.wallsV = [obj.presentState.wallsV(size(obj.presentState.wallsV,1),:); obj.presentState.wallsV(1:size(obj.presentState.wallsV,1)-1,:)];     
            end
            if(in(3) == 1) % Walls Vertical moves down
                        nextState.wallsH = [obj.presentState.wallsH(:,size(obj.presentState.wallsH,2)) obj.presentState.wallsH(:,1:size(obj.presentState.wallsH,2)-1)];
            end
            
            %% Object Evolution
            % Creation of a upper wall matrix modeling the walls and all
            % contours of the laby
            theWallsAroundV =  wallsBorder(obj.presentState.wallsV);
            theWallsAroundH =  wallsBorder(obj.presentState.wallsH);
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
% ======================================================================
%> @brief Memory method
%> update the state of the command.
%> @param obj The selected instance of the class
%> @param nextState The value of the state need to update 
%> @param init Boolean condition for initialize or reset the command
%> @return instance of the class updated 
% ======================================================================           
        function m(obj,nextState, init)
        %% --- Memory 
        % Function sequence :
        % If initialization required : 
        %   Then : do it with initial value declared here
        %   
        %   Else : calculate the new State with implementation of nxtState 
        %        calculate caught 
		% Example : you can use it with F method just like 
            if(init == 1)
                %fprintf('Init Laby\n') % TODO
                obj.presentState = obj.initialState;
            else

                obj.presentState = nextState;
                
                

                obj.presentState.caught = nextState.caught + ...                                                           (obj.sameY_position*obj.wallsVBetweenOne(obj.presentState.pacman, obj.presentState.ghost)) + ...
                           (obj.sameY_position*obj.wallsVBetweenOne(obj.presentState.ghost, obj.presentState.pacman)) + ...
                           (obj.sameX_position*obj.wallsHBetweenOne(obj.presentState.ghost, obj.presentState.pacman)) + ...
                           (obj.sameX_position*obj.wallsHBetweenOne(obj.presentState.pacman, obj.presentState.ghost));
            end
        end
       
% ======================================================================        
%> @brief Create the outputs in a 1x9 cell-array. 
%> @param obj the concerned instance of the class
%> @retval out Constructed output 1x9 cell-array of the model
% ======================================================================
        function  out = g(obj)
		%% -- Generation of the output 
        % Creation of a output vector contains :
        %       Pacman position (X,Y)
        %       Ghost  position (X,Y)
        %       WallsV matrix
        %       WallsH matrix
        %       Counter of caught
        %       Boolean of escape
        %       Vector with wallsAroundPacman
        %       Vector with wallsAroundGhost
        %       Vector with ghostSeesPacman
        %
            % walls Around Pacman
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
            
            % Ghost Sees Pacman : logical equation which test two direction
            % and two position : ghost first or Pacman first
            
            ghostSeesPacman = [ obj.sameX_position*obj.wallsHBetween(obj.presentState.pacman,obj.presentState.ghost), ... Ghost below Pacman
                                obj.sameX_position*obj.wallsHBetween(obj.presentState.ghost,obj.presentState.pacman), ... Ghost above Pacman
                                obj.sameY_position*obj.wallsVBetween(obj.presentState.pacman,obj.presentState.ghost),... Ghost on the right of Pacman 
                                obj.sameY_position*obj.wallsVBetween(obj.presentState.ghost,obj.presentState.pacman)]; % Ghost on the left of Pacman 
            
            % Outputs read by command (they have to take it in input)
            out = {obj.presentState.pacman, obj.presentState.ghost, ...
                    obj.presentState.wallsV, obj.presentState.wallsH, ...
                    obj.presentState.caught, obj.presentState.escape{2}, ...
                    wallsAroundPacman , wallsAroundGhost, ghostSeesPacman
                  };        
        end
        
%> @brief Method to analyze Ghost and Pacman Position 
%> @param obj Current Instance of the Labyrinth
%> @returrn 1 if ghost and Pacman are on the same X colon   
        function out = sameX_position(obj)
		%% Method that return 1 if ghost and Pacman are on the same X colon
           out = logical(not(obj.presentState.ghost(1) - obj.presentState.pacman(1)));
        end
        
%> @brief Method to analyze Ghost and Pacman Position 
%> @param obj Current Instance of the Labyrinth
%> @returrn 1 if ghost and Pacman are on the same Y line
        function out = sameY_position(obj)
		%% Method that return 1 if ghost and Pacman are on the same Y line
           out = logical(not(obj.presentState.ghost(2) - obj.presentState.pacman(2)));
        end
        
%> @brief Method to analyze if a Vertical wall is between 2 objects
%> @param obj Current Instance of the Labyrinth
%> @param obj1 Cartesian position of object 1
%> @param obj2 Cartesian position of object 2
%> @returrn 1 if there No Vertical wall Between Object 1 and Object 2     
        function outV = wallsVBetween (obj, obj1, obj2)
		%% Method which return if a vertical wall is between obj1 and obj2.
            if(obj1(1)>obj2(1))
                outV = 0;
            else
                outV = logical(not(sum(obj.presentState.wallsV(obj1(2),obj1(1):obj2(1)-1))));
            end
        end
        
%> @brief Method to analyze if a Horizontal wall is between 2 objects
%> @param obj Current Instance of the Labyrinth
%> @param obj1 Cartesian position of object 1
%> @param obj2 Cartesian position of object 2
%> @returrn 1 if there No Horizontal wall Between Object 1 and Object 2
        function outH = wallsHBetween (obj, obj1, obj2)
		%% Method which return if a horizontal wall is between obj1 and obj2.
            if(obj1(2)>obj2(2))
                outH = 0;
            else
                outH = logical(not(sum(obj.presentState.wallsH(obj1(2):obj2(2)-1,obj2(1)))));
            end
        end
        
%> @brief Method to analyze if a Horizontal wall is between 2 objects side by side 
%> @param obj Current Instance of the Labyrinth
%> @param obj1 Cartesian position of object 1
%> @param obj2 Cartesian position of object 2
%> @returrn 1 if there No Horizontal wall Between Object 1 and Object 2        
        function outV = wallsVBetweenOne(obj, obj1, obj2)
		%%  Function which return 1 if obj1 and obj2 are near in X axis 
        %   and there no wall between then 
           if(obj1(1)+1 == obj2(1))
               outV = obj.wallsVBetween(obj1, obj2);
           else
               outV = 0;
           end
        end
%> @brief Method to analyze if a Horizontal wall is between 2 objects side by side 
%> @param obj Current Instance of the Labyrinth
%> @param obj1 Cartesian position of object 1
%> @param obj2 Cartesian position of object 2
%> @returrn 1 if there No Horizontal wall Between Object 1 and Object 2         
        function outH = wallsHBetweenOne(obj, obj1, obj2)
		%%  Function which return 1 if obj1 and obj2 are near in Y axis 
        %   and there no wall between then 
           if(obj1(2)+1 == obj2(2))
               outH = obj.wallsHBetween(obj1, obj2);
           else
               outH = 0;
           end
        end
    
    end
end



