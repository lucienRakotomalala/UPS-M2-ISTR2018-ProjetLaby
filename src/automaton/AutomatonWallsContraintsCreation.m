function [initialIndice,markedStatesIndices,transitionsDatas, numberOfStates] = AutomatonWallsContraintsCreation (verticalsWalls,horizontalsWalls,FirstWallsMove)
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

labySize = max(size(verticalsWalls));
% number Of States
numberOfStates = labySize*2;
%initial Indice
initialIndice = strcmp(FirstWallsMove,'v')*1 + strcmp(FirstWallsMove,'h')*2;
% marked States Indices
markedStatesIndices = 0;% a faire 

% 
for i = 1 : labySize  %ligne
    for j = 1 : labySize %colonne
        % en (i,j) si murs alors pas deplacement possible dans la direction
    end
end

end