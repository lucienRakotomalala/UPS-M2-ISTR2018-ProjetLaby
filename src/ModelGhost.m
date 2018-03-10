classdef ModelGhost < ModelSED
    %MODELGhost Summary of this class goes here
    % Input :  Possible ghost's moves [Up Down Left Right]
    %    0 = move not possible ; 1 = move possible
    %           ( Wout{7} )
    %
    % Output : Ghost's moves  1 : ghostLeftBut, ( Wout(3) )
    %                          2 : ghostUpBut,  ( Wout(1) )
    %                          3 : ghostRightBut,  ( Wout(4) )
    %                          4 : ghostDownBut ,  ( Wout(2) )
    %           ( Win( 4:7) of wrapper )
    
    % in:  Walls around ghost
    %    1 up
    %    2 down
    %    3 left
    %    4 right
    %
    %
    % in_view: Ghost sees pacman   
    %   1 Up
    %   2 Down
    %   3 Left
    %   4 Right
    % state :
    %
    %
    % This command   P(D) > P(B) > P(H) > P(G)
    properties
        presentState;
        initialState;
    end
    
    methods
        % --- Constructor
        function obj = ModelGhost(initialValue)
            obj.initialState = initialValue;
            obj = obj.m(0,1);
        end
        
        % --- Evolution of the ghost
        function nextState = f(obj,in,in_view, wallsV, wallsH, ghost_position)
            nextState = zeros(1,5);
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%% COMMANDE 1 %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             if(in_view(1)==1) %pacman up ?
%                 nextState(2)=1; 
%                 
%             elseif(in_view(2)==1) %pacman down?
%                 nextState(4)=1; 
%                 
%             elseif(in_view(3)==1)  %pacman left ?
%                 nextState(1)=1; 
%                 
%             elseif(in_view(4)==1) %pacman right ?
%                 nextState(3)=1;
%                 
%             elseif(in(4)==0) %right ?
%                 nextState(3)=1 ;
%                 
%             elseif(in(2)==0) %down ?
%                 nextState(4)=1; 
%                 
%             elseif(in(1)==0) %up ?
%                 nextState(2)=1 ;
%                 
%             elseif(in(3)==0) %left ?
%                 nextState(1)=1;
%             end

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%% COMMANDE 2 %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %Initialization
% Up_nextWallsAround = zeros(1,4);
% Down_nextWallsAround = zeros(1,4);
% Left_nextWallsAround = zeros(1,4);
% Right_nextWallsAround = zeros(1,4);
% 
%   %Look wich turn of game it is cause walls moves every second time
%   %first time Veticals move, third time Horizontals move
% if(mod(obj.presentState(1,5),4)==0) 
%      nextWallsV = [wallsV(size(wallsV,1),:); wallsV(1:size(wallsV,1)-1,:)];
%      nextWallsH = wallsH;
% elseif(mod(obj.presentState(1,5),4)==2)
%      nextWallsH = [wallsH(:,size(wallsH,2)) wallsH(:,1:size(wallsH,2)-1)];
%      nextWallsV = wallsV;
% else nextWallsH = wallsH;
%      nextWallsV = wallsV;
% end
%     
% %Count every walls around for each boxes around Ghost
% 
% %For the box ABOVE Ghost :
%     if(ghost_position(2)~=1)
%             Up_nextWallUp = [1; nextWallsH(1:(ghost_position(2)-1)-1, ghost_position(1))];
%             Up_nextWallDown = [nextWallsH((ghost_position(2)-1):size(nextWallsH,1), ghost_position(1)); 1];
%             Up_nextWallLeft = [1 nextWallsV(ghost_position(2)-1, 1:ghost_position(1)-1)];
%             Up_nextWallRight = [nextWallsV(ghost_position(2)-1, ghost_position(1):size(nextWallsV,2)) 1];
%             Up_nextWallsAround = [Up_nextWallUp(end) Up_nextWallDown(1) Up_nextWallLeft(end) Up_nextWallRight(1)];
%     end  
%     
% %For the box UNDER Ghost :
%     if(ghost_position(2)~=size(wallsH,2))
%             Down_nextWallUp = [1; nextWallsH(1:ghost_position(2)+1-1, ghost_position(1))];
%             Down_nextWallDown = [nextWallsH(ghost_position(2)+1:size(nextWallsH,1), ghost_position(1)); 1];
%             Down_nextWallLeft = [1 nextWallsV(ghost_position(2)+1, 1:ghost_position(1)-1)];
%             Down_nextWallRight = [nextWallsV(ghost_position(2)+1, ghost_position(1):size(nextWallsV,2)) 1];
%             Down_nextWallsAround =[Down_nextWallUp(end) Down_nextWallDown(1) Down_nextWallLeft(end) Down_nextWallRight(1)];
%     end       
%     
% %For the box LEFT of Ghost :
%     if(ghost_position(1)~=1)
%             Left_nextWallUp = [1; nextWallsH(1:ghost_position(2)-1, ghost_position(1)-1)];
%             Left_nextWallDown = [nextWallsH(ghost_position(2):size(nextWallsH,1), ghost_position(1)-1); 1];
%             Left_nextWallLeft = [1 nextWallsV(ghost_position(2), 1:ghost_position(1)-1-1)];
%             Left_nextWallRight = [nextWallsV(ghost_position(2), ghost_position(1)-1:size(nextWallsV,2)) 1];
%             Left_nextWallsAround = [Left_nextWallUp(end) Left_nextWallDown(1) Left_nextWallLeft(end) Left_nextWallRight(1)];
%     end   
%     
% %For the box RIGHT of Ghost :
%     if(ghost_position(1)~=size(wallsH,2))
%             Right_nextWallUp = [1; nextWallsH(1:ghost_position(2)-1, ghost_position(1)+1)];
%             Right_nextWallDown = [nextWallsH(ghost_position(2):size(nextWallsH,1), ghost_position(1)+1); 1];
%             Right_nextWallLeft = [1 nextWallsV(ghost_position(2), 1:ghost_position(1)-1+1)];
%             Right_nextWallRight = [nextWallsV(ghost_position(2), ghost_position(1)+1:size(nextWallsV,2)) 1];
%             Right_nextWallsAround =[Right_nextWallUp(end) Right_nextWallDown(1) Right_nextWallLeft(end) Right_nextWallRight(1)];
%     end
%     
% nextState(1,5)= mod(obj.presentState(1,5)+1,4);
%     
% %test if Ghost sees Pacman and if the next box in the smae direction is blocked
% 
%             if (in_view(1)==1 && ~isequal(Up_nextWallsAround, ones(1,4))) %pacman up ?
%                     nextState(2)=1;
%                 
%             elseif(in_view(2)==1 && ~isequal(Down_nextWallsAround, ones(1,4))) %pacman down?
%                 nextState(4)=1; 
%                 
%             elseif(in_view(3)==1 && ~isequal(Left_nextWallsAround, ones(1,4)))  %pacman left ?
%                 nextState(1)=1; 
%                 
%             elseif(in_view(4)==1 && ~isequal(Right_nextWallsAround, ones(1,4))) %pacman right ?
%                 nextState(3)=1;
%                 
%             elseif(in(4)==0 && ~isequal(Right_nextWallsAround,ones(1,4))) %right ?
%                 nextState(3)=1;
%                 
%             elseif(in(2)==0 && ~isequal(Down_nextWallsAround, ones(1,4))) %down ?
%                 nextState(4)=1;
%                 
%             elseif(in(1)==0 && ~isequal(Up_nextWallsAround, ones(1,4))) %up ?
%                 nextState(2)=1;
%                 
%             elseif(in(3)==0 && ~isequal(Left_nextWallsAround,ones(1,4))) %left ?
%                nextState(1)=1;  
%             end
%             
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%% COMMANDE 3 %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nextState = obj.presentState;
        end

        % --- Memory test
        function obj = m(obj,nextState, init)
            if(init == 1)
              %  fprintf('Init Ghost\n') % TODO 
                obj.presentState = obj.initialState;
                %the 4 fisrt elements = mouvements
                %Last element = turn of the game (counted inside this class)
            else
                obj.presentState = nextState;
            end
        end
        
        % --- Create the outputs
        function out = g(obj)
         %%%Commande 1 et 2
            out= obj.presentState(1,1:4);
        %%% Commande 3
           %  out= zeros(1,4);
        end
    end
    
end

