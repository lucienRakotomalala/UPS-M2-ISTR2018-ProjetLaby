classdef ModelLaby < ModelSED
    %MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        presentState;
    end
    
    methods

        
        % --- Evolution of the labyrinth 
        function nextState = f(obj, in)
            nextState = obj.presentState;
            if(in(1) == 1) % Initial
                
            end
            if(in(2) == 1) % Walls Vertical
                nextState.walls = obj.presentState.walls.moveVerticalWalls();                
            end
            if(in(3) == 1) % Walls Horizontal
                nextState.walls = obj.presentState.walls.moveHorizontalWalls();
            end
            if(in(4) == 1) % Pacman get left
                 if(obj.canGoLeft(obj.presentState.pacman, obj.presentState.walls))
                     if(obj.presentState.pacman.isObjectNext(obj.presentState,'left'))
                        nextState.pacman = obj.presentState.pacman.goLeft();
                     end
                 end
            end
             if(in(5) == 1) % Pacman get Up
                 if(obj.canGoUp(obj.presentState.pacman,obj.presentState.walls))
                     if(obj.presentState.pacman.isObjectNext(obj.presentState,'up'))
                        nextState.pacman = obj.presentState.pacman.goUp();
                     end
                 end
             end
             if(in(6) == 1) % Pacman get right
                 if(obj.canGoRight(obj.presentState.pacman,obj.presentState.walls))
                     if(obj.presentState.pacman.isObjectNext(obj.presentState,'right'))
                        nextState.pacman = obj.presentState.pacman.goRight();
                     end
                 end
             end
             if(in(7) == 1) % Pacman get Down
                 if(obj.canGoDown(obj.presentState.pacman,obj.presentState.walls))
                     if(obj.presentState.pacman.isObjectNext(obj.presentState,'down'))
                        nextState.pacman = obj.presentState.pacman.goDown();
                     end
                 end
             end
             
             if(in(8) == 1) %Ghost get Left
                 if(obj.CanGoDown(obj.presentState.ghost,obj.presentState.walls))
                     if(obj.presentState.ghost.isObjectNext(obj.presentState, 'left'))
                         nextState.pacman = obj.presentState.ghost.goDown();
                     end
                 end
             end
             
             if(in(9) == 1) % Ghost get Up
                 if(obj.canGoUp(obj.presentState.ghost,obj.presentState.walls))
                     if(obj.presentState.ghost.isObjectNext(obj.presentState,'up'))
                         nextState.ghost = obj.presentState.ghost.goUp();
                     end
                 end
             end
             
             if(in(10) == 1) % Ghost get Right
                 if(obj.canGoRight(obj.presentState.ghost,obj.presentState.walls))
                     if(obj.presentState.ghost.isObjectNext(obj.presentState,'right'))
                         nextState.ghost = obj.presentState.ghost.goRight();
                     end
                 end
             end
             
             if(in(11) == 1) % Ghost get Down
                 if(obj.canGoDown(obj.presentState.ghost,obj.presentState.walls))
                     if(obj.presentState.ghost.isObjectNext(obj.presentState,'down'))
                         nextState.ghost = obj.presentState.ghost.goDown();
                     end
                 end
             end
             %Default case
             if(in(:) == 0)
                 'Error'
                 nextState = obj.presentState;
             end
        end
        %% --- Memory 
        function m(obj,nextState, init)
            
            if(init == 1)
                obj.presentState.wallsV =  [1 0 0 0; 0 0 1 0; 1 0 0 0; 1 0 1 0; 0 0 1 0];
                obj.presentState.wallsH =  [1 0 1 0 1; 1 0 1 0 1; 1 0 1 0 1; 0 1 0 1 0]; 
                obj.presentState.pacman = [1 1];
                obj.presentState.ghost  = [5 5];
            else
                obj.presentState = nextState;
            end
        end
        %% -- Generation of the output 
        function  out = g(obj)
            out.walls = obj.presentState.walls;
            out.pacman = obj.presentState.pacman;
            out.ghost = obj.presentState.ghost;
        end
    
        %%
        function can = canGoLeft(obj, myObj, w)
                can=0;
                if(myObj.positionX>1)
                    if (w.verticalWalls(myObj.sizeTab-myObj.positionY+1, myObj.positionX-1)==0)
                        can=1;
                    end
                end
        end
                    %Autoriser deplacement Haut
        function can = canGoUp(obj, myObj, w)
            can=0;
            if(myObj.positionY<myObj.sizeTab)
                if (w.horizontalWalls(myObj.sizeTab-myObj.positionY, myObj.positionX)==0)
                    can=1;
                end
            end
        end
                %Autoriser deplacement Bas
        function can = canGoDown(obj, myObj, w)
            can=0;
            if(myObj.positionY>1)

                if (w.horizontalWalls(myObj.sizeTab-myObj.positionY+1, myObj.positionX)==0)
                    can=1;
                end
            end
        end
        
                %Autoriser deplacement Droite
        function can = canGoRight(obj, myObj, w)
            can=0;
            if(myObj.positionX<5)
                if (w.verticalWalls(myObj.sizeTab-myObj.positionY+1, myObj.positionX)==0)
                    can=1;
                end
            end
        end
    
  
    end
end

