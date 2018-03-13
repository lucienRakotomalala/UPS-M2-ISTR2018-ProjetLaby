classdef AutomateGraph % Claire a choisi le titre
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        state
        transition
        matrixTrans
        Langage
    end
    
    methods
        function obj = AutomateGraph()
            
        end
        
        function obj = setState(st)
           obj.state =  st;
        end
    end
    
end

