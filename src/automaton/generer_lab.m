function [ H, B, D, G ] = generer_lab(Matrice_Horizontale, Matrice_Verticale )

%Initialisation
[MV_ligne,MV_colonne] = size(Matrice_Verticale);
[MH_ligne,MH_colonne] = size(Matrice_Horizontale);

taille_x=MH_colonne;
taille_y=MV_ligne;

nb_case=taille_x*taille_y;

H=zeros(nb_case);
B=zeros(nb_case);
D=zeros(nb_case);
G=zeros(nb_case);

%Création des matrices de transitions
%%Evolution pas à pas
    for i=1:nb_case
        x=mod(i-1,taille_x)+1;
        y=floor((i-1)/taille_y)+1;
        if (y>1) % si pas 1ere ligne
            if  (Matrice_Horizontale(y-1,x)==0) % et si pas de mur
                j=i-taille_x; % on peut remonter        
                H(j,i)=1;
            end
        end
    end    
    for i=1:nb_case
        x=mod(i-1,taille_x)+1;
        y=floor((i-1)/taille_y)+1;
        if (y<taille_y) % si pas derniere ligne
            if  (Matrice_Horizontale(y,x)==0); % et si pas de mur
                j   =   i + taille_x; % on peut descendre
                B(j,i)=1;
            end
        end
    end
    
    for i=1:nb_case
        y=floor((i-1)/taille_y)+1;
        x=mod(i-1,taille_x)+1;
        if (x<taille_x) % si pas derniere colonne
            if  (Matrice_Verticale(y,x)==0); % et si pas de mur
                j   =   i + 1; % on peut aller a droite
                D(j,i)=1;
            end
        end
    end
    
    for i=1:nb_case
        y=floor((i-1)/taille_y)+1;
        x=mod(i-1,taille_x)+1;
        if (x>1) % si pas 1ere colonne
            if  (Matrice_Verticale(y,x-1)==0) % et si pas de mur
                j=i-1; % on peut aller a droite
                G(j,i)=1;
            end
        end
       
    end

end
