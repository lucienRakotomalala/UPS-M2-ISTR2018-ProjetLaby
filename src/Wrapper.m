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
        whoPlay     % 0 = walls ; 1 = pacman ; 2 = ghost
    end
    
    methods
        % --- Constructor of the class
        function obj = Wrapper(inSize, outSize)
            %% Initial laby state
            wallsV_i =  [1 0 1 1 ; 1 0 1 1; 1 0 0 0; 1 0 0 1; 1 0 1 0];
            wallsH_i =  [1 0 1 1 1; 1 0 1 0 0; 1 0 1 0 0; 1 0 0 1 1]; 
            pacman_i = [3 3];
            ghost_i  = [2 2];
            escape_i = {[4 4], 0};
            caught_i = 0;
            
            %% initial value of walls command
            wallsCommand_i = 0; 
            % =0 : begin with right move 
            % =1 : begin with up move 
            
            %% initial value of pacman command
            pacmanCommand_i= zeros(1,4);
            
            %% initial value of pacman command
            ghostCommand_i= zeros(1,4);
            %%
            %% OBjects (modelLaby, pacman, walls, ghost) 
           obj.modelLaby      = ModelLaby(wallsV_i,wallsH_i,pacman_i,ghost_i,escape_i,caught_i); % model of labyrinth
           obj.commandWalls   = ModelWalls(wallsCommand_i);
           obj.commandPacman  = ModelPacman(pacmanCommand_i);
           obj.commandGhost   = ModelGhost(ghostCommand_i);
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
                      obj.ghostBit  = value ;  
                case 3
                      obj.pacmanBit = value;
                otherwise 
                    error('Wrong connexion index.s');
            end
        end
        
        
        % --- Ordonate the global execution.
        function obj = orderer(obj)
        % This function manage all the evolution    
            %% PROBLEME ORDO A GERER : doit W > LAB > PAC > LAB > GHOS > LAB > ...
            if(obj.wallsBit || obj.pacmanBit || obj.ghostBit) %% mod to || si gestion de commande partielle
                switch obj.whoPlay
                    case 0 % walls
                        if(obj.wallsBit==1)
                            % f m g walls
                            nextStateWalls = obj.commandWalls.f(); 
                            obj.commandWalls.m(nextStateWalls,obj.in(1)); 
                            obj.in(2:3) = obj.commandWalls.g();
                        end
                    case 1 % pacman
                        if(obj.pacmanBit==1)
                            % f m g pacman
                            nextStatePacman = obj.commandPacman.f(obj.out{7});
                            obj.commandPacman.m(nextStatePacman,obj.in(1));
                            obj.in(4:7) = obj.commandPacman.g(); 
                        end 
                    case 2 % ghost
                        if(obj.ghostBit==1) %% if ghost is connect
                            % f m g ghost
                            nextStateGhost = obj.commandGhost.f(obj.out{8},obj.out{9},obj.out{3},obj.out{4},obj.out{2});
                            obj.commandGhost.m(nextStateGhost,obj.in(1));
                            obj.in(8:11) = obj.commandGhost.g(); 
                        end
                end
            end
            
            
            % f m g modelLAby 
            nextStateLaby = obj.modelLaby.f(obj.in);
            obj.modelLaby.m(nextStateLaby,obj.in(1));
            obj.out = obj.modelLaby.g();
            if obj.in(1) == 1  % if is a init clic 
                obj.whoPlay = 0;
                %disp('init clic !')% DEBUG
            else % else increment whoPlay
                obj.whoPlay = mod(obj.whoPlay + 1, 3); % 2 doit être = 3
                %disp('whoPlay ++ !')% DEBUG

            end
            %obj.in % DEBUG
            %fprintf('W P G : [%d %d %d]\n',obj.wallsBit,obj.pacmanBit, obj.ghostBit);% DEBUG
            obj.in = zeros(size(obj.in));
            % ordre exec 
            
            
            % murs :
            %   -in  : type de
            %   -out :
            %   -etat : 
            
            % murs > Laby > pacman > Laby > ghost > laby 
        end
    end
    
end

