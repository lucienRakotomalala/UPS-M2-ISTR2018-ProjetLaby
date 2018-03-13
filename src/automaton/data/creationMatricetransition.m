function [ MatriceCell, Alphabet] = creationMatricetransition( nameOfFileFSM )
%% Edit matrice transitions of .fsm file and .txt file
%   Condition : state are named with a 'l' in a first case
%
%   transition are named with a 'w','D','L', 'R', 'U' or 'n' in first case
%
%   Input : nameOfFile        : the name of the file wich contains the
%                              automata
%
%   Output                    : cell with All Transitions Matrix
%

    % StatePatern
    SP = 'l';
    % Transition Patern
    ST = 'UDRL';
%% Selection Type of File
    if strcmp(nameOfFileFSM(end-2:end), 'fsm')
       [States, Transition] = getStateTransitionFSM(nameOfFileFSM,ST, SP);       
    else if strcmp(nameOfFileFSM(end-2:end), 'txt')
           [States, Transition] = getStateTransitionTXT(nameOfFileTXT);
            
        else
            error('Not a file suported')
        end
    end

    %% Numérotation etats
    EtatInitial = '';
    EtatsMarque = '';
    
    
    for j = 1:length(Transition)
        i = 1;
        while ~strcmp(Transition(j).StateIn, States(i).Name)
            i = i+1;
        end
        Transition(j).StateIn = i;
        
    end
    
    for j = 1:length(Transition)
        i = 1;
        while ~strcmp(States(i).Name, Transition(j).StateOut)
            i = i+1;
        end
        Transition(j).StateOut = i;
        
    end
    %% Research all Events (Ce qu'ai voulu faire est ...  inutile...
    
    typoEvents = struct('Name',''); 
    Events = [];
    NbE = 0;
    for i = 1:length(Transition) % For all transitions
		isAlreadyAnEvent = 0;
        for j = 1:NbE
           isAlreadyAnEvent = isAlreadyAnEvent + strcmp(Events(j).Name, Transition(i).Name) ;
        end
        if ~isAlreadyAnEvent   % If it is not an event
            NbE = NbE + 1;
            Events = [Events typoEvents];
            Events(end).Name = Transition(i).Name;
        end
    end
    
    %% Creation des matrices
    for i = 1 :NbE
        Events(i).matrice = zeros(length(States),length(States));
        for j = 1:length(Transition)
           if strcmp(Events(i).Name ,Transition(j).Name)
               if Transition(j).StateIn ~= Transition(j).StateOut % Add
                Events(i).matrice(Transition(j).StateIn, Transition(j).StateOut) = 1;
   
               end
           end
        end

    end
    
    %% Expression of Langage of System
  %   e= strcat(Events.Name,{' '});
  Alphabet = [];  
  for i = 1:NbE
        Alphabet = [Alphabet cellstr(Events(i).Name)];
  end
    %% Mise en place dans une cellule
    %   Cell contain 10 Events : U - D - L - R - nU - nD - nL - nR - wR -
    %   wD
    % 
    MatriceCell = cell(10,1);
    cellOrder = {'U', 'D' 'L','R','nU','nD','nL','nR','wR','wD'};
   for i = 1:length(cellOrder)
       isEventExist = 0;
       j = 1;
       while j<= length(Events)
            if strcmp(Events(j).Name, cellOrder(i))
                break;
            end
            j = j+1;
       end
       if j <= length(Events)
            MatriceCell{i} = Events(j).matrice;
       else
           MatriceCell{i} = zeros(NbS, NbS);
       end
    end
end
%% Fichier cellule fsm
%
%  1 Nombre d'etat
%
%   2 Etat i
%       0 1 Transition sortante i
%           Etat d'arrivée C   On suppose que toute les transitions sont
%           observables et commandables O