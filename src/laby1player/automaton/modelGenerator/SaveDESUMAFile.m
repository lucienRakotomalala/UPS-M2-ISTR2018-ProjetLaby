function SaveDESUMAFile(transitionsString,statesString,fileName)
% SAVEDESUMAFILE Save a automaton into input file for DESUMA.
% Inputs :
%       prefix        : char = {'w','s','l'} for walls, scheduling or labyrinth
%       nbrOfStates   : int  = [x]         x  = number of states of the
%                                               automaton.
%       initialIndice : int  = [x]         x = indice of the initial state
%    

fid = fopen(fileName,'w');
fprintf(fid,'%s\n%s',statesString,transitionsString);
fclose(fid);
end

            
