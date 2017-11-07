classdef Wrapper
    %WRAPPER Global organization of the projet 
    %   Contain the connection between the differents elements and contain
    %   all the models (walls, labyrinth, ghost, pacman, escape)
    
    properties
        wallsBit     % Boolean connection for the walls.
        pacmanBit    % Boolean connection for the pacman.
        ghostBit     % Boolean connection for the ghost.
        
        in          % A integer vector who contain the state of input, 
                    % incremented by the callback or some action.
        
        out         % A integer vector who contain the state of output, 
                    % incremented by the callback or some action.
    end
    
    methods
        function sequencing()
            whoPlay = 0;
            % This function manage all the evolution

            while(ifFinish())
               writeOutput()
                if (whoPlay == 0) 
                    murs.f()
                    murs.m()
                    murs.g() 
                end
                if (whoPlay == 1) 
                    pacman.f()
                    pacman.m()
                    pacman.g() 
                end
                if (whoPlay == 2) 
                    ghost.f()
                    ghost.m()
                    ghost.g() 
                end
               readInput()
               % laby
               laby.f()
               laby.m()
               laby.g()
               
               whoPlay = mod(whoPlay+1,3); % cyclical counter
           end

        end
    end
    
end

