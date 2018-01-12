classdef ModelWalls < ModelSED
    %MODELWALLS Model of walls command
    % Input :  nop
    % Output : [UPwalls , RIGHTwalls, 0]
    % state : contain the last move ( 0 = up ; 1 = right) 
    % This command do 
    properties
        presentState;
        initialState;
		i=1;
        val=0;
    end
    
    methods
        % --- Constructor
        function obj = ModelWalls(initValue)
            obj.initialState = initValue;
            obj = obj.m(0,1);
        end
        
        % --- Evolution of the walls 
        function nextState = f(obj)

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %         Commande 1        %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %nextState = ~obj.presentState;
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %         Commande 2        %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            if(obj.i>=2)
                obj.i=1;          
                nextState = obj.val;
                obj.val=~obj.val;
            else
                nextState = 2;
                obj.i=obj.i+1;
            end
        end
        
        % --- Memory test
        function obj = m(obj,nextState, init)
            if(init == 1)
                obj.presentState = obj.initialState; 
            else
                obj.presentState = nextState;
            end
        end
        
        % --- Create the outputs
        function out = g(obj)
            %%%%%%%%%%%%%% SIMPLE COMMAND
     %   out=zeros(1,2);
      %  out(obj.presentState+1)=1;
            %%%%%%%%%%%%%% other command
            out = zeros(1,2);
            if(obj.presentState~=2)
             out(obj.presentState+1) = 1;
            end
        end
    end
    
end

