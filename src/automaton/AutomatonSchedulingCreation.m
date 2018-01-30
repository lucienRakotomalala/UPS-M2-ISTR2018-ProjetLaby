function [initialIndice,markedStatesIndices,transitionsDatas, numberOfStates]...
= AutomatonSchedulingCreation (scheduling,structureLabyDatas,firstMove)
% Inputs
    % Scheduling : cell  = {x_1,...,x_i,...,x_n}      x_i : char = the i-th
                                                    % move.
                                                    % = 'p' : player
                                                    % = 'w' : walls
    % StrutureLabyDatas  : cell  = {O,D,Tr;.,.,.;}       One line : 1
                                                % transition of the
                                                % labyrinth
                                          % O  = origin state 
                                          % D  = destination state
                                          % Tr = event name
    % firstMove : char =   [x]         % = 'p' the player begin
                                       % = 'w' the walls begin
% Output
    % initialIndice : int  = [x]         x = indice of the initial state
    % markedStatesIndices : int = [.,.,...] indice of the marked states   
    % transitionsDatas : cell  = {O,D,Tr;.,.,.;}       One line : 1 transition
                                          % O  = origin state 
                                          % D  = destination state
                                          % Tr = event name
    % numberOfStates   : int  = [x]         x  = number of states of the
                                            % automaton    
numberOfStates= max(size(scheduling));
initialIndice = strcmp(firstMove,'v')*1 + strcmp(firstMove,'h')*2;
labEvent = unique(structureLabyDatas(:,3));
wallsEvent = {'wD','wR'};
markedStatesIndices = 0;
transitionsDatas = cell( (numberOfStates-1)*(size(labEvent,1)+size(wallsEvent,2)),3 );
indice= 0;
for h = 1:numberOfStates
     if mod(h,2)==0
             for i = 1 : size(labEvent,1)
                transitionsDatas{indice+ i,1}=h;
                transitionsDatas{indice+i,2}=mod(h,numberOfStates)+1;
                transitionsDatas{indice+i,3}=labEvent{i};
             end
             indice = indice + size(labEvent,1);
     else
            for i = 1 : size(wallsEvent,2)
                transitionsDatas{indice+i,1}=h;
                transitionsDatas{indice+i,2}=mod(h,numberOfStates)+1;
                transitionsDatas{indice+i,3}=wallsEvent{i};
            end
             indice = indice + size(wallsEvent,2);

     end
    
end

end