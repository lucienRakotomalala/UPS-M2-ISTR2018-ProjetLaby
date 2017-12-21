classdef ModelPacman < ModelSED
    %MODELPACMAN Summary of this class goes here
    % Input :  Possible pacman's moves [Up Down Left Right] 
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
    % This command   P(D) > P(B) > P(H) > P(G)   
    properties
        presentState;
    end
    
   methods
        % --- Constructor
        function obj = ModelPacman()
            obj = obj.m(0,1);
        end
        
        % --- Evolution of the walls 
        

function nextState = f(obj,in)
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%% COMMANDE 1 %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            nextState = zeros(1,4);
            if(in(4)==0)
                    nextState(3)=1 ;    
            elseif(in(2)==0)
                    nextState(4)=1;    
            elseif(in(1)==0)
                    nextState(2)=1 ;    
            elseif(in(3)==0)
                    nextState(1)=1;               
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%% COMMANDE 2 %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

        
        % --- Memory test
        function obj = m(obj,nextState, init)
            if(init == 1)
                obj.presentState = zeros(1,4); 
            else
                obj.presentState = nextState;
            end
        end
        
        % --- Create the outputs
        function out = g(obj)
            out= obj.presentState;
        end
    end
    
end

