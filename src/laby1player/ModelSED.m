classdef (Abstract) ModelSED < handle %peut-être héritage de handle pour set/get
    %MODELSED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Abstract)
        presentState
        initialState
    end
    
    methods (Abstract)
         nextState   = f(obj, in)
                       m(obj, nextState, init)
        out          = g(obj, in)
    end
    
end

