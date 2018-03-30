%> @file ModelWalls.m
%> @brief Contain wall movement command

%> Input :  No need \n 
%>\n
%> Output : [UPwalls , RIGHTwalls]\n
%>  \n
%> State : contain the last move ( 0 = up ; 1 = right) \n
%> This command do the sequence walls Right --> walls down \n 
classdef ModelWalls < ModelSED
    %MODELWALLS Model of walls command
    % Input :  No
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
% ======================================================================   
%> @brief Class constructor
%> @param initialValue Contain the initial state 
%> @return instance of the ModelWalls class.
% ======================================================================
        function obj = ModelWalls(initValue)
		% --- Constructor
            obj.initialState = initValue;
            obj = obj.m(0,1);
        end
        
        % --- Evolution of the walls 
        function nextState = f(obj)

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %         Commande 1        %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            nextState = ~obj.presentState;
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %         Commande 2        %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             
%             if(obj.i>=2)
%                 obj.i=1;          
%                 nextState = obj.val;
%                 obj.val=~obj.val;
%             else
%                 nextState = 2;
%                 obj.i=obj.i+1;
%             end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %         Commande 3        %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %nextState = obj.presentState;
        end
        
% ======================================================================
%> @brief Memory method
%> update the state of the command.
%> @param obj The selected instance of the class
%> @param nextState The value of the state need to update 
%> @param init Boolean condition for initialize or reset the command
%> @return instance of the class updated 
% ======================================================================       
        function obj = m(obj,nextState, init)
		% Memorization of current State of walls or Initialize it.
            if(init == 1)
                %fprintf('Init Walls\n') % TODO
                obj.presentState = obj.initialState; 
            else
                obj.presentState = nextState;
            end
        end
        
% ======================================================================        
%> @brief Create the outputs
%> @param obj the concerned instance of the class
%> @retval out The output who is the command.
% ======================================================================
        function out = g(obj)
		% --- Create the vector outputs of walls. Contain also commented command.
            %%%%%%%%%%%%%% SIMPLE COMMAND
        out=zeros(1,2);
        out(obj.presentState+1)=1;
            %%%%%%%%%%%%%% other command 2
%             out = zeros(1,2);
%            if(obj.presentState~=2)
%             out(obj.presentState+1) = 1;
%             end
            %%%%%%%%%%%%%% other command 3
             %out = zeros(1,2);
        end
    end
    
end

