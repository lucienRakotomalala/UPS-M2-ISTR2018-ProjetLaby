%> @file ModelSED.m
%> @briel abstract Class who contain the structure of a "fmg" implementation
%> Input :  necessary information for compute the next state of the model
%>
%> Output : output's action of the model
%           
%> State :   minimal information necessary who evolute 
% ======================================================================
classdef (Abstract) ModelSED < handle 
    %MODELSED is abstract Class who contain the structure of a "fmg" implementation
	% Input :  necessary information for compute the next state of the model
	%
	% Output : output's action of the model
	%           
	% State :   minimal information necessary who evolute
    
    properties (Abstract)
%> This is the state of the command in the present moment    
        presentState
%> This is the state of the command in the initialization and when it's reseted
        initialState
    end
    
    methods (Abstract)
% ======================================================================        
%> @brief Compute the evolution of the model
%> @param obj The instance who evolute
%> @param in Input needed for the computing
%> @retval nextState The future state of the model
% ======================================================================    
         nextState   = f(obj, in)
% ======================================================================
%> @brief Memory method
%> update the state of the command.
%> @param obj The selected instance of the class
%> @param nextState The value of the state need to update 
%> @param init Boolean condition for initialize or reset the command
%> @return instance of the class updated 
% ======================================================================         
                       m(obj, nextState, init)
% ======================================================================        
%> @brief Create the outputs
%> @param obj the concerned instance of the class
%> @retval out Constructed output of the model
% ======================================================================                       
        out          = g(obj)
    end
    
end



