classdef Objet 
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
        
    properties
        positionX;  % Position dans le labyrinthe
        positionY;
        AllPoint = [];
        taille_lab=5;
    end
    
    methods
        function obj = Objet(handles)
            obj.positionX = 1;
            obj.positionY = 1;
            x = 1:obj.taille_lab;
            y = 1:obj.taille_lab;
            k = 1;
            axes(handles.axes1)
            for i = x
                for j = y
                   obj.AllPoint = [obj.AllPoint; plot(i -0.5 ,j - 0.5, 'r*')]
                   if(obj.positionX == i) && (obj.positionY==j)
                        set(obj.AllPoint(k,1),'visible','on')
                       
                   else
                       set(obj.AllPoint(k,1),'visible','off')
                   end
                   k = k+1;
               end
           end
        end
        
        
        %% 
        function displayObject(handles, obj)
           axes(handles.axes1)
           
           hold on
           x = 1:obj.taille_lab;
           y = 1:obj.taille_lab;
           k = 1;
           for i = x
               for j = y
                   if((obj.positionX == i)&&(obj.positionY==j))
                        set(obj.AllPoint(k,1),'visible','on')
                   else
                       set(obj.AllPoint(k,1),'visible','off')
                   end
                   k = k+1;
                end
            end
          end
        
        
        %% Déplacement de l'objet
        
        function obj = goDroite(handles, obj)
           if(obj.positionX < obj.taille_lab)
                obj.positionX = obj.positionX+1;
           end
           displayObject(handles,obj)
        end
        
        function obj = goGauche(handles, obj)
           if(obj.positionX > 1)
                obj.positionX = obj.positionX-1;
           end
           displayObject(handles,obj)
        end
    end
    
end

