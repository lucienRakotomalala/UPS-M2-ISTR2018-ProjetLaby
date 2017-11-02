classdef Objet 
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
        
    properties
        positionX;  % Position dans le labyrinthe
        positionY;
        AllPoint = [];
        taille_lab = 5;
        color='g*';
    end
    
    methods
        function obj = Objet(handles, color, positionX, positionY)
            obj.positionX = positionX;
            obj.positionY = positionY;
            x = 1:obj.taille_lab;
            y = 1:obj.taille_lab;
            k = 1;
            axes(handles.axes1);
            hold on 
            for i = x
                for j = y
                   obj.AllPoint = [obj.AllPoint; plot(i -0.5 ,j - 0.5, color)];
                   if(obj.positionX == i) && (obj.positionY==j)
                        set(obj.AllPoint(k,1),'visible','on');
                   else
                       set(obj.AllPoint(k,1),'visible','off');
                   end
                   k = k+1;
               end
           end
        end
        
        %% 
        function displayObject(handles, obj)
           axes(handles.axes1);
           hold on
           x = 1:obj.taille_lab;
           y = 1:obj.taille_lab;
           k = 1;
           for i = x
               for j = y
                   if((obj.positionX == i)&&(obj.positionY==j))
                        set(obj.AllPoint(k,1),'visible','on');
                   else
                       set(obj.AllPoint(k,1),'visible','off');
                   end
                   k = k+1;
                end
           end
            
          end
        
        
        %% D?placement de l'objet
        
        function obj = goDroite(handles, obj, m)
           if(obj.positionX < obj.taille_lab)
               if(autoriserDeplacementDroite(handles, obj, m))
                    obj.positionX = obj.positionX+1;
               end
           end
           displayObject(handles,obj);
        end
        
        function obj = goGauche(handles, obj, m)
           if(obj.positionX > 1)
               if(autoriserDeplacementGauche(handles, obj, m))
                    obj.positionX = obj.positionX-1;
               end
           end
           displayObject(handles,obj);
        end
        
        function obj = goHaut(handles, obj, m)
           if(obj.positionY < obj.taille_lab)
               if(autoriserDeplacementHaut(handles, obj, m))
                    obj.positionY = obj.positionY+1;
               end
           end
           displayObject(handles,obj);
        end
        
        function obj = goBas(handles, obj, m)
           if(obj.positionY > 1)
               if(autoriserDeplacementBas(handles, obj, m))
                    obj.positionY = obj.positionY-1;
               end
           end
           displayObject(handles,obj);
        end
        

        %Autoriser deplacement Haut
        function condDepHaut = deplacementHautPossible(obj, m)
            condDepHaut=0;
            if(obj.positionY<obj.taille_lab)
                if (m.MursHorizontaux(obj.taille_lab-obj.positionY, obj.positionX)==0)
                    condDepHaut=1;
                end
            end
        end
        
        %Autoriser deplacement Bas
        function condDepBas = deplacementBasPossible(obj, m)
            condDepBas=0;
            if(obj.positionY>1)
                                ' pas tout en bas'

                if (m.MursHorizontaux(obj.taille_lab-obj.positionY+1, obj.positionX)==0)
                    ' pas de mur en dessous'
                    condDepBas=1;
                end
            end
        end
        
        %Autoriser deplacement Droite
        function condDepDroite = deplacementDroitePossible(obj, m)
            condDepDroite=0;
            if(obj.positionX<5)
                if (m.MursVerticaux(obj.taille_lab-obj.positionY+1, obj.positionX)==0)
                    condDepDroite=1;
                end
            end
        end
        
        %Autoriser deplacement Gauche
        function condDepGauche = deplacementGauchePossible(obj, m)
            condDepGauche=0;
            if(obj.positionX>1)
                if (m.MursVerticaux(obj.taille_lab-obj.positionY+1, obj.positionX-1)==0)
                    condDepGauche=1;
                end
            end
        end

    end
    
end