clear all
close all
clc
%This programm is used to fin the optimal command for a proceed modeled by an automata and giving by a
%textual text from desuma¨

%Input : Desuma files and a list of transitions
%            DesumaFile have to be in a fsm (Export UMDES File) or in txt
%            format
%            transitionList is a cell wich contains all string of
%            transition. I use for 
%Output : Disp the optimal command

%% Get Transitions Matrices

transitionList = {'U', 'D' 'L','R','nU','nD','nL','nR','wR','wD','escp'};
[transitionsMatrix,~,States] = creationMatricetransition('senario1_5_bloq.fsm',transitionList );



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