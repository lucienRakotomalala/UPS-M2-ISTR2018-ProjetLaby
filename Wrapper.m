classdef Wrapper
    %WRAPPER Global organization of the projet 
    %   Contain the connection between the differents elements and contain
    %   all the models (walls, labyrinth, ghost, pacman, escape)
    
    properties
        wallsBit        % Boolean connection for the walls.
        pacmanBit      % Boolean connection for the pacman.
        ghostBit     % Boolean connection for the ghost.
        
        modelLaby     % contain the instance of the model of labyrinth 
        commandWalls
        commandGhost
        commandPacman
        
        in           % A integer vector who contain the state of input, 
                    % incremented by the callback or some action.
        
        out         % A cell who contain the state of output, 
                    % incremented by the callback or some action.
        whoPlay
    end
    
    methods
        % --- Constructor of the class
        function obj = Wrapper(inSize, outSize)
            %% OBjects (modelLaby, pacman, walls, ghost) 
           obj.modelLaby      = ModelLaby(); % model of labyrinth
           obj.commandWalls   = ModelWalls();
           obj.commandPacman  = ModelPacman();
           obj.commandGhost   = ModelGhost();
            obj.whoPlay = 0;
            
            %% Inputs
           obj.in = zeros(1,inSize); % set size of input vector
           
           
            %% Output definition
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
           
           
           
           
            
           
           %% Connections
           obj.wallsBit = 0;
           obj.pacmanBit = 0;
           obj.ghostBit = 0;
        end
        
        
        % --- Update the connection bit for connect automatic mode for
        % pacman, ghost and/or the walls.
        function obj = updateConnexion(obj,indBit,value)
            switch indBit
                case 1
                        obj.wallsBit  = value;
                case 2
                        obj.pacmanBit = value;
                case 3
                        obj.ghostBit  = value ;  
                otherwise 
                    error('Wrong connexion index.s');
            end
        end
        
        
        % --- Ordonate the global execution.
        function obj = orderer(obj)
        % This function manage all the evolution    
            %% PROBLEME ORDO A GERER : doit W > LAB > PAC > LAB > GHOS > LAB ...
            if(obj.wallsBit && obj.pacmanBit && obj.ghostBit) %% mod to || si gestion de commande partielle
                switch obj.whoPlay
                    case 0 
                        % f m g walls
                        nextStateWalls = obj.commandWalls.f(); 
                        obj.commandWalls.m(nextStateWalls,obj.in(1)); 
                        obj.in(2:3) = obj.commandWalls.g(); 
                    case 1
                        % f m g pacman
                        nextStatePacman = obj.commandPacman.f(obj.out{7});
                        obj.commandPacman.m(nextStatePacman,obj.in(1));
                        obj.in(4:7) = obj.commandPacman.g(); 
                
                    case 2
                        nextStateGhost = obj.commandGhost.f(obj.out{8},obj.out{9});
                        obj.commandGhost.m(nextStateGhost,obj.in(1));
                        obj.in(7:10) = obj.commandGhost.g(); 
                end
                obj.whoPlay = mod(obj.whoPlay+1,3); % 2 doit être = 3
            end
            
            % f m g modelLAby 
            nextStateLaby = obj.modelLaby.f(obj.in);
            obj.modelLaby.m(nextStateLaby,obj.in(1));
            obj.out = obj.modelLaby.g();
            obj.in
            obj.in = zeros(size(obj.in));
            % ordre exec 
            
            % murs :
            %   -in  : type de
            %   -out :
            %   -etat : 
            
            % murs > Laby > pacman > Laby > ghost > laby 
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            

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

