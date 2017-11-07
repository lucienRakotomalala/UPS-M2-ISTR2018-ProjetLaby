classdef ModelLaby < ModelSED
    %MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        presentState;
    end
    
    methods
        function obj = ModelLaby(state)
            obj.presentState = state;
        end
        
        % --- Evolution of the labyrinth 
        function nextState = f(obj, in)
            if(in(2) == 1) % Walls Vertical
                nextState.walls = obj.presentState.walls.moveVerticalWalls();
            end
            if(in(3) == 1) % Walls Horizontal
                nextState.walls = obj.presentState.walls.moveHorizontalWalls();
            end
             if(in(4) == 1) % Pacman left
                 if(obj.canGoLeft(obj.presentState.pacman,obj.presentState.walls))
                     if(obj.presentState.pacman.isObjectNext(obj.presentState,'left'))
                             nextState.pacman = obj.presentState.pacman.goLeft();
                     end
                 end
             end
        end
        % --- Memory 
        function m(obj,nextState, init)
            obj.presentState.pacman = nextState.pacman;
            obj.presentState.walls = nextSt
        end
        % -- Generation of the output 
        function  out = g(obj, in)
            out = obj.presentState.walls;
            %out.pacman = obj.presentState.pacman;
        end
    
    
        function can = canGoLeft(obj,myObj, w)
                can=0;
                if(myObj.positionX>1)
                    if (w.verticalWalls(myObj.sizeTab-myObj.positionY+1, myObj.positionX-1)==0)
                        can=1;
                    end
                end
            end
    end
end

