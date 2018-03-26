function [ rafA ] = rafineAutomatonClass( A, paternName )
%% This function permits to clean the procede automata from a AutomateGraph object
%   It keep the good name of transition to do a Parallel Product with a
%   command.
%   
%   WARNING : You have to put in paternName every transition Name you want
%   to keep. The transition Name which are not in PaternName will be
%   destroy.
%   Input :     A           : object which need to be clean 
%               paterName   : cell of the Name of transitions which have to
%               be clean
%
%   Output :    rafA        : object clean
%
%       Example of patern Name
%       paterName = {'nU', 'nD', 'nR', 'nL', 'U', 'D', 'R', 'L', 'wD', 'wR'};
%
    if ~isa(A, 'AutomateGraph')
        error('Input A must be a object from AutomateGraph Class')
    end
    if ~isa(paternName, 'cell')
        error('Input paternName must be a cell')
    end
    if ~isa(A.vector, 'struct')
       A.matrices2vector();
    end
    %% Initialisation
   
    rafA = AutomateGraph();
	temp = AutomateGraph();		% For the Transition Name
    %% Clean name of vector
    for i = 1:length(A.vector)
        j = 1;
        getOut = 0;     % Variable to go out the while
        while xor(j <= length(paternName),getOut)
            if strcmp(intersect(A.vector(i).Name{:}, paternName{j},'stable'), paternName{j})
                temp.vector(i).Name = paternName(j);
                if j<length(paternName)     % To don't destroy the xor effect
                    getOut = 1;
                end
            end
            j = j+1;
        end
    end
     
    %% Set up the langage
    for i = 1:length(temp.vector)
        if ~isempty(temp.vector(i).Name)
            if isempty(find(ismember(temp.vector(i).Name{:}, rafA.langage)==1))
               rafA = rafA.addWord2Langage(temp.vector(i).Name{:});
            end
        end
    end
    
    %% Set up vector
    allPoint = 1:length(temp.vector);
    
    for i = 1:length(rafA.langage)
        memory = [];
        % Add Transition Name
        rafA.vector(i).Name = rafA.langage(i);
        % Initialize the vector
        rafA.vector(i).value = zeros(length(A.vector(1).value),1);
        
        for j = allPoint      % Optimisation possible
			
            if   strcmp(rafA.langage(i), temp.vector(j).Name)
                [l,~,~] = find(A.vector(j).value);       % l for line
                % Undeterministic Test
                if rafA.vector(i).value(l) - A.vector(j).value(l) >0  
                    error('Undeterministic case find in the vector')
                end
                % Add value
                rafA.vector(i).value(l) = A.vector(j).value(l);  %% Have to be tested
                % Optimisation
                memory = [memory j];
            end
        end
        allPoint = setdiff(allPoint, memory);
    end

    
    %% AJOUTER LES STATES NAME 
    if isa(A.state,'struct')
        rafA.state = A.state;
    else
        disp('Can not add state to the rafine Automata because the input do not contains a struct field in is state field')
    end
end