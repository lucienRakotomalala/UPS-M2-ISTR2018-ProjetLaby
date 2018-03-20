


function str = writeStates(prefix,nbrOfStates,initialIndice,markedStatesIndices)
% Inputs
    % prefix        : cell = {'w','s','l'} for walls, scheduling or labyrinth
    % nbrOfStates   : int  = [x]         x  = number of states of the
                                            % automaton
    % initialIndice : int  = [x]         x = indice of the initial state
    % markedStatesIndices : int = [.,.,...] indice of the marked states 
    
% Output
    % str           : String = ['...\n...\n']  contain the DESUMA formated
                                             % string to create states by 
                                             % reading file from DESUMA.
end


function str = writeTransitions(prefix,datas)
% Inputs
    % prefix        : cell = {'w','s','l'} for walls, scheduling or labyrinth

    % datas : cell  = {O,D,Tr;.,.,.;}       One line : 1 transition
                                          % O  = origin state 
                                          % D  = destination state
                                          % Tr = event name
    
% Output
    % str           : String = ['...\n...\n']  contain the DESUMA formated
                                             % string to create transitions 
                                             % by reading file from DESUMA.
end

%% Pareil pour SaveDESUMAFile
function errorCode = SaveDESUMAFile(transitionsString,statesString,fileName)
% Inputs
    % prefix        : char = {'w','s','l'} for walls, scheduling or labyrinth
    % nbrOfStates   : int  = [x]         x  = number of states of the
                                            % automaton
    % initialIndice : int  = [x]         x = indice of the initial state
    
% Output
    % errorCode           : int =        0 : if work well, 
    %                                    1 : else.
end


%% Automaton of labyrinth struture creation :
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
                                            % automaton    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  A refaire %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%% Walls contraints :
function [initialIndice,markedStatesIndices,transitionsDatas, numberOfStates] ...
= AutomatonWallsContraintsCreation (verticalsWalls,horizontalsWalls,FirstWallsMove)
% Inputs
    % verticalsWalls        : int  = [...]      the verticals walls matrix
    % horizontalsWalls        : int  = [...]    the horizontal walls matrix
                                                 % y  = vertical position
                                                 % of the player
    % FirstWallsMove        : char  = [x]      x = 'v' : the first walls
                                                 % move is vertical
                                             % x = 'h' : the first walls
                                                 % move is horizontal
% Output
    % initialIndice : int  = [x]         x = indice of the initial state                                             % string to create states by 
    % markedStatesIndices : int = [.,.,...] indice of the marked states   
    % transitionsDatas : cell  = {O,D,Tr;.,.,.;}       One line : 1 transition
                                          % O  = origin state 
                                          % D  = destination state
                                          % Tr = event name
    % numberOfStates   : int  = [x]         x  = number of states of the
                                            % automaton    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  A refaire %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
function [initialIndice,markedStatesIndices,transitionsDatas, numberOfStates] ...
= AutomatonSchedulingCreation (Scheduling,PacmanLabyDatas,GhostLabyDatas,FirstWallsMove)
% Inputs
    % Scheduling : cell  = {x_1,...,x_i,...,x_n}      x_i : char = the i-th
                                                    % move.
                                                    % = 'P' : Pacman
                                                    % = 'G' : Ghost
                                                    % = 'w' : walls
    % PacmanLabyDatas      :  for the pacman 
    % GhostLabyDatas       :  for the ghost
    %               cell  = {O,D,Tr;.,.,.;}       One line : 1
                                                % transition of the
                                                % labyrinth
                                          % O  = origin state 
                                          % D  = destination state
                                          % Tr = event name
   
% Output
    % initialIndice : int  = [x]         x = indice of the initial state                                             % string to create states by 
    % markedStatesIndices : int = [.,.,...] indice of the marked states   
    % transitionsDatas : cell  = {O,D,Tr;.,.,.;}       One line : 1 transition
                                          % O  = origin state 
                                          % D  = destination state
                                          % Tr = event name
    % numberOfStates   : int  = [x]         x  = number of states of the
                                            % automaton    
end