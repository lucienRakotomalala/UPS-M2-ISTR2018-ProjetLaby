% lecture entrée (calback modifie une variable)     INTERFACE
% fonction d'évolution(es = f(ep,entrée)            EVOLUTION
% mémorisation ep =es   (+init)                     MEMORISATION
% sortie= g(ep,e)                                   GENERATION SORTIE


%% Les commandes 
%{
 une classe abstraite :
Attrib : 
    Xp, 
    Xs(pas sur)
Methodes : 
    Xs = f( Xp  , e)
    Xp = m( Xs  , init)
    S  = g( Wp  , e)


De la forme :

          _________
Entrées  |         |  Sorties
-------->|         |----------->
e, init  |  Comm   |     s
         |   #1    |
         |_________|

%}

%% Une classe Wrapper (classe d'ordo et de connection des élements)
%       elle contient tous les modèles (laby et sont état)
%       elle sera un attrib de l'interface
%       elle contient 3 bool :  murs connect        Attribs
%                               pacman connect
%                               ghost connect
%                     2 vecteurs :
%                               Entrées
%                               Sorties
%
%       elle ordo l'évolution générale en fct       Methode
%                   des bit de conec
%           => doit être prévue pour supportée tous les cas d'exec 
%               (tout manuel, que murs manu, que pacman manu, que ghost, 
%                tout auto, ...)
%
%   il faut que les blocs soient synchronent 
%{
murs    (   f m g murs
        (   f m g laby

obj1    (   f m g obj1
        (   f m g laby

obj2    (   f m g obj2
        (   f m g laby
while(..)
    ecrire S
    si xw = 0 f m g murs
    si wx = 1 f m g obj1
    si wx = 2 f m g obj2
    ecrire E
    f m g laby
    wx = wx+1 [3]
end

pour le steppeur :
a chaque clic il lance le bloc d'évolution 

%}


% ajout d'un bouton : stepper 
% un seul callback : un id int par bouton ou avec les tag
%       => il met a jour un         



% 10/01/18
% 1 Nettoyage fichiers
% 2 Documentation 
