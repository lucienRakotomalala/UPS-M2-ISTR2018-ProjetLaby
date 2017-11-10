classdef Wrapper
    %WRAPPER Global organization of the projet 
    %   Contain the connection between the differents elements and contain
    %   all the models (walls, labyrinth, ghost, pacman, escape)
    
    properties
        wallsBit    = 0;     % Boolean connection for the walls.
        pacmanBit   = 0;    % Boolean connection for the pacman.
        ghostBit    = 0;  % Boolean connection for the ghost.
        whoPlay
        
        modelLaby    % contain the instance of the model of labyrinth 
        
        in           % A integer vector who contain the state of input, 
                     % incremented by the callback or some action.
        
        out          % A cell who contain the state of output, 
                     % incremented by the callback or some action.
    end
    
    methods
        % --- Constructor of the class
        function obj = Wrapper(inSize, outSize)
            
           obj.in = zeros(1,inSize); % set size of input vector
           
           obj.modelLaby = ModelLaby(); % model of labyrinth
            % TODO model of pacman
            % TODO model of ghost
            
            % Output definition
           obj.out = cell(1,outSize); %  set size of output cell
           
           obj.out{1} = zeros(1,2); % pacman [x y]
           obj.out{2} = zeros(1,2); % ghost  [x y]
           obj.out{3} = zeros(size(obj.modelLaby.presentState.wallsV)); %  Vertical Walls
           obj.out{4} = zeros(size(obj.modelLaby.presentState.wallsH)); %  Horrizontal Walls
           obj.out{5} = 0 ;         % caught
           obj.out{6} = 0 ;         % escape
           obj.out{7} = zeros(1,4); % Walls around pacman [Up Down Left Right]
           obj.out{8} = zeros(1,4); % Walls around ghost  [Up Down Left Right]
           obj.out{9} = zeros(1,4); % Ghost sees pacman   [Up Down Left Right]
           
           
           obj.whoPlay =0;  
        end
        
        
        % --- Update the connection bit for connect automatic mode for
        % pacman, ghost and/or the walls.
        function updateConnexion(obj,indBit,value)
            switch indBit
                case 1
                        obj.wallsBit  = value;
                case 2
                        obj.pacmanBit = value;
                case 3
                        obj.ghostBit  = value;
                otherwise 
                    error('Wrong connexion index.s');
            end
        end
        
        
        % --- Ordonate the global execution.
        function obj = orderer(obj)
            nextStateLaby = obj.modelLaby.f(obj.in);
            obj.modelLaby.m(nextStateLaby,obj.in(1));
            obj.out = obj.modelLaby.g();
            % This function manage all the evolution

%{
             while(ifFinish())
               writeOutput()
                if (whoPlay == 0) 
                    handles.state.walls.f()
                    handles.state.walls.m()
                    handles.state.walls.g() 
                end
                if (whoPlay == 1) 
                    handles.state.pacman.f()
                    handles.state.pacman.m()
                    handles.state.pacman.g() 
                end
                if (whoPlay == 2) 
                    handles.state.ghost.f()
                    handles.state.ghost.m()
                    handles.state.ghost.g() 
                end

               readInput()
               % laby
               handles.laby.f()
               handles.laby.m()
               handles.laby.g()
               
               whoPlay = mod(whoPlay+1,3); % cyclical counter
%            end
%}
        end
    end
    
end

