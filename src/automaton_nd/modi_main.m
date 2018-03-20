% TER=>Script d'exécution
% Johanne Bakalara, Alexandre Armengaud, Lionel Mery, David Tocaven
% Encadré par Monsieur Sylvain Durola
% Université Paul Sabatier - EEA - M1 ISTR-RODECO - TER

% R-A-Z
clear
close all;
clc
%% Matrices de murs
%Matrice_Verticale=[1 0 1 0; 1 1 0 1; 0 0 0 0;0 1 1 1; 1 0 0 0];
Matrice_Verticale=[0 1 ; 1 0; 0 0]; % Exemple 3x3
%Matrice_Verticale=[0 1 0;1 0 1;1 0 1;0 0 0]; % Exemple 4x4
%Matrice_Verticale=[1 0 0;0 0 1;0 0 0]; % Exemple 3x3
%Matrice_Verticale=[0 0;0 0 ; 1 0];



%Matrice_Horizontale=[0 0 0 1 0; 0 1 0 1 0;0 1 0 1 0;0 1 0 0 1];
Matrice_Horizontale=[1 0 0; 0 1 0]; % Exemple 3x3
%Matrice_Horizontale=[1 0 1 0;0 1 0 0;0 0 0 0]; % Exemple 4x4
%Matrice_Horizontale=[0 0 0 0;0 0 1 1]; % Exemple 3x3
%Matrice_Horizontale=[1 0 1; 0 0 0];
%% Tailles
[ taille_y ,~] = size(Matrice_Verticale); % Hauteur labyrinthe
[~,taille_x] = size(Matrice_Horizontale); % Largeur labyrinthe
nb_case=taille_x*taille_y;                % Largeur des matrices de transitions

%% Choix (lecture depuis le terminal) des états initiaux, finaux et ceux dont on veut étudier l'accéssibilité et la coaccessibilité
Etats_Initiaux=input(['Entrer l'' ensemble d''états initiaux compris entre 1 et ' blanks(1) num2str(nb_case) blanks(1) '  :  ']);
%Etats_Finaux=input(['Entrer l'' ensemble d''états finaux compris entre 1 et ' blanks(1) num2str(nb_case) blanks(1) '  :  ']);
% supprime Etat=input(['Entrer l'' ensemble d''états finaux compris entre 1 et ' blanks(1) num2str(nb_case) blanks(1) ' dont vous voulez tester l accessibilite et la coaccessibilite :  ']);
Etats_Finaux=nb_case;
%% Création d'un objet de type labyrinthe
lab = Labyrinthe(Matrice_Verticale,Matrice_Horizontale,Etats_Initiaux,Etats_Finaux);
[ H, B, G, D ] = lab.Pas_a_pas();
lab.affichage();
%% Initialisation de l'analyse
AccessibleIncertain{1,1}=[];
CoaccessibleIncertain{1,1}=[];
Accessible=0;

Coaccessible=0;
Bloquant=0;
Nonbloquant=0;
BloquantIncertain=0;
SequenceAc{1,1}=[];
SequenceCo{1,1}=[];

%% Création de l'automate
A = Automaton({H,B,G,D},{'H','B','G','D'});


%% Test d'accessibilité
%boucle pour chaque etat etudier
%AllPaths=cell(nb_case,1);
%for Etat= 1:nb_case
Etat=5;
[Accessible, Tree, SequenceAc]=A.AutomateAccessible(Etats_Initiaux,Etat); % paramètres :(obj,Etat_final)
%AllPaths{Etat}=Tree;
%end
