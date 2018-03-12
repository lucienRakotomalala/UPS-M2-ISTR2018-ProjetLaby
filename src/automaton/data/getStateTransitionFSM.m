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
    C = textscan(F,'%s');
    fclose(F);
    % Include the struct in a vector
    C = C{1,1};
    
    States = [];
    typoState = struct('Name','','Initial',0,'Marked','1');
    Transition = [];
    typoTransition = struct('Name','','StateIn','','StateOut','');
    %% Idée en suspens : strjoin(C,'\n')
    i = 2;
    NbS = 0;
    NbT = 0;
    while i <= length(C)    %% While they are cases

         if ~isempty(strfind(SP, C{i}(1)))% If it is a State
            States = [States typoState]; 
            NbS = NbS+1;
            % Specificity of FSM
            if NbS == 1
                States(NbS).Initial = 1;
            end
            States(NbS).Name = C{i};
            % Mared Place is the number next
            i = i+1;
            States(NbS).Marked = str2num(C{i});
            i = i+2;                % Jump 2 cases

            while ~isempty(strfind(ST, C{i}(end))) % While it's a description of
                                                   % a transition
                NbT = NbT + 1;
                Transition = [Transition typoTransition];
                Transition(NbT).Name = C{i};
                i = i+1;                            % Jump a cases
                Transition(NbT).StateIn = States(NbS).Name;
                Transition(NbT).StateOut = C{i};
                i = i+3;                            % Jump 3 cases
                if i>= length(C)                    % Ifthe last jump end the cell

                    disp('Fin de Loop')
                    break
                end

            end
         else
             i = i+1;
         end
         
    end
end

