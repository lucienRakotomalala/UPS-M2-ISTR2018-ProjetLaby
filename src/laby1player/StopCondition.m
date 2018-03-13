classdef StopCondition  < ModelSED
    %   Detailed explanation goes here
    % Input :   walls of Pacman's 
    %           walls of ghost's
    %           escape of Pacman 
    %           CaughtBreak
    %
    % Output : 1 Escape
    %          2 Caugnt
    %          3 pacmanWallsBreak
    %          4 ghostWallsBreak
    
   properties
        presentState
        initialState
    end
    
    methods 
        function obj = StopCondition(initCondition)
            obj.initialState = initCondition;
            obj = obj.m(0,1);
        end
       
        function nextState = f(obj, noEscape,  pacmanWallsBreak)
                %nextState = zeros(1,4);
                if(noEscape==1)
                    nextState.escape=1;
                else
                    nextState.escape=0;
                end
                
%                 if(caught>obj.initialState.numberOfPossibleCaught)
%    % TODELETE                 nextState.caught=1;
%                 else
%                     nextState.caught=0;
%                 end
                
                if(sum(pacmanWallsBreak)==4)
                    nextState.pacman=1;
                else
                    nextState.pacman=0;
                end
                
%                 if(sum(ghostWallsBreak)==4)
%          % TODELETE           nextState.ghost=1;
%                 else
%                     nextState.ghost=0;
%                 end
        end
       
        function obj = m(obj, nextState, init)
            if(init==1)
                obj.presentState = obj.initialState;
            else
                obj.presentState = nextState;
            end
        end
        
        function out = g(obj)
            out=zeros(1,4);
            out(1) = obj.presentState.escape;
    % TODELETE        out(2) = obj.presentState.caught;
            out(3) = obj.presentState.pacman;
      % TODELETE      out(4) = obj.presentState.ghost;
            
        end
        
    end
    
end