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
       error('No vector detected in object Input') 
    end
    %% Initialisation
   
    rafA = AutomateGraph();
    %% Clean name of vector
    for i = 1:length(A.vector)
        j = 1;
        getOut = 0;     % Variable to go out the while
        while xor(j <= length(paternName),getOut)
            if strcmp(intersect(A.vector(i).Name{:}, paternName{j},'stable'), paternName{j})
                rafA.vector(i).Name = paternName(j);
                if j<length(paternName)     % To don't destroy the xor effect
                    getOut = 1;
                end
            end
            j = j+1;
        end
    end
     
    %% Set up the langage
    for i = 1:length(rafA.vector)
        if ~isempty(rafA.vector(i).Name)
            if isempty(find(ismember(rafA.vector(i).Name{:}, rafA.langage)==1))
               rafA = rafA.addWord2Langage(rafA.vector(i).Name{:});
            end
        end
    end
    
    %% Set up vector
    for i = 1:length(rafA.langage)
        rafA.vector(i).value = zeros(length(A.vector(1).value));
        % If we recognize it in the vectorName
        for j = 1:length(rafA.vector)
           [l,~,v] = find(A.vector(i).value);       % l for line, v for value
           % For stable transition
           if ~isempty(find(l==v, 1))
               rafA.vector(i).value(find(l==v, 1)) = find(l==v, 1);    % Have to be tested
           end
           % Undeterministic Test
           for q = l'
                if rafA.vector(i).value(q)>0
                    error('Blabla')
                end
           end
           % Add value
           rafA.vector(i).value(l) = A.vector(i).value(l);  %% Have to be tested
        end
    end
end