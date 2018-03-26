function [States, Transition] = getStateTransitionFSM( nameOfFileFSM, ST, SP )
% This function return struct of States and Transitons of an automata describes
%   in .fsm files for Desuma 
%   Input   : 
%           nameOfFileFSM   : contain the name of the fsm File 
%           ST              : Contain the patern of the transition
%           SP              : Contain the patern of the state
%   Output :
%           States          : struct which contains every states asociated
%                           with 'Name', 'Initial' and 'Marked'.
%           Transition      : struct which contains every transition asociated
%                           with 'Name', 'StateIn' and 'StateOut'.
%% Open File
    %nameOfFileFSM = 'Commande.fsm';
    F = fopen(nameOfFileFSM,'r');
    

    % Include the file in a struct
    %C = textscan(F,'%s');
    
    % Include the struct in a vector
    %C = C{1,1};
    
    States = [];
    typoState = struct('Name','','Initial',0,'Marked',0);
    NbS = 0;
    Transition = [];
    typoTransition = struct('Name','','StateIn','','StateOut','');
    NbT = 0;
    strState = 1;
    %% 
     while(~feof(F))
     str = fgetl(F);
     str = strsplit(str);
     if strState == 1
        strStateNext = 2; 
     end
     
     if strState == 2
        strStateNext = 3;
     end
     
     if strState == 3
        if ~isempty(strfind(str{1},'EVENTS')) % If it is a declaration of a State
            strStateNext = 5;
        else
            if isempty(str{1})
                strStarNext = 5;
            else
                NbS = NbS +1;
                States = [States typoState]; 
                if NbS == 1 
                    States(NbS).Initial = 1;
                end
                States(NbS).Name = cellstr(str(1));
                States(NbS).Marked = cell2mat(str(2));
                strStateNext = 4;
            end
        end 
     end
     
     if strState == 4
          if ~isempty(str{1}) % If it os the declaration of a Transition
            NbT = NbT + 1;
            Transition = [Transition typoTransition];
            Transition(NbT).Name    = cellstr(str{1});
            Transition(NbT).StateIn = States(NbS).Name;     % State In is the previous State
            Transition(NbT).StateOut = cellstr(str{2});     % State Out is on the line     
          else
             strStateNext = 3;
          end
     end
        
       
     strState = strStateNext;   
     end
     
     fclose(F);

         
    end

