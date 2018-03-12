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



MatricesTransition=zeros(size(U));

Poids = ones(size(U));
MatricesTransition(find(U==1)) = 1;
MatricesTransition(find(D==1)) = 2;
MatricesTransition(find(L==1)) = 3;
MatricesTransition(find(R==1)) = 4;
Poids(find(MatricesTransition~=0)) = 0;

MatricesTransition(find(nU==1))=5;
MatricesTransition(find(nD==1))=6;
MatricesTransition(find(nL==1))=7;
MatricesTransition(find(nR==1))=8;
MatricesTransition(find(wR==1))=9;
MatricesTransition(find(wD==1))=10;

MatricesTransition

[Buff]=ParcourirMatricesTransitions(MatricesTransition, Poids)

%%
etat_dep=cellstr('Etat départ');
liste_etats_dep=num2cell(Buff(1,:));
transitions=cellstr('Transition');
etat_arr=cellstr('Etat arrivée');
liste_etats_arr=num2cell(Buff(4,:));

%%
for k = 2:length(U)
    if(Buff(3,k) == 1)
        liste_transitions(k-1)=cellstr('Up');
    else if (Buff(3,k)== 2)
            liste_transitions(k-1)=cellstr('Down');
        else if (Buff(3,k)== 3)
                liste_transitions(k-1)=cellstr('Left');
            else if (Buff(3,k)== 4)
                    liste_transitions(k-1)=cellstr('Right');
                else if (Buff(3,k)== 5)
                        liste_transitions(k-1)=cellstr('notUp');
                    else if (Buff(3,k)== 6)
                            liste_transitions(k-1)=cellstr('notDown');
                        else if (Buff(3,k)== 7)
                                liste_transitions(k-1)=cellstr('notLeft');
                            else if (Buff(3,k) == 8)
                                    liste_transitions(k-1)=cellstr('notRight');
                                else if (Buff(3,k) == 9)
                                        liste_transitions(k-1)=cellstr('wallsTurnRight');
                                    else if (Buff(3,k) == 10)
                                            liste_transitions(k-1)=cellstr('wD');
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
out{1}=[etat_dep, liste_etats_dep(2:end); transitions, liste_transitions; etat_arr, liste_etats_arr(2:end)]
