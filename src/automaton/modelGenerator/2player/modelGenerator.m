clear 
%% Main script for launch the generation
%% 1. Initial parameters
 wallsV =   [1 0 0;
             1 0 0; 
             0 0 1;
             0 1 0;
             ]; %  dimension can change
 wallsH =  [0 0 1 0; 
            1 0 0 0;
            0 1 0 1 ;
            ]; %  dimension can change
 pacman= [1,1]; % static dimension
 ghost = [1,3];
 escape = [4 4]; % static dimension
 sched = {'P','G','w'};% p for player and w for walls

%% 2 automaton models
% structure of the pacman and ghost labs
%function [initialIndice,markedStatesIndices,transitionsDatas,numberOfStates] =...
%AutomatonStrutureLabyCreation (labySize,playerPosition,escapePosition,playerName)
% for pacman
[lab.p.indInit,lab.p.mark,lab.p.datas, lab.p.nbS]...
= AutomatonStrutureLabyCreation (max(size(wallsH)),pacman,escape,'P');
%% for ghost
[lab.g.indInit,lab.g.mark,lab.g.datas, lab.g.nbS]...
= AutomatonStrutureLabyCreation (max(size(wallsH)),ghost,escape,'G');

%% walls contraints
% function [initialIndice,markedStatesIndices,transitionsDatas, numberOfStates] ...
% = AutomatonWallsContraintsCreation (verticalsWalls,horizontalsWalls,FirstWallsMove)
[walls.indInit,walls.mark,walls.datas, walls.nbS]...
= AutomatonWallsContraintsCreation (wallsV,wallsH,'v');

%% scheduling contraints
% function [initialIndice,markedStatesIndices,transitionsDatas, numberOfStates] ...
% = AutomatonSchedulingCreation (Scheduling,PacmanLabyDatas,GhostLabyDatas,FirstWallsMove)

[sche.indInit,sche.mark,sche.datas, sche.nbS]...
= AutomatonSchedulingCreation (sched,lab.p.datas,lab.g.datas,'v');

%% 3. creation event and tr
%lab pacman
lab.p.str.s = writeStates('lP',lab.p.nbS,lab.p.indInit,lab.p.mark);
lab.p.str.t = writeTransitions('lP',lab.p.datas) ;
SaveDESUMAFile(lab.p.str.t,lab.p.str.s,'lab_pacman.txt');
%% lab ghost
lab.g.str.s = writeStates('lG',lab.g.nbS,lab.g.indInit,lab.g.mark);
lab.g.str.t = writeTransitions('lG',lab.g.datas) ;
SaveDESUMAFile(lab.g.str.t,lab.g.str.s,'lab_ghost.txt');

%% walls
walls.str.s = writeStates('w',walls.nbS,walls.indInit,walls.mark);
walls.str.t = writeTransitions('w',walls.datas) ;
SaveDESUMAFile(walls.str.t,walls.str.s,'walls.txt');

%% sched
sche.str.s = writeStates('s',sche.nbS,sche.indInit,sche.mark);
sche.str.t = writeTransitions('s',sche.datas) ;
SaveDESUMAFile(sche.str.t,sche.str.s,'sched.txt');
