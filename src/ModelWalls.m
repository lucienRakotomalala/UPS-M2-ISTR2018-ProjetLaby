classdef ModelWalls < ModelSED
    %MODELWALLS Model of walls command
    % Input :  nop
    % Output : [UPwalls , RIGHTwalls, 0]
    % state : contain the last move ( 0 = up ; 1 = right) 
    % This command do 
    properties
        presentState;
        i=0;
        val=0;
    end
    
    methods
        % --- Constructor
        function obj = ModelWalls()
            obj = obj.m(0,1);
        end
        
        % --- Evolution of the walls 
        function nextState = f(obj)
            if(obj.i>2)
                obj.i=0;          
                nextState = obj.val;
                obj.val=~obj.val;
            else
                nextState = 2;
                
                obj.i=obj.i+1;
            end
            obj.i
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
           if(obj.presentState~=2)
            out(obj.presentState+1) = 1;
           end
        end
    end
    
end

