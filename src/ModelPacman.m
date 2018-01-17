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
    % in:  Walls around pacman
    %    1 up
    %    2 down
    %    3 left
    %    4 right
    % This command   P(D) > P(B) > P(H) > P(G)   
    properties
        presentState;
        initialState;
        memory;
    end
    
   methods
        % --- Constructor
        function obj = ModelPacman(initialValue)
            obj.initialState = initialValue;
            obj = obj.m(0,1);
        end
        
        % --- Evolution of the walls 
        

function nextState = f(obj,in)
    nextState = zeros(1,4);     
    
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
    if(obj.memory(1) ~= 1 && in(2)==0)  %not right yet
        nextState(4)=1;
        obj.memory(1)=1;
    elseif(obj.memory(2)~= 1 && in(1)==0)%not down yet
        nextState(2)=1;
        obj.memory(2)=1;
    elseif(obj.memory(3)~= 1 && in(4)==0)%not left yet
        nextState(3)=1;
        obj.memory(3)=1;
    elseif(obj.memory(4)~= 1 && in(3)==0)%not up yet
        nextState(1)=1;
        obj.memory(4)=1;
    elseif(in(4)==0)
        nextState(3)=1 ;
    elseif(in(2)==0)
        nextState(4)=1;
    elseif(in(1)==0)
        nextState(2)=1 ;
    elseif(in(3)==0)
        nextState(1)=1;
    end
    if (obj.memory == ones(1,4))
        obj.memory=zeros(1,4);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%% COMMANDE 3 %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end

        
        % --- Memory test
function obj = m(obj,nextState, init)
            if(init == 1)
                obj.presentState = obj.initialState; 
                 obj.memory=zeros(1,4);
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

