function errorCode = SaveDESUMAFile(transitionsString,statesString,fileName)
% Inputs
    % prefix        : char = {'w','s','l'} for walls, scheduling or labyrinth
    % nbrOfStates   : int  = [x]         x  = number of states of the
                                            % automaton
    % initialIndice : int  = [x]         x = indice of the initial state
    
% Output
    % errorCode           : int =        0 : if work well, 
    %                                    1 : else.
       % if errorCode == 0
            fid = fopen ('DesumaData.txt','w');
            fprintf(fid,'%s %s %s\n',transitionsString, statesString,fileName)
            fclose(fid);
       % else
       %     error ('Replay')
       % end
end

            
