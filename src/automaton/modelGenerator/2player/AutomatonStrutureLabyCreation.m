function [initialIndice,markedStatesIndices,transitionsDatas, numberOfStates] = AutomatonStrutureLabyCreation (labySize,playerPosition,escapePosition,playerName)
% Inputs
    % labySize        : int  = [x]         x  = dimension of the labyrinth
    % playerPosition        : int  = [x,y]         x  = horizontal position
                                                 % y  = vertical position
                                                 % of the player
    % escapePosition        : int  = [x,y]         x  = horizontal position
                                                 % y  = vertical position
                                                 % of the escape
    % playerName            : string = ='G' for Ghost 
                                       %'P' for Pacman
% Output
    % initialIndice : int  = [x]         x = indice of the initial state                                             % string to create states by 
    % markedStatesIndices : int = [.,.,...] indice of the marked states   
    % transitionsDatas : cell  = {O,D,Tr;.,.,.;}       One line : 1 transition
                                          % O  = origin state 
                                          % D  = destination state
                                          % Tr = event name
    % numberOfStates   : int  = [x]         x  = number of states of the
                                            % automaton    % number Of States
                                            
%%%%%%%%%%%%%%                                             
% for know if is the pacman lab                                            
if strcmp('P',playerName)==1
    isPacman = 1;
else
    isPacman = 0;
end
%%%%%%%%%%%%%% Nbr of Transition and State
% a labyrinth                                            
%   +-+-+-+
%   |c|b|c|
%   +-+-+-+
%   |b|m|b|
%   +-+-+-+
%   |c|b|c|
%   +-+-+-+
%   nTr =  (if labySize>1 :) nbOf_c*2tr + (if labySize >2 :) + nbOf_b*3tr + (if labySize >2 :) nbOf_m*4tr 
nTrMvs = (labySize>1)*4*2 + (labySize>2)*(labySize-2)*(4*3+(labySize-2)*4);
if isPacman
    % States
    numberOfStates = labySize^2;
    % Transitions
    nTr= nTrMvs... moving tr
        + 4*numberOfStates ... for w_{U,D,L,R}{1,...,numberOfStates}
        + numberOfStates...   add one tr stable for every state rpz laby places P{1,...,numberOfStates}
        + 1 ; % for escape
else
    % States
    numberOfStates = labySize^2+1;
   nTr= nTrMvs... moving tr
        + 5*(numberOfStates-1) ... for w_{escape,U,D,L,R}{1,...,labySize^2}
        + numberOfStates-1; %  add one tr stable for every state rpz laby places P{1,...,labySize^2}
end
%%%%%%%%%% Initial and marked states indices
% initial Index
initialIndice = ( playerPosition(2) - 1 )*labySize + playerPosition(1);
% marked indices
if isPacman
    markedStatesIndices = ( escapePosition(2) - 1 )*labySize + escapePosition(1);
    
else 
    markedStatesIndices = 1:(numberOfStates-1);
end

    if (nTr>0)
        %%%%%%%%%%%% Transitions variable
        transitionsDatas = cell(nTr,3);%-1
        %%%%%%%%%%%% No walls Up (U), Down (D), Left (L) and Right (R) matrix
        emptyWalls = zeros(labySize,labySize-1);
        [U,D,L,R] = generer_lab(emptyWalls',emptyWalls);
        % U : Up ; D : Down ; L:Left ; R:Right
        % U(y,x)    =1 : can move from state x to state y
        %           =0 : can't move
        % same for D, L and R
        [yU,xU] =   find(U);
        [yD,xD] =   find(D);
        [yL,xL] =   find(L);
        [yR,xR] =   find(R);
        %%%%%%%%%%%%%%%% Possibles transitions for a no walls maze
        for i = 1:nTrMvs/4 ; 
            %Up
            j = (i-1)*4+1;
            transitionsDatas{j,1}=xU(i);
            transitionsDatas{j,2}=yU(i);
            transitionsDatas{j,3}=sprintf('U%s%d',playerName,xU(i)); % maybe x/y switch
            %Down
            transitionsDatas{j+1,1}=xD(i);
            transitionsDatas{j+1,2}=yD(i);
            transitionsDatas{j+1,3}=sprintf('D%s%d',playerName,xD(i));
            %Left
            transitionsDatas{j+2,1}=xL(i);
            transitionsDatas{j+2,2}=yL(i);
            transitionsDatas{j+2,3}=sprintf('L%s%d',playerName,xL(i));
            %Right
            transitionsDatas{j+3,1}=xR(i);
            transitionsDatas{j+3,2}=yR(i);
            transitionsDatas{j+3,3}=sprintf('R%s%d',playerName,xR(i));
        end
        
        %%%%%%%%%%%% Walls presence transitions(impossibles moves)
        addOff = nTrMvs ;
        
        for i = 1: labySize^2
            j = addOff+1;
            transitionsDatas{j,1}=i;
            transitionsDatas{j,2}=i;
            transitionsDatas{j,3}=sprintf('w_U%s%d',playerName,i); 
            %Down
            transitionsDatas{j+1,1}=i;
            transitionsDatas{j+1,2}=i;
            transitionsDatas{j+1,3}=sprintf('w_D%s%d',playerName,i);
            %Left
            transitionsDatas{j+2,1}=i;
            transitionsDatas{j+2,2}=i;
            transitionsDatas{j+2,3}=sprintf('w_L%s%d',playerName,i);
            %Right
            transitionsDatas{j+3,1}=i;
            transitionsDatas{j+3,2}=i;
            transitionsDatas{j+3,3}=sprintf('w_R%s%d',playerName,i);
            if isPacman==0
                 % Escape
                transitionsDatas{j+4,1}=i;
                transitionsDatas{j+4,2}=i;
                transitionsDatas{j+4,3}=sprintf('escape');
                            addOff = addOff + 5;
            else
                addOff = addOff + 4;
            end
        end
       j = 1;
        if isPacman
            for i = (addOff+1):(nTr-1)
                transitionsDatas{i,1}=j;
                transitionsDatas{i,2}=j;
                transitionsDatas{i,3}=sprintf('P%d',j);
                j = j+1;
            end
            % escape
            transitionsDatas{end,1}=numberOfStates;
            transitionsDatas{end,2}=numberOfStates;
            transitionsDatas{end,3}=sprintf('escape');
        else
            for i = addOff+1 : nTr
                transitionsDatas{i,1}=j;
                transitionsDatas{i,2}=numberOfStates;
                transitionsDatas{i,3}=sprintf('P%d',j);
                j = j +1;
            end
        end
    end
end