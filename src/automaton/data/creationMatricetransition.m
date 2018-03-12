function [ MatriceCell] = creationMatricetransition( nameOfFileFSM )
%% Edit matrice transitions of .fsm file
%   Condition : 
%   state are named with a 'l' in a first case
%
%   transition are named with a 'w','D','L', 'R', 'U' or 'n' in first case 
%
%   Input : nameOfFileFSM   : the name of the file wich contains the
%                              automata
%
%   Output : 
%
%% Open File
    %nameOfFileFSM = 'Commande.fsm';
    F = fopen(nameOfFileFSM,'r');
    
    % StatePatern
    SP = 'l';
    % Transition Patern
    ST = 'UDRL';
    % Include the file in a struct
    C = textscan(F,'%s');
    fclose(F);
    % Include the struct in a vector
    C = C{1,1};
    
    States = cell(str2num(C{1}), 1);
    Transition = [];
    typoTransition = struct('Name','','StateIn','','StateOut','');
    %% Idée en suspens : strjoin(C,'\n')
    i = 2;
    NbS = 0;
    NbT = 0;
    while i <= length(C)    %% While they are cases

         if ~isempty(strfind(SP, C{i}(1)))% If it is a State

            
            NbS = NbS+1;
            States{NbS} = C{i};


            i = i+3;                % Jump 3 cases

            while ~isempty(strfind(ST, C{i}(end))) % While it's a description of
                                                   % a transition
                NbT = NbT + 1;
                Transition = [Transition typoTransition];
                Transition(NbT).Name = C{i};
                i = i+1;                            % Jump a cases
                Transition(NbT).StateIn = States{NbS};
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
    %% Numérotation etats
    EtatInitial = '';
    EtatsMarque = '';
    
    
    for j = 1:length(Transition)
        i = 1;
        while isempty(strfind(States{i}, Transition(j).StateIn))
            i = i+1;
        end
        Transition(j).StateIn = i;
        
    end
    
    for j = 1:length(Transition)
        i = 1;
        while isempty(strfind(States{i}, Transition(j).StateOut))
            i = i+1;
        end
        Transition(j).StateOut = i;
        
    end
    %% Research all Events (Ce qu'ai voulu faire est ...  inutile...
    
    typoEvents = struct('Name',''); 
    Events = [];
    NbE = 0;
    for i = 1:NbT % For all transitions
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
        for j = 1:NbT
           if strcmp(Events(i).Name ,Transition(j).Name)
               if Transition(j).StateIn ~= Transition(j).StateOut % Add
                Events(i).matrice(Transition(j).StateIn, Transition(j).StateOut) = 1;
   
               end
           end
        end

    end
    
    %% Mise en place dans une cellule
    %   Cell contain 10 Events : U - D - L - R - nU - nD - nL - nR - wR - wD
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
%       0
%       1   
%       Transition sortante i    
%           Etat d'arrivée
%           C   On suppose que toute les transitions sont observables et
%           commandables
%           O