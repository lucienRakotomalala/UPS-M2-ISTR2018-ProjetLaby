clear 
%% Main script for launch the generation
%% 1. Initial parameters
 wallsV = [1 0 1 0; 1 1 0 1; 0 0 0 0;0 1 1 1; 1 0 0 0]; %  dimension can change
 wallsH = [0 0 0 1 0; 0 1 0 0 0;0 1 0 1 0;0 1 0 0 1];%[0 0 1 0; 0 0 0 1; 1 1 0 0];%  dimension can change
%Let the init position in 1 beacause we found a huge bug if it something
%else...
 pacman= [1,1]; % static dimension
 escape = [5 5]; % static dimension
 sched = {'p','w'};% p for player and w for walls

%% 2 automaton models
% structure of the lab
[lab.indInit,lab.mark,lab.datas, lab.nbS]...
= AutomatonStrutureLabyCreation (max(size(wallsH)),pacman,escape);

% walls contraints
[walls.indInit,walls.mark,walls.datas, walls.nbS]...
= AutomatonWallsContraintsCreation (wallsV,wallsH,'v');

% scheduling contraints
[sche.indInit,sche.mark,sche.datas, sche.nbS]...
= AutomatonSchedulingCreation (sched,lab.datas,'v');

%% 3. creation event and tr
%lab
lab.str.s = writeStates('l',lab.nbS,lab.indInit,lab.mark);
lab.str.t = writeTransitions('l',lab.datas) ;
SaveDESUMAFile(lab.str.t,lab.str.s,'lab.txt');

%walls
walls.str.s = writeStates('w',walls.nbS,walls.indInit,walls.mark);
walls.str.t = writeTransitions('w',walls.datas) ;
SaveDESUMAFile(walls.str.t,walls.str.s,'walls.txt');

%sched
sche.str.s = writeStates('s',sche.nbS,sche.indInit,sche.mark);
sche.str.t = writeTransitions('s',sche.datas) ;
SaveDESUMAFile(sche.str.t,sche.str.s,'sched.txt');
