classdef ModelLaby < ModelSED
    %MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        presentState;
    end
    
    methods
        function obj = ModelLaby(state)
            obj.presentState = state
        end
        
        % --- Evolution of the labyrinth 
        function nextState = f(obj, in)
            if(in(2) == 1) % Walls Vertical
                nextState.walls = obj.presentState.walls.moveVerticalWalls();
            end
            if(in(3) == 1) % Walls Horizontal
                nextState.walls = obj.presentState.walls.moveHorizontalWalls();
            end
%             if(in(4) == 1) % Pacman left
%                 nextState.pacman = obj.presentState.pacman.goLeft();
%             end
        end
        % --- Memory 
        function m(obj,nextState, init)
            obj.presentState = nextState;
        end
        % -- Generation of the output 
        function  out = g(obj, in)
            out = obj.presentState.walls;
        end
    end
    
end

