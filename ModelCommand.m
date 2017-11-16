classdef ModelCommand
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        sizeTab = 5;
        knowCompart=zeros(sizeTab); %Known compartments
        presentState;
        Down;
        Left;
        Up;
        Right;
    end
    
    methods
        %commande pacman avec memorisation 
        function f(obj, presentState) 
            
            if knowCompart(obj.presentState.PositionY-1, obj.presentState.PositionX)==0
                Down=1;
            elseif knowCompart(obj.presentState.PositionY, obj.presentState.PositionX-1)==0
                Right=1;
            elseif knowCompart(obj.presentState.PositionY+1, obj.presentState.PositionX)==0
                Up=1;
            elseif knowCompart(obj.presentState.PositionY, obj.presentState.PositionX+1)==0
                Left=1;
            elseif knowCompart(obj.presentState.PositionY-1, obj.presentState.PositionX)==1
                Down=1;
            elseif knowCompart(obj.presentState.PositionY, obj.presentState.PositionX-1)==1
                Right=1;
            elseif knowCompart(obj.presentState.PositionY+1, obj.presentState.PositionX)==1
                Up=1;
            elseif knowCompart(obj.presentState.PositionY, obj.presentState.PositionX+1)==1
                Left=1;                     
            end
        end       
        
        function m(obj, presentState, init)
            if(init == 1)
                knowCompart(obj.presentState.PositionY, obj.presentState.PositionX)=1;
            end
        end
        
        function out = g(obj)
            out = [Down; Left; Up; Right];   
        end
            
    end
end

