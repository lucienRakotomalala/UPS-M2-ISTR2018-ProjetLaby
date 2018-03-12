function [Buff]=ParcourirMatricesTransitions(MatricesTransition, Poids)
%% Algorithme de Bellman-Ford
            
            nb_states=length(MatricesTransition);
            Buff=zeros(3,nb_states);
            Buff(1,2:end)=+inf
            Etat_courant=1;
            
           while Etat_courant <= nb_states
               %%
              [~,c]= find(MatricesTransition(Etat_courant,:)~=0)
              for k=1:length(c)
                dist = min(Buff(1,c(k)), Buff(1,Etat_courant) + Poids(1,c(k)))
                
                %    if(dist<Buff(1,c(k)))  J'ai pompé sur Wiki ...
                        Buff(2,c(k))=MatricesTransition(Etat_courant,c(k));
                        Buff(1,c(k))=dist;
                        Buff(3,c(k))=Etat_courant;
                 %   end
                
              end
              
                Etat_courant=Etat_courant+1
            
            end
            Buff =[ 1:1:nb_states ; Buff]; % Modification de la 1er Ligne
            
            


end

