classdef AutomateGraph % Claire a choisi le titre
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        state       % Struct of all States of the automata
                    % Particuliar Type :
                    % Each state contains :   -Name 
                    %                         -Initial : 1 if it's the Only
                    %                         One Initial State, 0 if not
                    %                         -Marked  : 1 if it the state
                    %                         is marked
        transition  % 
        matrixTrans
        Langage
        vectors
    end
    
    methods
        function obj = AutomateGraph()
            
        end
        

    end
    
end

