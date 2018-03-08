function [initialIndice,markedStatesIndices,transitionsDatas, numberOfStates] = AutomatonStrutureLabyCreation (labySize,playerPosition,escapePosition)
%% Automaton of labyrinth struture creation :
% Inputs
    % labySize        : int  = [x]         x  = dimension of the labyrinth
    % playerPosition        : int  = [x,y]         x  = horizontal position
                                                 % y  = vertical position
                                                 % of the player
    % escapePosition        : int  = [x,y]         x  = horizontal position
                                                 % y  = vertical position
                                                 % of the escape
% Output
    % initialIndice : int  = [x]         x = indice of the initial state                                             
                                        % string to create states by 
    % markedStatesIndices : int = [.,.,...] indice of the marked states   
    % transitionsDatas : cell  = {O,D,Tr;.,.,.;}       One line : 1 transition
                                          % O  = origin state 
                                          % D  = destination state
                                          % Tr = event name
    % numberOfStates   : int  = [x]         x  = number of states of the
                                            % automaton  
% number Of States
numberOfStates = labySize^2;
%initial Indice
initialIndice = ( playerPosition(2) - 1 )*labySize + playerPosition(1);
% marked States Indices
markedStatesIndices = ( escapePosition(2) - 1 )*labySize + escapePosition(1);
% a labyrinth                                            
%   +-+-+-+
%   |c|b|c|
%   +-+-+-+
%   |b|m|b|
%   +-+-+-+
%   |c|b|c|
%   +-+-+-+
%   nTr =  (if labySize>1 :) nbOf_c*2tr + (if labySize >2 :) + nbOf_b*3tr + (if labySize >2 :) nbOf_m*4tr 
    nTr= (labySize>1)*4*2 + (labySize>2)*(labySize-2)*(4*3+(labySize-2)*4); 
    if (nTr>0)
        transitionsDatas = cell(nTr+4*numberOfStates-1,3);
        emptyWalls = zeros(labySize,labySize-1);
        
        [U,D,L,R] = generer_lab(emptyWalls',emptyWalls);
        % U : Up ; D : Down ; L:Left ; R:Right
        % U(y,x)    =1 : can move from state x to state y
        %           =0 : can't move
        % same for D, L and R
        [yU,xU]=find(U);
        [yD,xD]=find(D);
        [yL,xL]=find(L);
        [yR,xR]=find(R) ;
        
        for i = 1:nTr/4 ; 
            %Up
            j = (i-1)*4+1;
            transitionsDatas{j,1}=xU(i);
            transitionsDatas{j,2}=yU(i);
            transitionsDatas{j,3}=sprintf('U%d',xU(i)); % maybe x/y switch
            %Down
            transitionsDatas{j+1,1}=xD(i);
            transitionsDatas{j+1,2}=yD(i);
            transitionsDatas{j+1,3}=sprintf('D%d',xD(i));
            %Left
            transitionsDatas{j+2,1}=xL(i);
            transitionsDatas{j+2,2}=yL(i);
            transitionsDatas{j+2,3}=sprintf('L%d',xL(i));
            %Right
            transitionsDatas{j+3,1}=xR(i);
            transitionsDatas{j+3,2}=yR(i);
            transitionsDatas{j+3,3}=sprintf('R%d',xR(i));
        end
        addOff = nTr ;
        for i = 1: numberOfStates
            j = addOff;
            transitionsDatas{j,1}=i;
            transitionsDatas{j,2}=i;
            transitionsDatas{j,3}=sprintf('nU%d',i); % maybe x/y switch
            %Down
            transitionsDatas{j+1,1}=i;
            transitionsDatas{j+1,2}=i;
            transitionsDatas{j+1,3}=sprintf('nD%d',i);
            %Left
            transitionsDatas{j+2,1}=i;
            transitionsDatas{j+2,2}=i;
            transitionsDatas{j+2,3}=sprintf('nL%d',i);
            %Right
            transitionsDatas{j+3,1}=i;
            transitionsDatas{j+3,2}=i;
            transitionsDatas{j+3,3}=sprintf('nR%d',i);
            addOff = addOff + 4;
        end
%         for i = 1:labySize
%             for j=1:labySize
% 
%             end
%         end
    end
end