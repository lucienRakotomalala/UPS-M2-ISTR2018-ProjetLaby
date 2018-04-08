function str = writeStates(prefix,nbrOfStates,initialIndice,markedStatesIndices)
% WRITESTATES Write states of a automaton in the DESUMA format.
% Inputs :
%       prefix        : cell = {'w','s','l'} For walls, scheduling or labyrinth
%       nbrOfStates   : int  = [x]           x  = number of states of the
%                                                 automaton
%       initialIndice : int  = [x]     x = indice of the initial state
%       markedStatesIndices : int = [.,.,...] indice of the marked states 
% Output
%       str           : String = ['...\n...\n']  Contain the DESUMA formated
%                                                string to create states by 
%                                                reading file from DESUMA.
str ='';  
for i = 1:nbrOfStates
    if (i == initialIndice)
        str = sprintf('%ss %s%d -I \n',str,prefix,i);
    elseif isempty(find(i == markedStatesIndices)) == 0
        str = sprintf('%ss %s%d -M \n',str,prefix,i);
    else
        str = sprintf('%ss %s%d \n',str,prefix,i);
    end
end
end
