%% Structural main of Automata Laby
clear all
%%   Generation of a laby scenario 1
%
addpath('modelGenerator')
modelGenerator
% Creation of a struct of the process of Laby
ProcessAutomata = struct('lab',AutomateGraph,   ...
                         'walls',AutomateGraph, ...
                         'sche',AutomateGraph);     % J'en ai oubli� 1 !!!
%% Take Information
% 1 lab
    % get transitons information
    for i = 1:length(lab.datas)
        ProcessAutomata.lab.transition(i).Name = lab.datas{i,3};
        ProcessAutomata.lab.transition(i).StateIn = lab.datas{i,1};
        ProcessAutomata.lab.transition(i).StateOut = lab.datas{i,2};
    end
        % get states information
    for i = 1:lab.nbS
        ProcessAutomata.lab.state(i).Name = i;
        ProcessAutomata.lab.state(i).Initial = (i== lab.indInit);
        ProcessAutomata.lab.state(i).Marked = (i==lab.mark);
    end
 % 2 sche   
        % get transitons information
    for i = 1:length(sche.datas)
        ProcessAutomata.sche.transition(i).Name = sche.datas{i,3};
        ProcessAutomata.sche.transition(i).StateIn = sche.datas{i,1};
        ProcessAutomata.sche.transition(i).StateOut = sche.datas{i,2};
    end
        % get states information
    for i = 1:sche.nbS
        ProcessAutomata.sche.state(i).Name = i;
        ProcessAutomata.sche.state(i).Initial = (i== sche.indInit);
        ProcessAutomata.sche.state(i).Marked = 1;%(i==sche.mark);
    end
    
% 3 walls
    for i = 1:length(walls.datas)
        ProcessAutomata.walls.transition(i).Name = walls.datas{i,3};
        ProcessAutomata.walls.transition(i).StateIn = walls.datas{i,1};
        ProcessAutomata.walls.transition(i).StateOut = walls.datas{i,2};
    end
        % get states information
    for i = 1:walls.nbS
        ProcessAutomata.walls.state(i).Name = i;
        ProcessAutomata.walls.state(i).Initial = (i== walls.indInit);
        ProcessAutomata.walls.state(i).Marked = 1;%(i==walls.mark);
    end
% 4 escape
    
%% Transpose to vector Automata
    ProcessAutomata.walls = ProcessAutomata.walls.structAutomata2vectorAutomata;
    ProcessAutomata.sche = ProcessAutomata.sche.structAutomata2vectorAutomata;
    ProcessAutomata.lab = ProcessAutomata.lab.structAutomata2vectorAutomata;
    
    
%% Product Parrallel
    ProcessAutomata.composed = ParrallelComposition(ProcessAutomata.walls, ProcessAutomata.sche);
    ProcessAutomata.composed = ParrallelComposition(ProcessAutomata.lab, ProcessAutomata.composed);
    
    
%% Clean up of process composed
    addpath('data')
    ProcessAutomata.composed = rafineAutomatonClass(ProcessAutomata.composed, ...
{'nU', 'nD', 'nR', 'nL', 'wD', 'wR', 'U', 'D', 'R', 'L'});