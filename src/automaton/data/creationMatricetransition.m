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
    ST = 'nUDRLw';
    % Include the file in a struct
    C = textscan(F,'%s');
    close('all');
    % Include the struct in a vector
    C = C{1,1};
    
    States = [];
    Transition = [];
    %% Idée en suspens : strjoin(C,'\n')
    i = 1;
    while i <= length(C)
       temp = strfind(C(i),ST)
       if ~isempty(temp{1,1})  % Obligé de regarder si la cellule est vide
           Transition = [Transition C(i)];
           % Jump to the transition level
           
       end
       i = i+1;
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