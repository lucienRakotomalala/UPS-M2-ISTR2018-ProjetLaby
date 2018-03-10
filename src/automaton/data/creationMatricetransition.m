function [ Matrice] = creationMatricetransition( nameOfFileFSM )
%% Edit matrice transitions of .fsm file
%   Condition : 
%   state are named with a 'l' in a first case
%
%   transition are named with a 'w','D','L', 'R', 'U' or 'n' in first case 
%
%   Input : nameOfFileFSM   : the name of the file wich contains the
%                             automata
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
    close('all');% vaut mieux fermé que F
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
         if ~isempty(strfind(SP, C{i}(1)))
            
            NbS = NbS+1;
            States{NbS} = C{i};

            i = i+3;

            while ~isempty(strfind(ST, C{i}(end))) 

                NbT = NbT + 1;
                Transition = [Transition typoTransition];
                Transition(NbT).Name = C{i};
                i = i+1;
                Transition(NbT).StateIn = States{NbS};
                Transition(NbT).StateOut = C{i};
                i = i+3;
                if i>= length(C)
                    disp('Fin de Loop')
                    break
                end

            end
         else
             i = i+1
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