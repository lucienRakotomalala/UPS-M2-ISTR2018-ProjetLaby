function varargout = getElement(varargin)
% nargin min = 2 (handles, un de ceux là ( 'murs', 'pacman', 'ghost', 'visu')
% nargin max = 5 (handles, 'murs', 'pacman', 'ghost', 'visu')
if((nargin >1) && (nargin<=5))
    for a = 2: nargin
        varargout{a-1} = selector(varargin{a});
    end
    
else
    error('Wrong Size of IN')
end
    function theHandle = selector(name)
        if(strcmp(name,'murs'))
            theHandle=varargin{1}.m ;
        else
            if(strcmp(name,'pacman'))
                theHandle=varargin{1}.pacman ;
            else
                if(strcmp(name,'ghost'))
                    theHandle=varargin{1}.ghost;
                else
                    if(strcmp(name,'visu'))
                        theHandle=varargin{1}.visu;
                    else
                        error('Wrong Name !')
                    end
                end
            end
        end
        
    end
end

