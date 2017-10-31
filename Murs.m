classdef Murs
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        MursVerticaux;
        MursHorizontaux;
        mv;
        mh;
        taille_lab=5;
    end
    
    methods
        % Méthode de Murs : 
        %      1. Constructeur
        %      2. display
        %      3. set_MursVerticaux
        %      4. set_MursHorizntaux
        %%%%%%%%%%%%%% constructeur %%%%%%%%%%%%%%%%%%
        function obj = Murs(handles)
            % Constructeurs de touts les murs du labyrinthe.
            %   Entrée : handles de la figure qui doit contenir axes1 près
            %           à recueillirla figure
            %   Sortie : objet Murs  passer entre le guidata de la figure.
            
            % Valeurs initiales des murs :
            obj.MursVerticaux    = [1 0 1 0; 1 0 1 0; 1 0 1 0; 1 0 1 0; 0 0 1 0];
            obj.MursHorizontaux  = [ 1 0 1 0 1; 1 0 1 0 1; 1 0 1 0 1; 0 1 0 1 0]; 
            obj.mv = [];
            obj.mh = [];
            %Murs extérieurs
            line([0,0],[0,5],'linewidth',2); % bord gauche
            line([5,0],[5,5],'linewidth',2); 
            line([5,5],[0,5],'linewidth',2); % bord droite
            line([0,5],[0,0],'linewidth',2); % bord bas
            
            %%Grille
            tickValuesX = 0:1:5;
            tickValuesY = 0:1:5;
            set(gca,'XTick',tickValuesX);
            set(gca,'YTick',tickValuesY);
            
            %Murs horizontaux
            axes(handles.axes1)
            k=1;
            for i=1:obj.taille_lab-1
                for j=0:obj.taille_lab-1
                    obj.mh=[obj.mh; line([j j+1],[obj.taille_lab-i obj.taille_lab-i],'linewidth',2)]; %A enlever après initialisation
                    if (obj.MursHorizontaux(i, j+1)==1)
                        set(obj.mh(k, 1), 'visible', 'on'); 
                    else
                        set(obj.mh(k, 1), 'visible', 'off');
                    end 
                    k=k+1;
                end
            end
 
            %Murs verticaux
  
            k=1;
            for i=0:obj.taille_lab-1
                for j=1:obj.taille_lab-1
                    obj.mv=[obj.mv; line([j j],[obj.taille_lab-i obj.taille_lab-(i+1)],'linewidth',2)]; %A enlever après initialisation
                    if (obj.MursVerticaux(i+1, j)==1)
                        set(obj.mv(k, 1), 'visible', 'on'); 
                    else
                        set(obj.mv(k, 1), 'visible', 'off');
                    end  
                    k=k+1;
                end        
             end
            grid on
        end
        
        %% Fonction d'affichage des murs
        % Entrée : - handles de la figure, contenant axes1
        %          - objet Murs
        function displayWall (handles, myWall)
           % Méthode d'affichage sur le mur 
           % Entrée : handles de la figure
           %            objet mur
           axes(handles.axes1)  % Placement de l'axe sur l'axes1
           k = 1;
           for i=1:myWall.taille_lab-1    % Murs Horizontaux
                for j=0:myWall.taille_lab-1
                    if (myWall.MursHorizontaux(i, j+1)==1)
                        set(myWall.mh(k, 1), 'visible', 'on'); 
                    else
                        set(myWall.mh(k, 1), 'visible', 'off');
                    end 
                    k=k+1;
                end
            end
               k = 1;
            for i=0:myWall.taille_lab-1    %Murs Verticaux
                for j=1:myWall.taille_lab-1
                    myWall.MursVerticaux(i+1, j)
                    if (myWall.MursVerticaux(i+1, j)==1)
                        set(myWall.mv(k, 1), 'visible', 'on'); 
                    else
                        set(myWall.mv(k, 1), 'visible', 'off');
                    end
                    k=k+1;
                end
            end
            grid on
        end
        
        %% Fonction pour bouger les murs Verticaux vers le bas.
        % Entrée : Objet Mur
        % Sortie : Objet Mur
        function obj = set_MursVerticaux(obj)
                [c,~]=size(obj.MursVerticaux);
                Memoire=obj.MursVerticaux;
                NewMurs(c,:)= Memoire(1,:);
                for i=1:c-1
                    NewMurs(i,:) = Memoire(i+1,:);
                end
                obj.MursVerticaux = NewMurs;
            end
        %% Fonction pour bouger les murs Horizontaux vers la droite.
        % Entrée : Objet Mur
        % Sortie : Objet Mur   
      function obj = set_MursHorizontaux(obj)
                    [~,c]=size(obj.MursHorizontaux);
                    Memoire=obj.MursHorizontaux;
                    NewMurs(:,c)= Memoire(:,1);
                    for i=1:c-1
                        NewMurs(:,i) = Memoire(:,i+1);
                    end
                    obj.MursHorizontaux = NewMurs;
              end
            
  
        end
end
    

