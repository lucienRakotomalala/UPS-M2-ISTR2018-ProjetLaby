%> @file ModelPacman.m

%> @brief Contain ghost Pacman control

%> You can change here Pacman's command.\n 
%> Input :  Possible Pacman's moves [Up Down Left Right] \n
%>    0 = move not possible ; 1 = move possible \n
%>           ( Wout{7} )\n
%>\n
%> Output : Pacman's moves  1 : pacmanLeftBut, ( Wout(3) )\n
%>                          2 : pacmanUpBut,  ( Wout(1) )\n
%>                          3 : pacmanRightBut,  ( Wout(4) )\n
%>                          4 : pacmanDownBut ,  ( Wout(2) )\n
%>           ( Win( 4:7) of wrapper ) \n
%>\n
%> Input :  Walls around Pacman \n
%>    1 up \n
%>    2 down\n
%>    3 left\n
%>    4 right\n
%> This command do the sequence   P(D) > P(B) > P(H) > P(G) \n
% ======================================================================
classdef ModelPacman < ModelSED
    %MODELPACMAN Summary of this class goes here
	% You can change here Pacman's command.
    % Input :  Possible Pacman's moves [Up Down Left Right] 
    %    0 = move not possible ; 1 = move possible 
    %           ( Wout{7} )
    %
    % Output : Pacman's moves  1 : pacmanLeftBut, ( Wout(3) )
    %                          2 : pacmanUpBut,  ( Wout(1) )
    %                          3 : pacmanRightBut,  ( Wout(4) )
    %                          4 : pacmanDownBut ,  ( Wout(2) )
    %           ( Win( 4:7) of wrapper ) 
    %           
    % state :   
    %           
    % 
    % in:  Walls around Pacman
    %    1 up
    %    2 down
    %    3 left
    %    4 right
    % This command   P(D) > P(B) > P(H) > P(G)   
    properties
%> This is the state of the command in the present moment    
        presentState;
%> This is the state of the command in the initialization and when it's reseted
        initialState;
    end
    
   methods
% ======================================================================   
%> @brief Class constructor
%> @param initialValue Contain the initial state
%> @return instance of the ModelPacman class.
% ======================================================================
    function obj = ModelPacman(initialValue)
		%% Constructor of ModelPacman 
		%
		% Takes as an entry the initial 
            obj.initialState = initialValue;
            obj = obj.m(0,1);
    end
        
        
        
