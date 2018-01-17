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
    % initialIndice : int  = [x]         x = indice of the initial state                                             % string to create states by 
    % markedStatesIndices : int = [.,.,...] indice of the marked states   
    % transitionsDatas : cell  = {O,D,Tr;.,.,.;}       One line : 1 transition
                                          % O  = origin state 
                                          % D  = destination state
                                          % Tr = event name
    % numberOfStates   : int  = [x]         x  = number of states of the
                                            % automaton  
                                            
	transitionsData = cell(
    for i = 1:labySize
        for j=1:labySize
            
    end
end