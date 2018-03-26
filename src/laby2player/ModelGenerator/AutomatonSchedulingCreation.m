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
    %    cell  = {O,D,Tr;.,.,.;}       One line : 1
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

numberOfStates= max(size(Scheduling));
numberOfPacmanLabyStates = max(cell2mat(PacmanLabyDatas(:,2)));
numberOfGhostLabyStates = max(cell2mat(GhostLabyDatas(:,2)));
initialIndice = strcmp(FirstWallsMove,'v')*1 + strcmp(FirstWallsMove,'h')*2;
labPacevent = (PacmanLabyDatas(:,3));
labPacevent = labPacevent(1:end-17); 
labGhostevent = (GhostLabyDatas(:,3));
labGhostevent = labGhostevent(1:end-16); %tous w_
wallsEvent = {'wD','wR'};
markedStatesIndices = 0;
 PactransitionsDatas = cell( (numberOfStates-2)*(size(labPacevent,1)+size(wallsEvent,2))... moves tr
                        + 4*numberOfPacmanLabyStates... not possible moves
                         ,3 );
  GhostransitionsDatas = cell( (numberOfStates-2)*(size(labGhostevent,1)+size(wallsEvent,2))... moves tr
                        + 4*numberOfGhostLabyStates... not possible moves
                         ,3 );
indice= 0;
    for h = 1:numberOfStates
        if mod(h,2)==0
             for i = 1 : size(labPacevent,1)
                 if cellfun('isempty',(strfind(labPacevent(i,1),'w')))
                       PactransitionsDatas{indice+i,1}=h;
                PactransitionsDatas{indice+i,2}=mod(h,numberOfStates)+1;
                PactransitionsDatas{indice+i,3}=labPacevent{i};
                    
                 else
                    PactransitionsDatas{indice+i,1}=h;
                PactransitionsDatas{indice+i,2}=h;
                PactransitionsDatas{indice+i,3}=labPacevent{i}; 
                
                    
                 end
                 
             end
       
                 
             indice = indice + size(labPacevent,1);
         else
            for i = 1 : size(wallsEvent,2)
                PactransitionsDatas{indice+i,1}=h;
                PactransitionsDatas{indice+i,2}=mod(h,numberOfStates)+1;
                PactransitionsDatas{indice+i,3}=wallsEvent{i};
            end
            indice = indice + size(wallsEvent,2);

        end
    
    end
    %indice = 0;
for h = 1:numberOfStates
        if mod(h,3)==0
             for i = 1 : size(labGhostevent,1)
                  if cellfun('isempty',(strfind(labGhostevent(i,1),'w')))
                GhostransitionsDatas{indice+ i,1}=h;
                GhostransitionsDatas{indice+i,2}=mod(h,numberOfStates)+1;
                GhostransitionsDatas{indice+i,3}=labGhostevent{i};
                  else
                       GhostransitionsDatas{indice+ i,1}=h;
                GhostransitionsDatas{indice+i,2}=h;
                GhostransitionsDatas{indice+i,3}=labGhostevent{i};
                  end
                  
                      
             end
             indice = indice + size(labGhostevent,1);
%          else
%             for i = 1 : size(wallsEvent,2)
%                 GhostransitionsDatas{indice+i,1}=h;
%                 GhostransitionsDatas{indice+i,2}=mod(h,numberOfStates)+1;
%                 GhostransitionsDatas{indice+i,3}=wallsEvent{i};
%             end
%             indice = indice + size(wallsEvent,2);

        end
end
    % not possibles moves
    
    % calc des noms de tr 
   
%     str = cell(4*numberOfPacmanLabyStates,1) + cell(4*numberOfGhostLabyStates,1);
%     
%     num = 1 : (numberOfPacmanLabyStates*numberOfGhostLabyStates);
%     
%     dir = ['pU','pL','pD','pR','gU','gL','gD','gR']';
%     
%     for l = 1 : length(dir) % 
%         for k = 1:length(num) 
%             str{(l-1)*length(num) + k} = sprintf('n%s%d',dir(l),num(k));
%         end
%     end
     strP = cell(4*numberOfPacmanLabyStates,1);
    
    num = 1 : numberOfPacmanLabyStates;
    
    dir = ['pU','pL','pD','pR']';
    
    for l = 1 : length(dir) % 4 elem
        for k = 1:length(num) % de 1 ? 9
            strP{(l-1)*length(num) + k} = sprintf('w_%s%d',dir(l),num(k));
        end
    end
    strG = cell(4*numberOfGhostLabyStates,1);
    
    numG = 1 : numberOfGhostLabyStates;
    
    dirG = ['gU','gL','gD','gR']';
    
    for m = 1 : length(dirG) % 4 elem
        for K = 1:length(numG) % de 1 ? 9
            strG{(m-1)*length(numG) + K} = sprintf('w_%s%d',dirG(m),numG(K));
        end
    end
    % formatage tr std 
    
    g = (numberOfStates-1)*(size(labPacevent,1)+size(wallsEvent,2));
    for h = 1 :  4*numberOfPacmanLabyStates
        
        PactransitionsDatas{g+h,1}=2;
        PactransitionsDatas{g+h,2}=2;
        PactransitionsDatas{g+h,3}=strP{h};
    end
    
    z = (numberOfStates-1)*(size(labGhostevent,1)+size(wallsEvent,2));
    for y = 1 :  4*numberOfGhostLabyStates
        
        GhostransitionsDatas{z+y,1}=2;
        GhostransitionsDatas{z+y,2}=2;
        GhostransitionsDatas{z+y,3}=strG{y};
    end
transitionsDatas = [PactransitionsDatas;GhostransitionsDatas];
end

