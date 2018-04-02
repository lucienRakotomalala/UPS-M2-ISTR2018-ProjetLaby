%> @file Wrapper.m 

%> @brief Connects all models to the display function. 

%>   Contain the connection between the different elements and contain
%>   all the models (walls, labyrinth, Pacman, escape)
classdef Wrapper
    %WRAPPER Connects all models to the display function.
    %   Contain the connection between the different elements and contain
    %   all the models (walls, labyrinth, Pacman, escape)
    
    properties
		%> Boolean connection for the walls.
        wallsBit       
		%> Boolean connection for the Pacman.
        pacmanBit      
        
		%> contain the instance of the model of labyrinth.
        modelLaby 
		%> contain the instance of wall's command. 
        commandWalls
        %> contain the instance of Pacman's command. 
		commandPacman
        %> contain the instance shutdown condition. 
		stopCondition
        
		%> A integer vector who contain the state of input, 
        %> incremented by the callback or some action.
        in           
        
		%> A cell who contain the state of output, 
        %> incremented by the callback or some action.
        out

		%> A cell that contains the output of the stop conditions instance.
        %> incremented by the callback or some action.
        stop
		%> A increment integer that permit to know which object to play 
		%> 0 = walls ; 1 = Pacman.
        whoPlay     
    end
    
    methods
% ======================================================================   
%> @brief Class constructor of Instance of StopCondition Class.
%> @param inSize Integer containing the size of the state of inputs.
%> @param outSize Integer containing the size of the state of Outputs.
%> @param initLaby Structure containing every fields need to initialize the labyrinth Model.
%> @param initWalls Structure containing every fields need to initialize the Walls Model.
%> @param initPac Structure containing every fields need to initialize the Pacman Model.
%> @param initStop Structure containing every fields need to initialize the Stop Model.
%> @return instance of the Wrapper class.
% ======================================================================
        function obj = Wrapper(inSize, outSize, initLaby, initWalls, initPac, initStop)
			% --- Constructor of the class
            OBjects (modelLaby, pacman, walls, ghost, stop) 
			obj.modelLaby      = ModelLaby(initLaby.wallsV_i,initLaby.wallsH_i,initLaby.pacman_i,initLaby.escape_i); % model of labyrinth
            obj.commandWalls   = ModelWalls(initWalls.wallsCommand_i);
            obj.commandPacman  = ModelPacman(initPac.pacmanCommand_i);
            obj.stopCondition  = StopCondition(initStop);
            obj.whoPlay = 0;
            
            %% Inputs
            obj.in = zeros(1,inSize); % set size of input vector
           
           
            %% Output definition
           obj.out = cell(1,outSize); %  set size of output cell

%            obj.out{1} = zeros(1,2); % pacman [x y]
%            obj.out{2} = zeros(1,2); % ghost  [x y]
%            obj.out{3} = zeros(size(obj.modelLaby.presentState.wallsV)); %  Vertical Walls
%            obj.out{4} = zeros(size(obj.modelLaby.presentState.wallsH)); %  Horizontal Walls
%            obj.out{5} = 0 ;         % caught
%            obj.out{6} = 0 ;         % escape
%            obj.out{7} = zeros(1,4); % Walls around pacman [Up Down Left Right]
%            obj.out{8} = zeros(1,4); % Walls around ghost  [Up Down Left Right]
%            obj.out{9} = zeros(1,4); % Ghost sees pacman   [Up Down Left Right]
           obj.out=obj.modelLaby.g();
           obj.stop= obj.stopCondition.g();
           
           
            
           
           %% Connections
           obj.wallsBit = 0;
           obj.pacmanBit = 0;
        end
        
		
