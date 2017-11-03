function varargout = getElement(varargin)
            % nargin min = 2 (handles, un de ceux là ( 'murs', 'pacman', 'ghost', 'visu')
            % nargin max = 5 (handles, 'murs', 'pacman', 'ghost', 'visu')
            switch (nargin)
                case 2 
                    varargout{1} = selector(varargin{2});
                case 3
                    varargout{1} = selector(varargin{2});
                    varargout{2} = selector(varargin{3});
                case 4
                    varargout{1} = selector(varargin{2});
                    varargout{2} = selector(varargin{3});
                    varargout{3} = selector(varargin{4});
                case 5
                    varargout{1} = selector(varargin{2});
                    varargout{2} = selector(varargin{3});
                    varargout{3} = selector(varargin{4});    
                    varargout{4} = selector(varargin{5});

                otherwise 
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
    