% ======================================================================        
%> @brief Compute the evolution of the command
%> @param obj The instance who evolute
%> @param in Input needed for the compute
%> @retval nextState The future state of the Pacman command
% ======================================================================
	function nextState = f(obj,in)
		% --- Pacman's Evolution
		%
		% 	Multiple Command are commented in this source. Please refers to report for more information.
		nextState = zeros(1,5);     
		
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
					%%%% COMMANDE 1 %%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%             nextState = zeros(1,4);
	%             if(in(4)==0)
	%                     nextState(3)=1 ;    
	%             elseif(in(2)==0)
	%                     nextState(4)=1;    
	%             elseif(in(1)==0)
	%                     nextState(2)=1 ;    
	%             elseif(in(3)==0)
	%                     nextState(1)=1;               
	%             end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
					%%%% COMMANDE 2 %%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%     if(obj.memory(1) ~= 1 && in(2)==0)  %not right yet
	%         nextState(4)=1;
	%         obj.memory(1)=1;
	%     elseif(obj.memory(2)~= 1 && in(1)==0)%not down yet
	%         nextState(2)=1;
	%         obj.memory(2)=1;
	%     elseif(obj.memory(3)~= 1 && in(4)==0)%not left yet
	%         nextState(3)=1;
	%         obj.memory(3)=1;
	%     elseif(obj.memory(4)~= 1 && in(3)==0)%not up yet
	%         nextState(1)=1;
	%         obj.memory(4)=1;
	%     elseif(in(4)==0)
	%         nextState(3)=1 ;
	%     elseif(in(2)==0)
	%         nextState(4)=1;
	%     elseif(in(1)==0)
	%         nextState(2)=1 ;
	%     elseif(in(3)==0)
	%         nextState(1)=1;
	%     end
	%     if (obj.memory == ones(1,4))
	%         obj.memory=zeros(1,4);
	%     end
		
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
					%%%% COMMANDE 3 laby 3x3 %%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%down-down-right-up-right-down
	%     if obj.presentState(5)==0
	%         nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==1
	%          nextState(4)=1;
	%          nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==2
	%          nextState(3)=1;
	%             nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==3
	%          nextState(2)=1;
	%             nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==4
	%          nextState(3)=1;
	%             nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==5
	%          nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%     else
	%            nextState=obj.initialState;
	%     end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
					%%%% COMMANDE 4 laby 4x4 %%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%D  U  R  R  D  D  D  R
	%     if obj.presentState(5)==0
	%         nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==1
	%          nextState(2)=1;
	%          nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==2
	%          nextState(3)=1;
	%             nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==3
	%          nextState(3)=1;
	%             nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==4
	%          nextState(4)=1;
	%             nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==5
	%          nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%         elseif obj.presentState(5)==6
	%          nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%         elseif obj.presentState(5)==7
	%          nextState(3)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%     else
	%            nextState=obj.initialState;
	%     end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
					%%%% COMMANDE 5 laby 5x5 %%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% R  R  R  D  U  D  D  U  D  D  D
	%     if obj.presentState(5)==0
	%         nextState(3)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==1
	%          nextState(3)=1;
	%          nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==2
	%          nextState(3)=1;
	%             nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==3
	%          nextState(4)=1;
	%             nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==4
	%          nextState(2)=1;
	%             nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==5
	%          nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%         elseif obj.presentState(5)==6
	%          nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%         elseif obj.presentState(5)==7
	%          nextState(2)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%         elseif obj.presentState(5)==8
	%          nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%         elseif obj.presentState(5)==9
	%          nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%         elseif obj.presentState(5)==10
	%          nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%     else
	%            nextState=obj.initialState;
	%     end
	   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
					%%%% COMMANDE 6 laby 7x7 %%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%     %  R  D  R  D  D  R  R  D  D  R  D
	%     if obj.presentState(5)==0
	%         nextState(3)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==1
	%          nextState(4)=1;
	%          nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==2
	%          nextState(3)=1;
	%             nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==3
	%          nextState(4)=1;
	%             nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==4
	%          nextState(4)=1;
	%             nextState(5)=obj.presentState(5)+1;
	%     elseif obj.presentState(5)==5
	%          nextState(3)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%         elseif obj.presentState(5)==6
	%          nextState(3)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%         elseif obj.presentState(5)==7
	%          nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%         elseif obj.presentState(5)==8
	%          nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%         elseif obj.presentState(5)==9
	%          nextState(3)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%         elseif obj.presentState(5)==10
	%          nextState(4)=1;
	%         nextState(5)=obj.presentState(5)+1;
	%     else
	%            nextState=obj.initialState;
	%     end 
	   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
					%%%% COMMANDE 7 bloquer laby 5x5 %%%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%     %   R R R D U D D U D U 
		if obj.presentState(5)==0
			nextState(3)=1;
			nextState(5)=obj.presentState(5)+1;
		elseif obj.presentState(5)==1
			 nextState(3)=1;
			 nextState(5)=obj.presentState(5)+1;
		elseif obj.presentState(5)==2
			 nextState(3)=1;
				nextState(5)=obj.presentState(5)+1;
		elseif obj.presentState(5)==3
			 nextState(4)=1;
				nextState(5)=obj.presentState(5)+1;
		elseif obj.presentState(5)==4
			 nextState(2)=1;
				nextState(5)=obj.presentState(5)+1;
		elseif obj.presentState(5)==5
			 nextState(4)=1;
			nextState(5)=obj.presentState(5)+1;
			elseif obj.presentState(5)==6
			 nextState(4)=1;
			nextState(5)=obj.presentState(5)+1;
			elseif obj.presentState(5)==7
			 nextState(2)=1;
			nextState(5)=obj.presentState(5)+1;
			elseif obj.presentState(5)==8
			 nextState(4)=1;
			nextState(5)=obj.presentState(5)+1;
			elseif obj.presentState(5)==9
			 nextState(2)=1;
			nextState(5)=obj.presentState(5)+1;
		else
			   nextState=obj.initialState;
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
	function obj = m(obj,nextState, init)
		% Memorization of current State of Pacman or Initialize it.
		if(init == 1)
			%fprintf('Init Pacman\n') % TODO
			obj.presentState = obj.initialState; 
			%%Commande 2%% 
			%obj.memory=zeros(1,4);
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
        % --- Create the vector outputs of Pacman
            out= obj.presentState(1:4);
        end
    end
    
end

