% TER=>Classe Labyrinthe
% Johanne Bakalara, Alexandre Armengaud, Lionel Mery, David Tocaven
% Encadré par Monsieur Sylvain Durola
% Université Paul Sabatier - EEA - M1 ISTR-RODECO - TER
classdef Labyrinthe
    %LABYRINTHE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        MursVerticaux       % matrices binaire des murs verticaux
        MursHorizontaux     % matrices binaire des murs Horisontaux
        Etats_Initiaux      % vecteur d'entiers contenant le ou les états initiaux
        Etats_Finaux        % vecteur d'entiers contenant le ou les états finaux
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%% constructeur %%%%%%%%%%%%%%%%%%
        function obj = Labyrinthe(murs_Verticaux, murs_Horizontaux, etats_Initiaux, etats_Finaux)
            obj.MursVerticaux    = murs_Verticaux ;
            obj.MursHorizontaux  = murs_Horizontaux ;
            obj.Etats_Initiaux   = etats_Initiaux ;
            obj.Etats_Finaux     = etats_Finaux ;
        end
        
        %%%%%%%%%%%%%% génération d'évolution pas à pas %%%%%%%%%%%%%%%%%%
        function [H, B, G, D] = Pas_a_pas(obj)
            [MV_lig,MV_col] = size(obj.MursVerticaux);
            [MH_lig,MH_col] = size(obj.MursHorizontaux);
            nb_case=MH_col*MV_lig;
            H=zeros(nb_case);
            B=zeros(nb_case);
            D=zeros(nb_case);
            G=zeros(nb_case);
            
            %%Evolution pas à pas
            % Haut
            for i=1:nb_case
                x=mod(i-1,MH_col)+1;
                y=floor((i-1)/MH_col)+1;
                
                j=i; % on bouge pas
                % pause
                if (y>1) % si pas 1ere ligne
                    if  (obj.MursHorizontaux(y-1,x)==0) % et si pas de mur
                        j=i-MH_col; % on peut remonter
                    end
                end
                H(j,i)=1;
            end
            % Bas
            for i=1:nb_case
                x=mod(i-1,MH_col)+1;
                y=floor((i-1)/MH_col)+1;
                j=i;% on bouge pas
                if (y < MV_lig) % si pas derniere ligne
                    if  (obj.MursHorizontaux(y,x)==0); % et si pas de mur
                        j   =   i + MH_col; % on peut descendre
                    end
                end
                B(j,i)=1;
            end
            
            % Droite
            for i=1:nb_case
                x=mod(i-1,MH_col)+1;
                y=floor((i-1)/MH_col)+1;
                j=i;% on bouge pas
                if (x<MH_col) % si pas derniere colonne
                    if  (obj.MursVerticaux(y,x)==0); % et si pas de mur
                        j   =   i + 1; % on peut aller a droite
                    end
                end
                D(j,i)=1;
            end
            
            % Gauche
            for i=1:nb_case
                x=mod(i-1,MH_col)+1;
                y=floor((i-1)/MH_col)+1;
                j=i; % on bouge pas
                if (x>1) % si pas 1ere colonne
                    if  (obj.MursVerticaux(y,x-1)==0) % et si pas de mur
                        j=i-1; % on peut aller a droite
                    end
                end
                G(j,i)=1;
            end
        end
        
        %%%%%%%%%%%%%% génération d'évolution jusqu'au mur %%%%%%%%%%%%%%%%%%
        function [H, B, G, D] = jusqu_au_mur(obj)
            % dimensions
            [MV_lig,MV_col] = size(obj.MursVerticaux); % dim murs verticaux
            [MH_lig,MH_col] = size(obj.MursHorizontaux); % dim murs horizontaux
            nb_case=MH_col*MV_lig; % largeur matrices transitions
            H=zeros(nb_case); % init de la mat de Haut
            B=zeros(nb_case); % init de la mat de Bas
            D=zeros(nb_case); % init de la mat de Droite
            G=zeros(nb_case); % init de la mat de Gauche
            
            % Haut
            for i=1:nb_case
                x=mod(i-1,MH_col)+1;
                y=floor((i-1)/MH_col)+1;
                j=i;
                if (y>1)
                    if  (obj.MursHorizontaux(y-1,x)==0)
                        j=find( H(:,i-MH_col)>0 );
                    end
                end
                H(j,i)=1;
            end
            % Bas
            for i=nb_case:-1:1
                x=mod(i-1,MH_col)+1;
                y=floor((i-1)/MV_lig)+1;
                j=i;
                if (y<MV_lig)
                    if  (obj.MursHorizontaux(y,x)==0)
                        j=find( B(:,i+MH_col)>0 );
                    end
                end
                B(j,i)=1;
            end
            % Droite
            for i=nb_case:-1:1
                y=floor((i-1)/MH_col)+1;
                x=mod(i-1,MH_col)+1;
                j=i;
                if (x<MH_col)
                    
                    if  (obj.MursVerticaux(y,x)==0)
                        j=find( D(:,i+1)>0 );
                    end
                end
                D(j,i)=1;
            end
            % Gauche
            for i=1:nb_case
                y=floor((i-1)/MH_col)+1;
                x=mod(i-1,MH_col)+1;
                
                j=i;
                if (x>1)
                    if  (obj.MursVerticaux(y,x-1)==0)
                        j=find( G(:,i-1)>0 );
                    end
                end
                G(j,i)=1;
            end
        end
        %%%%%%%%%%%%%% génération d'évolution incertaine %%%%%%%%%%%%%%%%%%
        
        function [H, B, G, D] = incertain(obj)
            [MV_lig,MV_col] = size(obj.MursVerticaux);
            [MH_lig,MH_col] = size(obj.MursHorizontaux);
            nb_case=MH_col*MV_lig;
            H=zeros(nb_case);
            B=zeros(nb_case);
            D=zeros(nb_case);
            G=zeros(nb_case);
            % Haut
            for i=1:nb_case
                x=mod(i-1,MH_col)+1;
                y=floor((i-1)/MH_col)+1;
                j=i;
                if (y>1)
                    if  (obj.MursHorizontaux(y-1,x)==0)
                        j   =   i -MH_col;
                    end
                end
                H(j,i)=1;
                if (y>1)
                    if  (obj.MursHorizontaux(y-1,x)==0)
                        j=find( H(:,i-MH_col)>0 );
                    end
                end
                H(j,i)=1;
            end
            % Bas
            for i=nb_case:-1:1
                x=mod(i-1,MH_col)+1;
                y=floor((i-1)/MH_col)+1;
                j=i;
                if (y<MV_lig)
                    if  (obj.MursHorizontaux(y,x)==0);
                        j   =   i + MH_col;
                    end
                end
                B(j,i)=1;
                if (y<MV_lig)
                    if  (obj.MursHorizontaux(y,x)==0)
                        j=find( B(:,i+MH_col)>0 );
                    end
                end
                B(j,i)=1;
            end
            
            % Droite
            for i=nb_case:-1:1
                y=floor((i-1)/MH_col)+1;
                x=mod(i-1,MH_col)+1;
                j=i;
                if (x<MH_col)
                    if  (obj.MursVerticaux(y,x)==0)
                        j   =   i + 1;
                    end
                end
                D(j,i)=1;
                if (x<MH_col)
                    if  (obj.MursVerticaux(y,x)==0)
                        j=find( D(:,i+1)>0 );
                    end
                end
                D(j,i)=1;
            end
            % Gauche
            for i=1:nb_case
                y=floor((i-1)/MH_col)+1;
                x=mod(i-1,MH_col)+1;
                j=i;
                if (x>1)
                    if  (obj.MursVerticaux(y,x-1)==0)
                        j   =   i - 1;
                    end
                end
                G(j,i)=1;
                if (x>1)
                    
                    if  (obj.MursVerticaux(y,x-1)==0)
                        j=find( G(:,i-1)>0 );
                    end
                end
                G(j,i)=1;
            end
            
        end
        
        
        %%%%%%%%%%%%%% génération d'affichage %%%%%%%%%%%%%%%%%%
        function affichage(obj)
            [MV_lig,MV_col] = size(obj.MursVerticaux);
            [MH_lig,MH_col] = size(obj.MursHorizontaux);
            nb_case=MH_col*MV_lig;
            %Création du labyrinthe
            h = figure(1);
            
            axis equal
            xlim([0 MH_col])
            ylim([0 MV_lig])
            hold on
            %%Encadrement
            line([0,0],[0,MV_lig],'linewidth',2);           % bord gauche
            line([MH_col,MH_col],[MV_lig, 0],'linewidth',2);% bord droit
            line([0,MH_col],[MV_lig,MV_lig],'linewidth',2); % bord haut
            line([0,MH_col],[0,0],'linewidth',2);           % bord bas
            %%Grille
            grid on
            tickValuesX = min(0):1:max(MH_col);
            tickValuesY = min(0):1:max(MV_lig);
            set(gca,'XTick',tickValuesX);
            set(gca,'YTick',tickValuesY);
            %%Numerotation
            z=0;
            h = (1:nb_case)';
            g = num2str(h);
            for y=MV_lig:-1:1;
                for x= 1:MH_col;
                    z=z+1;
                    text(x-0.5,y-0.5,g(z,:))
                    % Etats initiaux
                    if find( obj.Etats_Initiaux(1,:)== z)
                        text(x-0.9,y-0.25,'Etat initial','Color','green','FontSize',10)
                    end
                    % Etats finaux
                    if find( obj.Etats_Finaux(1,:)== z)
                        text(x-0.9,y-0.75,'Etat Marqué','Color','red','FontSize',10)
                        %viscircles([x-0.5,y-0.5],.25);
                        %viscircles([x-0.5,y-0.5],.2);
                    end
                end
            end
            %%Mise en place des murs
            
            for i= 1:MV_lig
                for j=1:MV_col
                    if ( obj.MursVerticaux(i,j)==1 )
                        line([j,j],[MV_lig-i+1,MV_lig-i],'linewidth',2);
                        %                         fprintf('V : départ (%d, %d) \t arrivé (%d, %d)\n',j,j ,MV_lig-i+1,MV_lig-i);
                    end
                end
            end
            
            for i= 1:MH_lig
                for j=1:MH_col
                    if ( obj.MursHorizontaux(i,j)==1 )
                        line([j-1,j] ,[MH_lig-i+1,MH_lig-i+1],'linewidth',2)
                        %                         fprintf('H : départ (%d, %d) \t arrivé (%d, %d)\n',j-1,j ,MH_lig-i+1,MH_lig-i+1);
                        
                        %    [MH_col-(MH_col-j+1),MH_col-(MH_col-j)],[MH_col-i,MH_col-i]
                    end
                end
            end
            hold off
        end   %ok ! (rectangulaire aussi)
    end
    
end

