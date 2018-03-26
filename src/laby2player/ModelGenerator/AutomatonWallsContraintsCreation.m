function [initialIndice,markedStatesIndices,transitionsDatas, numberOfStates] = AutomatonWallsContraintsCreation (verticalsWalls,horizontalsWalls,FirstWallsMove)
% Inputs
    % verticalsWalls        : int  = [...]      the verticals walls matrix
    % horizontalsWalls        : int  = [...]    the horizontal walls matrix
                                                 % y  = vertical position
                                                 % of the player
    % FirstWallsMove        : char  = [x]      x = 'v' : the first walls
                                                 % move is vertical
                                             % x = 'h' : the first walls
                                                 % move is horizontal
% Output
    % initialIndice : int  = [x]         x = indice of the initial state                                             
                                        % string to create states by 
    % markedStatesIndices : int = [.,.,...] indice of the marked states   
    % transitionsDatas : cell  = {O,D,Tr;.,.,.;}       One line : 1 transition
                                          % O  = origin state 
                                          % D  = destination state
                                          % Tr = event name
    % numberOfStates   : int  = [x]         x  = number of states of the
                                            % automaton    

labySize = max(size(verticalsWalls));
% number Of States
numberOfStates = labySize*2;
%initial Indice
initialIndice = strcmp(FirstWallsMove,'v')*1 + strcmp(FirstWallsMove,'h')*2;
% marked States Indices
markedStatesIndices = 0;% a faire 
Vwalls = verticalsWalls;
Hwalls = horizontalsWalls;
% 
INDICE = 0;
transitionsDatas = cell(1,3);
player = {'P','G'};
for i = 1 : numberOfStates %for all states
    [U,D,L,R] = generer_lab(Hwalls,Vwalls);
        % U : Up ; D : Down ; L:Left ; R:Right
        % U(y,x)    =1 : can move from state x to state y
        %           =0 : can't move
        % same for D, L and R
        [~,oU]=find(U);        
        [~,oD]=find(D);
        [~,oL]=find(L);
        [~,oR]=find(R);
        %% find the impossible moves
        noU=find(sum(U)==0);        
        noD=find(sum(D)==0);
        noL=find(sum(L)==0);
        noR=find(sum(R)==0);
        % 2* necessaire ??
        strSize = 2*(max(size(oU))+max(size(oD))+max(size(oL))+max(size(oR))); % One for Pacman and one for ghost.
        str = cell(1,strSize);
        l=0;        
        %up 
        if(~isempty(oU))
            l = 1;
            for  k = 1: max(size(oU))
                str{l}	= sprintf('U%s%d',player{1},oU(k));
                l = l + 1;
                str{l}	= sprintf('U%s%d',player{2},oU(k));
                l = l + 1;
            end
        end
        %down
        if(~isempty(oD))                
            %l = max(size(oU));
            for k = 1 : max(size(oD))
                str{l}	= sprintf('D%s%d',player{1},oU(k));
                l = l + 1;
                str{l}	= sprintf('D%s%d',player{2},oU(k));
                l = l + 1;
            end
        end
        %left
        if(~isempty(oL))
           % l = l+max(size(oD));
            for k = 1 : max(size(oL))
                str{l}	= sprintf('L%s%d',player{1},oU(k));
                l = l + 1;
                str{l}	= sprintf('L%s%d',player{2},oU(k));
                l = l + 1;
            end
        end
        % right
        if(~isempty(oR))
           % l = l+max(size(oL));
            for k = 1 : max(size(oR))
                str{l}	= sprintf('R%s%d',player{1},oU(k));
                l = l + 1;
                str{l}	= sprintf('R%s%d',player{2},oU(k));
                l = l + 1;
            end
        end
        %%  impossibles moves
        % not up 
        if(~isempty(noU))
            %l = l+max(size(oR));
            for k = 1 : max(size(noU))
               str{l}	= sprintf('w_U%s%d',player{1},oU(k));
                l = l + 1;
                str{l}	= sprintf('w_U%s%d',player{2},oU(k));
                l = l + 1;
                
            end
        end
        % not down
        if(~isempty(noL))  
            %l = l+max(size(noU));
            for k = 1 : max(size(noD))
                str{l}  = sprintf('w_D%s%d',player{1},oU(k));
                l = l + 1;
                str{l}  = sprintf('w_D%s%d',player{2},oU(k));
                l = l + 1;
            end
        end
        % not left
        if(~isempty(noL))
            %l = l+max(size(noD));
            for k = 1 : max(size(noL))
                str{l}	= sprintf('w_L%s%d',player{1},oU(k));
                l = l + 1;
                str{l}	= sprintf('w_L%s%d',player{2},oU(k));
                l = l + 1;
            end
        end
        % not right
        if(~isempty(noR))
            %l = l+max(size(noL));
            for k = 1 : max(size(noR))
                str{l}	= sprintf('w_R%s%d',player{1},oU(k));
                l = l + 1;
                str{l}	= sprintf('w_R%s%d',player{2},oU(k));
                l = l + 1;
            end
        end
        
        
        
        % write into output
        for h = 1:max(size(str))
            j = INDICE + h;
            transitionsDatas{j,1}=i;
            transitionsDatas{j,2}=i;
            transitionsDatas{j,3}=str{h}; % maybe x/y switch
        end
        transitionsDatas{j+1,1}=i;
        transitionsDatas{j+1,2}=mod(i,numberOfStates)+1;
        if mod(i,2)==0
            % mv down
            Vwalls = [Vwalls(end,:); Vwalls(1:end-1,:) ];
            transitionsDatas{j+1,3}='wD'; 

        else
            % mh right
            Hwalls = [Hwalls(:,end), Hwalls(:,1:end-1) ];
            transitionsDatas{j+1,3}='wR'; % maybe x/y switch

        end
        INDICE = INDICE+max(size(str))+1;
end
%% debug 
% for ee = 1:max(size(transitionsDatas))
%     for ff = 1:max(size(transitionsDatas))
%        if ee~=ff
%            if  strcmp(transitionsDatas{ee,3},transitionsDatas{ff,3})&&(transitionsDatas{ee,1}==transitionsDatas{ff,1}) && (transitionsDatas{ee,2}==transitionsDatas{ff,2}) 
%                fprintf('ee(%d)ff(%d) :%s\n',ee,ff,transitionsDatas{ee,3})
%            end
%        end
%     
%     end
% end


end