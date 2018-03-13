clear all
close all
clc
% U=zeros(7,7); %cellule 1
% D=zeros(7,7); %cellule 2
% L=zeros(7,7); %cellule 3
% R=zeros(7,7); %cellule 4
% nU=zeros(7,7);%cellule 5
% nD=zeros(7,7);%cellule 6
% nL=zeros(7,7);%cellule 7
% nR=zeros(7,7);%cellule 8
% wR=zeros(7,7);%cellule 9
% wD=zeros(7,7);%cellule 10

%% Get Transition Matrices
matriceTemp = creationMatricetransition('procede.fsm');
U   = matriceTemp{1}; %cellule 1
D   = matriceTemp{2}; %cellule 2
L   = matriceTemp{3}; %cellule 3
R   = matriceTemp{4}; %cellule 4
nU  = matriceTemp{5};%cellule 5
nD  = matriceTemp{6};%cellule 6
nL  = matriceTemp{7};%cellule 7
nR  = matriceTemp{8};%cellule 8
wR  = matriceTemp{9};%cellule 9
wD  = matriceTemp{10};%cellule 10

n = length(U);  % Nbr States
M=[U D L R nU nD nL nR wR wD];
[s,t]=find(M~=0);
s
for k=1:length(t)
    if(t(k)<=4)
         w(k) = 1 ;
    else w(k) = 0;
    end
end
%w=t<=4*n
t=mod(t-1,n)+1
G = graph(s,t,w);
plot(G,'EdgeLabel',G.Edges.Weight)

disp('Etat initial : ');
e_init = input('');
disp('Etat marqué : ');
e_final = input('');
path = shortestpath(G,e_init,e_final)