% ======================================================================   
%> @brief  Update the connection bit for connect automatic mode for Pacman and/or the walls.
%> @param obj The instance of Wrapper.
%> @param indBit Integer pointing the element to be connected : '1' for walls and '3' for Pacman.
%> @param value Boolean indicating if the element is connected (True) or not.    
%> @return instance of the Wrapper class.
% ====================================================================== 
        function obj = updateConnexion(obj,indBit,value)
		%% Update the connection bit for connect automatic mode for Pacman and/or the walls.
            switch indBit
                case 1
                        obj.wallsBit  = value;
                case 3
                      obj.pacmanBit = value;
                otherwise 
                    error('Wrong connexion index.s');
            end
        end
        
% ======================================================================   
%> @brief Allows to completely reset the labyrinth.
%> @param obj The instance of Wrapper.  
%> @return instance of the Wrapper class.
% ====================================================================== 
        function obj = init(obj)
            %--- init the project
			%fprintf('Reset wrapper\n')
            % reset laby, commands and stop
            obj.modelLaby.m(0,1);
           
            obj.commandPacman.m(0,1);
            obj.commandWalls.m(0,1);
           
            obj.stopCondition.m(0,1);
           
            % reset out and stop
            obj.out = obj.modelLaby.g();
            obj.stop = obj.stopCondition.g();
            obj.whoPlay = 0;
            
           % reset bits
            obj.pacmanBit = 0;
            obj.wallsBit  = 0;
           
        end
        
% ======================================================================   
%> @brief Ordinate the global execution of Models. 
%> @param obj The instance of Wrapper.  
%> @return instance of the Wrapper class.

%> In a first case, it checks which models is connected via the interface. 
%> If a model is connected, we execute the 'fmg' structure of the model, 
%> else, we are waiting that a player push the desired button to move the labyrinth.\n
%>\n 
%> Here a little graphic about the scheduling of the call of each model :  walls > Laby > pacman > laby \n 
%> Every call of 'laby' implies a call of Stop Condition.
% ====================================================================== 
        function obj = orderer(obj, vectIn)
			% Ordinate the global execution.
            % This function manage all the evolution    
            % input reading
            obj.in=vectIn;
            % init case
            if(obj.in(1)==1)
                obj=obj.init();
            %end
            %if
            elseif(sum(obj.stop)==0) % if not stopped
                % PROBLEME ORDO A GERER : doit W > LAB > PAC >  LAB > ...
                if(obj.wallsBit || obj.pacmanBit ) %% mod to || si gestion de commande partielle
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
                    end
                end


                % f m g modelLAby 
                nextStateLaby = obj.modelLaby.f(obj.in);
                obj.modelLaby.m(nextStateLaby,obj.in(1));
                obj.out = obj.modelLaby.g();

                %  f m g stop
                 % noEscape, caught, pacmanWallsBreak, ghostWallsBreak
                nextStateStop=obj.stopCondition.f(obj.out{6} , obj.out{7});
                obj.stopCondition.m(nextStateStop, obj.in(1));
                obj.stop = obj.stopCondition.g();

                % increment whoplay
                if(obj.in(1)==0)
                 obj.whoPlay = mod(obj.whoPlay + 1, 2); 
                else
                    obj.whoPlay=0;
                end
                    %disp('whoPlay ++ !')% DEBUG


                %obj.in % DEBUG
                %fprintf('W P G : [%d %d %d]\n',obj.wallsBit,obj.pacmanBit, obj.ghostBit);% DEBUG
                obj.in = zeros(size(obj.in));
                % ordre exec 


                % murs :
                %   -in  : type de
                %   -out :
                %   -etat : 
            end    
            % murs > Laby > pacman > laby 
        end
% ======================================================================   
%> @brief Return the current State of shutdown condition. 
%> @param obj The instance of Wrapper.  
%> @return instance of the Stop class.
% ======================================================================
        function stp= get_stop(obj)
            stp = obj.stop;
        end
		
% ======================================================================   
%> @brief Return the current State of output cell.
%> @param obj The instance of Wrapper.  
%> @return Output cell.
% ======================================================================
        function output= get_out(obj)
            output = obj.out;
        end
    end
    
end

