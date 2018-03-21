classdef AutomateGraph % Claire a choisi le titre
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        state       % Struct of all States of the automata
                    % Particuliar Type :
                    % Each state contains :   -Name 
                    %                         -Initial : 1 if it's the Only
                    %                         One Initial State, 0 if not
                    %                         -Marked  : 1 if it the state
                    %                         is marked
        transition  % Struct of all Transitions of the automata
                    % Particuliar Type :
                    % Each transition contains :  
                    %                         -Name 
                    %                         -StateIn : the state number
                    %                         of the source State
                    %                         -StateOut : the state number
                    %                         of the destination State
        matrixTrans
        langage
        vector
    end
    
    methods
        
        function obj = AutomateGraph()
            
        end
        %% Method FSM2Automata
        function obj = FSM2Automata(obj, nameFileFSM)
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
%             for i = 1:length(obj.langage)
%                 if strcmp(obj.langage, word)
%                    error('This word (char) is already in the automata"s langage') 
%                 end
%             end
            obj.langage{end+1} = {word};
            obj.langage = [obj.langage{:}];
        end
        
        %% Method adaptYourLangage
        function obj = adaptTourLangage(obj)
            obj.langage = [obj.langage{:}];
        end
        %% Method structAutomata2vectorAutomata 
        % Return the object with an update of langage, matrix and vector of
        % the automata object.
        %       Input   : Object with Transitions and States
        %       Ouput   : Object with new Matrix, Vectors and Langage
        %       according to States and Transitions
        function obj = structAutomata2vectorAutomata (obj)
            
            %% Set the langage
            obj = obj.addWord2Langage(obj.transition(1).Name);
            for i = 1:length(obj.transition)            
%                 isAlreadyAWord = 0;
%                 for j = 1:size(obj.langage, 1);
%                     isAlreadyAWord = isAlreadyAWord + strcmp(obj.transition(i).Name, obj.langage{j});
%                 end
%                 if ~isAlreadyAWord
%                     obj = obj.addWord2Langage(obj.transition(i).Name);
%                 end
                if isempty(find(ismember(obj.transition(i).Name, obj.langage)==1))
                    obj = obj.addWord2Langage(obj.transition(i).Name);
                end
            end
            % Adapt it !
            %obj = obj.adaptTourLangage();
            %% Set matrices
            for i = 1 :length(obj.langage)
                obj.matrixTrans(i).matrice = zeros(length(obj.state),length(obj.state));
                obj.matrixTrans(i).Name = obj.langage(i);
                for j = 1:length(obj.transition)
                    if strcmp(obj.matrixTrans(i).Name ,obj.transition(j).Name)
                        %if obj.transition(j).StateIn ~=
                        %obj.transition(j).StateOut % we keep stable
                        %transition
                            obj.matrixTrans(i).matrice(obj.transition(j).StateIn, obj.transition(j).StateOut) = 1;
                       % end
                    end
                end
            end
            
            % Conversing to vector
            obj = obj.matrices2vector();
        end
        %% Set Vectors
        function obj = matrices2vector(obj)
            for i = 1:length(obj.langage)
               obj.vector(i).Name  = obj.langage(i)
               % Assignement of a value for each row
               obj.vector(i).value = obj.matrixTrans(i).matrice*[1:length(obj.state)]';
            end
        end
        
        %% Recherche d'une sequence optimale et existente pour objectif
        %donné
        
        function [path, tree] = PathResearche(obj, initialState, studiedState)
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
                        s = [s s_from]
                        t = [t t_out]
                       tree = [tree c];
                    end
                end
                toc
                
            end
            
       
            G = digraph(s,t);

            path = shortestpath(G,initialState,studiedState,'Method','positive')
        end

    end
    
end

