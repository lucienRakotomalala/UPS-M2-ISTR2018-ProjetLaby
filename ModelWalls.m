classdef ModelWalls < ModelSED
    %MODELWALLS Model of walls command
    % Input :  nop
    % Output : [UPwalls , RIGHTwalls]
    % state : contain the last move ( 0 = up ; 1 = right) 
    % This command do 
    properties
        presentState;
    end
    
    methods
        % --- Constructor
        function obj = ModelWalls()
            obj = obj.m(0,1);
        end
        
        % --- Evolution of the walls 
        function nextState = f(obj)
            nextState = ~ obj.presentState;
        end
        
        % --- Memory test
        function obj = m(obj,nextState, init)
            if(init == 1)
                obj.presentState = 0; 
            else
                obj.presentState = nextState;
            end
        end
        
        % --- Create the outputs
        function out = g(obj)
           out = zeros(1,2); 
           out(obj.presentState+1) = 1;
        end
    end
    
end

