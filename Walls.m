classdef Walls
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        verticalWalls;
        horizontalWalls;
        allVerticalWalls;
        allHorizontalWalls;
        labSize=5;
    end
    
    methods
        % Méthode de Walls : 
        %      1. Constructeur
        %      2. display
        %      3. setVerticalWalls
        %      4. set_MursHorizntaux
        %%%%%%%%%%%%%% constructeur %%%%%%%%%%%%%%%%%%
        function obj = Walls(handles)
            % Constructeurs de touts les murs du labyrinthe.
            %   Entrée : handles de la figure qui doit contenir axes1 près
            %           à recueillirla figure
            %   Sortie : objet Walls  passer entre le guidata de la figure.
            

            obj.verticalWalls = [1 0 0 0; 0 0 1 0; 1 0 0 0; 1 0 1 0; 0 0 1 0];
            obj.horizontalWalls = [ 1 0 1 0 1; 1 0 1 0 1; 1 0 1 0 1; 0 1 0 1 0]; 
            obj.allVerticalWalls = [];
            obj.allHorizontalWalls = [];
            %Walls extérieurs
            line([0,0],[0,5],'linewidth',2); % bord gauche
            line([5,0],[5,5],'linewidth',2); 
            line([5,5],[0,5],'linewidth',2); % bord droite
            line([0,5],[0,0],'linewidth',2); % bord bas
            
            %%Grille
            tickValuesX = 0:1:5;
            tickValuesY = 0:1:5;
            set(gca,'XTick',tickValuesX);
            set(gca,'YTick',tickValuesY);
            
            %Walls horizontaux
            axes(handles.axes1)
            k=1;
            for i=1:obj.labSize-1
                for j=0:obj.labSize-1
                    obj.allHorizontalWalls=[obj.allHorizontalWalls; line([j j+1],[obj.labSize-i obj.labSize-i],'linewidth',2)]; %A enlever après initialisation
                    if (obj.horizontalWalls(i, j+1)==1)
                        set(obj.allHorizontalWalls(k, 1), 'visible', 'on'); 
                    else
                        set(obj.allHorizontalWalls(k, 1), 'visible', 'off');
                    end 
                    k=k+1;
                end
            end
 
            %Walls verticaux
  
            k=1;
            for i=0:obj.labSize-1
                for j=1:obj.labSize-1
                    obj.allVerticalWalls=[obj.allVerticalWalls; line([j j],[obj.labSize-i obj.labSize-(i+1)],'linewidth',2)]; %A enlever après initialisation
                    if (obj.verticalWalls(i+1, j)==1)
                        set(obj.allVerticalWalls(k, 1), 'visible', 'on'); 
                    else
                        set(obj.allVerticalWalls(k, 1), 'visible', 'off');
                    end  
                    k=k+1;
                end        
             end
            grid on
        end
        
        %% Fonction d'affichage des murs
        % Entrée : - handles de la figure, contenant axes1
        %          - objet Walls
        function displayWall (handles, myWall)
           % Méthode d'affichage sur le mur 
           % Entrée : handles de la figure
           %            objet mur
           axes(handles.axes1);  % Placement de l'axe sur l'axes1
           k = 1;
           for i=1:myWall.labSize-1    % Walls Horizontaux
                for j=0:myWall.labSize-1
                    if (myWall.horizontalWalls(i, j+1)==1)
                        set(myWall.allHorizontalWalls(k, 1), 'visible', 'on'); 
                    else
                        set(myWall.allHorizontalWalls(k, 1), 'visible', 'off');
                    end 
                    k=k+1;
                end
            end
               k = 1;
            for i=0:myWall.labSize-1    %Walls Verticaux
                for j=1:myWall.labSize-1
                    myWall.verticalWalls(i+1, j) ;
                    if (myWall.verticalWalls(i+1, j)==1)
                        set(myWall.allVerticalWalls(k, 1), 'visible', 'on'); 
                    else
                        set(myWall.allVerticalWalls(k, 1), 'visible', 'off');
                    end
                    k=k+1;
                end
            end
            grid on
        end
        
        %% Fonction pour bouger les murs Verticaux vers le bas.
        % Entrée : Objet Mur
        % Sortie : Objet Mur
        function obj = setVerticalWalls(obj)
                [c,~]=size(obj.verticalWalls);
                Memory=obj.verticalWalls;
                NewWalls(c,:)= Memory(1,:);
                for i=1:c-1
                    NewWalls(i,:) = Memory(i+1,:);
                end
                obj.verticalWalls = NewWalls;
            end
        %% Fonction pour bouger les murs Horizontaux vers la droite.
        % Entrée : Objet Mur
        % Sortie : Objet Mur   
      function obj = setHorizontalWalls(obj)
                    [~,c]=size(obj.horizontalWalls);
                    Memory=obj.horizontalWalls;
                    NewWalls(:,c)= Memory(:,1);
                    for i=1:c-1
                        NewWalls(:,i) = Memory(:,i+1);
                    end
                    obj.horizontalWalls = NewWalls;
              end
            
  
        end
end
    

