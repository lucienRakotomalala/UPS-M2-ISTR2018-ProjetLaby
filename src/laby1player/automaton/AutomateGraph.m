classdef AutomateGraph % Claire a choisi le titre
    %AutomateGraph This class is used to define a deterministic automaton in this part of the project.
    %   It contains in these properties what allows to define an automaton. 
	%   It allows with these methods to perform operations on an automaton. 
    %	
	%	To get all the features of this class, we advise you to download (free) DESUMA at the following address : <a href="matlab: 
	%	web('http://vhosts.eecs.umich.edu/umdes//projects/lib/download_access/submit_desuma.html')">DESUMA Web site</a>
	%
	%	
    properties
        state       % Structure of all States of the automata
                    % Particular Type :
                    % Each state contains :   -Name 
                    %                         -Initial : 1 if it's the Only
                    %                         One Initial State, 0 if not
                    %                         -Marked  : 1 if the state
                    %                         is marked
        transition  % Structure of all Transitions of the automata
                    % Particular Type :
                    % Each transition contains :  
                    %                         -Name 
                    %                         -StateIn : the state number
                    %                         of the source State
                    %                         -StateOut : the state number
                    %                         of the destination State
        matrixTrans % Structure of all transitions with a matrix representation.
					% Particular Type :
                    % Each matrixTrans contains :  
                    %                         -Name 
                    %                         -matrice : contain the matrix size (N,N)
					%								N = number of state
        langage		% 
        vector		% Structure of all transitions with a vector representation.
					% Particular Type :
                    % Each matrixTrans contains :  
                    %                         -Name 
                    %                         -value : contain the vector size (N)
					%								N = number of state
    end
    
    methods
        
        function obj = AutomateGraph()
            
        end
        %% Method FSM2Automata
        function obj = FSM2Automata(obj, nameFileFSM)
			% FSM2Automata is a function that allows to transform a DESUMA automaton (UMDES) 
			%	to an object of the class AutomateGraph.
			%
			%	Example : 
			%	A = AutomateGraph();
			%	A = A.FSM2Automata('myAutomate.fsm');
			%		'A' is a automate with states and transition properties completed.
			%
			%	See also : AUTOMATEGRAPH, EXPORT2DESUMA
			
			%% Shielding
            if ~exist(nameFileFSM,'file')
                error('Name of file FSM is invalid')
            end
            [st, tr] = getStateTransitionFSM(nameFileFSM, 0, 0);
            
            if ~isa(st, 'struct')
                error('The object do not dispose a state struct. Problem in transposition of FSM File');
            end
            if ~isa(tr, 'struct')
                error('The object do not dispose a transition struct. Problem in transposition of FSM File');
            end
			
			%% Recuperation
            for i = 1:length(st)
               if isa(st(i).Name ,'cell')
                   if ~isnan(str2double(st(i).Name{:}))
                    obj.state(i).Name = str2double(st(i).Name{:});
                   end
               end
               if isa(st(i).Marked ,'char')
                  obj.state(i).Marked = str2double(st(i).Marked);
               end
               obj.state(i).Initial = st(i).Initial;
            end
            
            for i = 1:length(tr)
                if isa(tr(i).StateIn, 'cell')
                    obj.transition(i).Name = (tr(i).Name{:});
                end
                if isa(tr(i).StateIn, 'cell')
                    obj.transition(i).StateIn = str2double(tr(i).StateIn{:});
                end
                if isa(tr(i).StateOut, 'cell')
                    obj.transition(i).StateOut = str2double(tr(i).StateOut{:});
                end
            end
        end

       
        %% Method vector2matrices
        function obj = vector2matrices(obj)
			% vector2matrices is a function that transpose transition function from vector to matrix.
			% It keep the name of event. The matrix representation is not deleted after this function.
			%
			%	See also : MATRICES2VECTOR
			%% Shielding
            if ~isa(obj.vector, 'struct')
                error('Inout object must have a struct in "vector" parameters')
            end
            
            for i = 1:length(obj.vector)
                % Association of Names   
                obj.matrixTrans(end+1).Name = obj.vector(i).Name;    
                obj.matrixTrans(end).matrice = zeros(length(obj.vector(i).value), length(obj.vector(i).value));
                for j  = find(obj.vector(i).value>=1)'
                    % Association in matrix
                    obj.matrixTrans(end).matrice(j, obj.vector(i).value(j)) = 1;
                end
            end
        end
		
		
		
        %% Method addWord2langage
        function obj = addWord2Langage(obj, word)
			% addWord2Langage is a simple function to put in the language's vector the word give in input.
            obj.langage{end+1} = {word};
            obj.langage = [obj.langage{:}];
        end
        
        %% Method adaptYourLangage
        function obj = adaptTourLangage(obj)
            obj.langage = [obj.langage{:}];
        end
		
		
        function obj = structAutomata2vectorAutomata (obj)
			%% Method structAutomata2vectorAutomata 
			% Return the object with an update of langage, matrix and vector of
			% the automata object.
			%       Input   : Object with Transitions and States
			%       Ouput   : Object with new Matrix, Vectors and Langage
			%       according to States and Transitions
        
            %% Set language
            obj = obj.addWord2Langage(obj.transition(1).Name);
            for i = 1:length(obj.transition)            
                if isempty(find(ismember(obj.transition(i).Name, obj.langage)==1))
                    obj = obj.addWord2Langage(obj.transition(i).Name);
                end
            end
			
			%% Set matrices
            for i = 1 :length(obj.langage)
                obj.matrixTrans(i).matrice = zeros(length(obj.state),length(obj.state));
                obj.matrixTrans(i).Name = obj.langage(i);
                for j = 1:length(obj.transition)
                    if strcmp(obj.matrixTrans(i).Name ,obj.transition(j).Name)
                            obj.matrixTrans(i).matrice(obj.transition(j).StateIn, obj.transition(j).StateOut) = 1;
                    end
                end
            end
            
            % Conversing to vector
            obj.matrices2vector();
        end
		
		
		
        %% Set Vectors
        function obj = matrices2vector(obj)
			% matrices2vector is a function that transpose transition function from vector to matrix.
			% It keep the name of event. The matrix representation is not deleted after this function.
			%
			% See also : VECTOR2MATRICES
            for i = 1:length(obj.langage)
               obj.vector(i).Name  = obj.langage(i);
               % Assignement of a value for each row
               obj.vector(i).value = obj.matrixTrans(i).matrice*[1:length(obj.state)]';
            end
        end
        
        %% Recherche d'une sequence optimale et existente pour objectif
        %donné
        
        function [path, tree_new] = PathResearche(obj, initialState, studiedState)
			% PathResearche is a function that allows to determine the paths from one state to another.
			%	Input 	: 	InitialState 	is the number of witch state you want to start.
			%				stuiedState 	is the number of witch state you want to arrive.
			%	Output 	:	path 			is a vector containing a list of states covered. 
			%				tree_new		is a vector containing the numbers of the transitions encountered.
			%
			% Example : You can find one in the main script.
            s=[];
            t=[];
            tree = [];
            for c = 1:size(obj.vector,2)
                tr_buff = obj.vector(c).value;
                tic
                for ligne = 1:size(tr_buff,1)
                    s_from = ligne;
                    t_out = tr_buff(ligne);
                    if(t_out ~= s_from && t_out ~=0 ) %teste si pas tr stable et tr existante
                        s = [s s_from];
                        t = [t t_out];
                       tree = [tree c];
                    end
                end
                toc
                    
            end
            
       
            G = digraph(s,t);
            plot(G)
            path = shortestpath(G,initialState,studiedState,'Method','positive');
            
            cnt=1;
            for indice = 1 : length(path)-1
                s_path = path(indice);
                t_path = path(indice+1);
                
                for tr = 1:length(s)
                    if (s(tr) == s_path && t(tr)==t_path)
                        tree_new(cnt) = tree(tr);
                        cnt = cnt+1;
                    end
                end
            end
        end
        %% 
		
		
		
		
        function obj = vector2structAutomata(obj)
			% vector2structAutomata is a function that transpose transition function from vector to structure transition.
			% 
			%	
			% See also : VECTOR2MATRICES, MATRICES2VECTOR.
            obj.transition = [];
            %obj.matrices2vector();
            for i = 1:length(obj.vector)
                [l,~,v] = find(obj.vector(i).value);
                for j = 1:length(l)
                    obj.transition(end+1).Name = obj.vector(i).Name;
                    obj.transition(end).StateIn = l(j);
                    obj.transition(end).StateOut = v(j);
                end
            end
        end
        
        %% Export To Desuma file (txt)
        function obj = export2DESUMA(obj, file)
			% export2DESUMA is a function that export the current instance of AutomateGraph to a text file. This text file can be read by DESUMA.
            % You have to put automata with vector and state struct IN.
			%
			%
			%	Example : 
			%		A = AutomateGraph();		% Create a Empty Automate
			%		A.export2DESUMA('myAutomate.txt');
            obj = obj.vector2structAutomata;
            dataTransition = struct2cell(obj.transition);
            dataTransition = permute(dataTransition,[3 1 2]); 
            dataTransition = circshift(dataTransition, 2,2);
            if isa(dataTransition{1,3},'char')
                
                for i = 1:length(obj.transition)
                   dataTransition{i,3} =  dataTransition{i,3};
                end
            else
               
                for i = 1:length(obj.transition)
                   dataTransition{i,3} =  dataTransition{i,3}{:};
                end 
                
            end
            stringTransition = writeTransitions('r', dataTransition);
            stringState = writeStates('r', length(obj.state), find([obj.state.Initial]), 0);
            SaveDESUMAFile(stringTransition, stringState, file);
        end
        
        %% 
        function obj = sortStateAutomate(obj)
			%	accessibilityAutomate is a function that can be used to sort inaccessible states of a Automate.
			%	It returns an instance of AUTOMATEGRAPH witch only has transition vector of accessible state.
			%	It deletes every states that are not accessible from the Initial state.
			%    Warning : the initial state is always n°1. Change it if it is not the case of your automata.
		
		
            % It's easy to do it in a Automate represented by vectors.
            if ~isa(obj.vector, 'struct')
                obj = obj.vector2matrices;
            end
			% Initial state is one here. Change it !!
            allVector = [obj.vector.value];
            accessibleState = 1; % Initial state
            i = 1;
            while i <= length(accessibleState)
               [~,~, newStates] = find(allVector(accessibleState(i), :));
               accessibleState = union(accessibleState,newStates, 'stable');
               i = i+1;
            end
            % 
            for i = 1:length(obj.vector)
               obj.vector(i).value = obj.vector(i).value(accessibleState',:); 
               l = find(obj.vector(i).value);
               for j = l'
                  obj.vector(i).value(j) = find(obj.vector(i).value(j) == accessibleState); 
               end
            end
            g = obj.state;  
            obj.state = [];
            for i = 1:length(accessibleState)
                obj.state(i).Name = accessibleState(i);
                obj.state(i).Initial = [g(accessibleState(i)).Initial]';
                obj.state(i).Marked = [g(accessibleState(i)).Marked]';
            end
            obj = obj.vector2structAutomata;
        end
    end
    
end

