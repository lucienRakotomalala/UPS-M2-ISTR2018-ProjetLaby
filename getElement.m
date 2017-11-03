function varargout = getElement(varargin)
% nargin min = 2 (handles, un de ceux là ( 'walls', 'pacman', 'ghost', 'visu')
% nargin max = 5 (handles, 'walls', 'pacman', 'ghost', 'visu')
if((nargin >1) && (nargin<=5))
    for a = 2: nargin
        varargout{a-1} = selector(varargin{a});
    end
    
else
    error('Wrong Size of IN')
end
    function theHandle = selector(name)
        if(strcmp(name,'walls'))
            theHandle=varargin{1}.w ;
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

