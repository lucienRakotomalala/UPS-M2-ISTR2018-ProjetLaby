clear all
close all
clc
%This programm is used to fin the optimal command for a proceed modeled by an automata and giving by a
%textual text from desuma¨

%Input : Desuma files
%Output : Disp the optimal command

%% Get Transitions Matrices
[transitionsMatrix,~,States] = creationMatricetransition('senario1_52.fsm');


for k=1:length(States) 
    m(k)=int64(strcmp(States(k).Marked , '1'));
    %i(k)=int64(strcmp(States(k).Initial , '1'))
    
end

%initialState=find(i==1);
initialState=1;
markedStates=find(m==1);

for l=1:length(markedStates)
optimalCommand(transitionsMatrix, initialState, markedStates(l))
end