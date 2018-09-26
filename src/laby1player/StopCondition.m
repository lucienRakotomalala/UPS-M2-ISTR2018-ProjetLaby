%> @file StopCondition.m

%> @brief Class used to manage shutdown conditions.

%>  Labyrinth shutdown conditions model.\n
%>	You can modify the shutdown conditions here. It is developing in the same way as MODELSED, with "FMG" block. (MODELSED's legacy)\n
%> Input :   walls of Pacman's \n
%>           walls of ghost's\n
%>           escape of Pacman \n
%>           CaughtBreak\n
%>\n
%> Output : 1 Escape\n
%>          2 Caugnt\n
%>          3 pacmanWallsBreak\n
%>          4 ghostWallsBreak\n
classdef StopCondition  < ModelSED
	% STOPCONDITION	Labyrinth shutdown conditions model .
	%	You can modify the shutdown conditions here. It is developing
	%	in the same way as MODELSED, with "FMG" block. (MODELSED's legacy)
    %   Detailed explanation goes here
    % Input :   walls of Pacman's 
    %           walls of ghost's
    %           escape of Pacman 
    %           CaughtBreak
    %
    % Output : 1 Escape
    %          2 Caugnt
    %          3 pacmanWallsBreak
    %          4 ghostWallsBreak
    
	properties
		%> Data Structure of the current state of Labyrinth. It contains "wallsV", "wallsH" (2 matrix for the walls), "escape" and "pacman", a Cartesian position of current position of escape and pacman and 'wallsAroundPacman' A vector indicating the presence of a wall around the Pacman for the 4 directions Up Down Left Right
        presentState;
		%> Data Structure of the initial state of Labyrinth. It contains "wallsV", "wallsH" (2 matrix for the walls), "escape" and "pacman", a Cartesian position of current position of escape and pacman and 'wallsAroundPacman' A vector indicating the presence of a wall around the Pacman for the 4 directions Up Down Left Right
        initialState;
    end
    
	methods
% ======================================================================   
%> @brief Class constructor of Instance of StopCondition Class.
%> @param initCondition Structure for the InitialState. It have to contain : 'escape', 'caught', 'pacman' and 'numberOfPossibleCaught'
%> @return instance of the ModelLaby class.
% ====================================================================== 
        function obj = StopCondition(initCondition)
            obj.initialState = initCondition;
            obj = obj.m(0,1);
        end
 
% ======================================================================   
%> @brief Compute the evolution of the model.
%> @param obj The instance which will evolve.
%> @param in Input needed for the computing. 
%> @return Next instance of the StopCondition class.
% ====================================================================== 
        function nextState = f(obj, noEscape,  pacmanWallsBreak)
		    %% --- Evolution of the StopCondition
			%   This function contains all evolution possible of shutdown Test.
			%
                %nextState = zeros(1,4);
                if(noEscape==1)
                    nextState.escape=1;
                else
                    nextState.escape=0;
                end
                                
                if(sum(pacmanWallsBreak)==4)
                    nextState.pacman=1;
                else
                    nextState.pacman=0;
                end
                
        end
% ======================================================================
%> @brief Memory method.
%> Update the state of the command.
%> @param obj The selected instance of the class
%> @param nextState The value of the state need to update 
%> @param init Boolean condition for initialize or reset the command
%> @return instance of the class updated 
% ======================================================================       
        function obj = m(obj, nextState, init)
		%% --- Memory 
        % Function sequence :
        % If initialization required : 
        %   Then : do it with initial value declared here
        %   
        %   Else : calculate the new State with implementation of nxtState 
           %        calculate caught 
            if(init==1)
                obj.presentState = obj.initialState;
            else
                obj.presentState = nextState;
            end
        end
% ======================================================================        
%> @brief Create the outputs in a vector with 4 parameters. 
%> @param obj the concerned instance of the class
%> @retval out Constructed output vector with 4 parameters of the model.

%> In this case, the output contain only escape information and Pacman block information.
% ======================================================================         
        function out = g(obj)
            out=zeros(1,4);
            out(1) = obj.presentState.escape;
            out(3) = obj.presentState.pacman;
            
        end
        
    end	
    
end