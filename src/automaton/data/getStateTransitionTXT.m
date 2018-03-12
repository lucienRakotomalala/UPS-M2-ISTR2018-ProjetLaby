function [States, Transition] = getStateTransitionTXT( nameOfFileTXT, ST, SP )
% This function return struct of States and Transitons of an automata describes
%   in .txt files for Desuma 
%   Input   : 
%           nameOfFileTXT   : contain the name of the fsm File 
%   Output :
%           States          : struct which contains every states asociated
%                           with 'Name', 'Initial' and 'Marked'.
%           Transition      : struct which contains every transition asociated
%                           with 'Name', 'StateIn' and 'StateOut'.
%% Open File
    %nameOfFileFSM = 'Commande.fsm';
    F = fopen(nameOfFileTXT,'r');
    Transition = [];
    typoTransition = struct('Name','','StateIn','','StateOut','');
    
    State = [];
    typoState = struct('Name','','Initial',0,'Marked',0);
    
    while ~feof(F)
        str = fgetl(F)
        if length(str) > 0
            if strcmp(str(1),'s')   % The line is a state
                State = [State typoState];
                str = strsplit(str,' ');
                State(end).Name = str(2);
                if length(str)>2 % If it is a Marked or Initial State
                    if strcmp(str(3),'-I')
                        State(end).Initial = 1;
                    end
                    if strcmp(str(3),'-M')
                        State(end).Marked = 1;
                    end
                end
            end
            if strcmp(str(1),'t')   % The line is a transition
                Transition = [Transition typoTransition];
                str = strsplit(str,' ');
                Transition(end).StateIn     = str(2);
                Transition(end).StateOut    = str(3);
                Transition(end).Name        = str(4);
            end
        end
    end
    fclose(F);
end

