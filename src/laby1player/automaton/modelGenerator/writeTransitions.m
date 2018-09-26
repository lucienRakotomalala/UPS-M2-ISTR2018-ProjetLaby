function str = writeTransitions(prefix,datas)
% WRITETRANSITIONS Write transitions of a automaton in the DESUMA format.
% Inputs :
%    prefix : cell = {'w','s','l'} For walls, scheduling or labyrinth
%    datas :  cell  = {O,D,Tr;.,.,.;}       One line : 1 transition
%                                           O  = origin state 
%                                           D  = destination state
%                                           Tr = event name
% Output :
%    str :  String = ['...\n...\n']  Contain the DESUMA formated string to 
%                                    create transitions by reading file 
%                                    from DESUMA.
	str = '';
    tr = '';
    for i=1:size(datas,1) % while we have element
        tr = datas{i,3};
        str=sprintf('%st %s%d %s%d %s\n',str,prefix,datas{i,1},prefix,datas{i,2},tr);
    end
end