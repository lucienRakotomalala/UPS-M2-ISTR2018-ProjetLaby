classdef ModelLaby < ModelSED
    %MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % --- Evolution of the labyrinth 
        function nextState = f(presentState,in)
            ...
        end
        % --- Memory 
        function presentState = m(nextState,init)
            ...
        end
        % -- Generation of the output 
        function  out = g(presentState,in)
            ...
        end
    end
    
end

