%> @file ModelLaby.m

%> @briel Class which contains the "fmg" structure of the labyrinth for 1 player

%> Input :  necessary information for compute the next state of the model\n
%>\n
%> Output : output's action of the model\n
%>   \n        
%> State :   minimal information necessary who evolute 
% ======================================================================
classdef ModelLaby < ModelSED
    %ModelLaby Class which contains the "fmg" structure of the labyrinth 
    %   This class contains 3 method useful : f(), m() and g() to describe the evolution of the labyrinth.
    
    properties
		%> Data Structure of the current state of Labyrinth. It contains "wallsV", "wallsH" (2 matrix for the walls), "escape" and "pacman", a Cartesian position of current position of escape and pacman and 'wallsAroundPacman' A vector indicating the presence of a wall around the Pacman for the 4 directions Up Down Left Right
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
%> @brief Class constructor of Instance of ModelLaby Class.
%> @param wallsV_init Contain a matrix (N, N-1) of Initial Vertical Walls.
%> @param wallsH_init Contain a matrix (N-1, N) of Initial Horizontal Walls.
%> @param pacman_init Contain a vector (x, y) of Initial Position of Pacman.
%> @param escape_init Contain a vector (x, y) of Escape 's Position.
%> @return instance of the ModelLaby class.
% ======================================================================
        function obj = ModelLaby(wallsV_init,wallsH_init,pacman_init,escape_init)
            obj.initialState.wallsV =  wallsV_init;
            obj.initialState.wallsH = wallsH_init; 
            obj.initialState.pacman = pacman_init;
            obj.initialState.escape = escape_init;
            
            obj.m(0,1);     % NO next State. Initialization only.
        end

% ======================================================================   
%> @brief Compute the evolution of the model.
%> @param obj The instance which will evolve.
%> @param in Input needed for the computing. 
%> @return Next instance of the ModelLaby class.
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
                        wallLeft = thePacmanWallsV(obj.presentState.pacman(2)+1, 1:obj.presentState.pacman(1));
                        nextState.pacman(1) = obj.presentState.pacman(1) - 1 + wallLeft(end);
            end
             if(in(5) == 1) % Pacman get Up
                        thePacmanWallsH = theWallsAroundH;
						wallUp = thePacmanWallsH(1:obj.presentState.pacman(2), obj.presentState.pacman(1)+1);
                        nextState.pacman(2) = obj.presentState.pacman(2) - 1 + wallUp(end);
             end
             if(in(6) == 1) % Pacman get right
                        thePacmanWallsV = theWallsAroundV;
                        wallRight = thePacmanWallsV(obj.presentState.pacman(2)+1, obj.presentState.pacman(1)+1:size(thePacmanWallsV,2));
                        nextState.pacman(1) = obj.presentState.pacman(1) + 1 - wallRight(1);
             end
             if(in(7) == 1) % Pacman get Down
                        thePacmanWallsH = theWallsAroundH;
                        wallDown = thePacmanWallsH(obj.presentState.pacman(2)+1:size(thePacmanWallsH,1), obj.presentState.pacman(1)+1);
                        nextState.pacman(2) = obj.presentState.pacman(2) + 1 - wallDown(1);
             end
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
  
            if(init == 1)
                %fprintf('Init Laby\n') % TODO
                obj.presentState = obj.initialState;
            else

                obj.presentState = nextState;
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
        %       WallsV matrix
        %       WallsH matrix
        %       Boolean of escape
        %       Vector with wallsAroundPacman
        %
		
            % walls Around Pacman
            Wup_pacman = [1; obj.presentState.wallsH(1:obj.presentState.pacman(2)-1, obj.presentState.pacman(1))];
            Wdown_pacman = [obj.presentState.wallsH(obj.presentState.pacman(2):size(obj.presentState.wallsH,1), obj.presentState.pacman(1)); 1];
            WLeft_pacman = [1 obj.presentState.wallsV(obj.presentState.pacman(2), 1:obj.presentState.pacman(1)-1)];
            WRight_pacman = [obj.presentState.wallsV(obj.presentState.pacman(2), obj.presentState.pacman(1):size(obj.presentState.wallsV,2)) 1];

            wallsAroundPacman = [Wup_pacman(end) Wdown_pacman(1) WLeft_pacman(end) WRight_pacman(1)]; % Walls Up, Down, Left and Right around the pacman
            
           
            obj.presentState.escape{2} = logical(not(obj.presentState.escape{1}(1) - obj.presentState.pacman(1)))*logical(not(obj.presentState.escape{1}(2) - obj.presentState.pacman(2)));
            
             
            % Output read by the other commands (they must consider it as an entry)
            out = {obj.presentState.pacman,{}, ...
                    obj.presentState.wallsV, obj.presentState.wallsH, ...
                    {}, obj.presentState.escape{2}, ...
                    wallsAroundPacman , {}, {}
                  };        
        end   
    end
end



