classdef ModelWalls < ModelSED
    %MODELWALLS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        presentState;
    end
    
    methods
        % --- Evolution of the walls 
        function nextState = f(obj,in)
        end
        
        % --- Memory test
        function m(obj,nextState, init)

        end
        
        % --- Create the outputs
        function out = g(obj, in)
            
        end
    end
    
end

