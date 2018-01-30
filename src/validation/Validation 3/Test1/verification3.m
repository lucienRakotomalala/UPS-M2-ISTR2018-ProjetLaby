state = load('state.mat');
i=1;
positionPacman=cell(100,1);
positionGhost=cell(100,1);
positionWallsVert=cell(100,1);
positionWallsHoriz=cell(100,1);

for i=1 :100
%while (isempty(state.labyState{i,1})~=1)
positionPacman{i}=state.labyState{i,1};
positionGhost{i}=state.labyState{i,2};
positionWallsVert{i}=state.labyState{i,3};
positionWallsHoriz{i}=state.labyState{i,4};
%i=i+1;
end

for j=1 : i-2
    %pour Pacman
        mov=positionPacman{j+1}-positionPacman{j};
        if(mov(1)==1)
            %en x on verifie que l'on est pas de mur horizontal en bas
            if(positionWallsHoriz{j}(positionPacman{j}(1),positionPacman{j}(2))==1)
                 fprintf('\t>erreur franchissement de murs pacman= [%d %d]\n', positionPacman{j});
            end
        elseif(mov(1)==-1)
            %en x on verifie que l'on est pas de mur horizontal en haut
            if(positionWallsHoriz{j}(positionPacman{j+1}(1),positionPacman{j+1}(2))==1)
                 fprintf('\t>erreur franchissement de murs pacman= [%d %d]\n', positionPacman{j});
            end
        end
        if(mov(2)==1)
            %en y on verifie que l'on est pas de mur vertical a gauche
               if(positionWallsVert{j}(positionPacman{j}(1),positionPacman{j}(2))==1)
                 fprintf('\t>erreur franchissement de murs pacman= [%d %d]\n', positionPacman{j});
               end
        elseif(mov(2)==-1)
            %en y on verifie que l'on est pas de mur vertical a droit
            if(positionWallsVert{j}(positionPacman{j+1}(1),positionPacman{j+1}(2))==1)
                 fprintf('\t>erreur franchissement de murs pacman= [%d %d]\n', positionPacman{j});
            end
        end
end
for j=1 : i-2
        %pour Ghost
        movG=positionGhost{j+1}-positionGhost{j};
        if(movG(1)==1)
            %en x on verifie que l'on est pas de mur horizontal en bas
            if(positionWallsHoriz{j}(positionGhost{j}(1),positionGhost{j}(2))==1)
                 fprintf('\t>erreur franchissement de murs Ghost= [%d %d] a j=%d\n', positionGhost{j}, j);
            end
        elseif(movG(1)==-1)
            %en x on verifie que l'on est pas de mur horizontal en haut
            if(positionWallsHoriz{j}(positionGhost{j+1}(1),positionGhost{j+1}(2))==1)
                 fprintf('\t>erreur franchissement de murs Ghost= [%d %d] a j=%d\n', positionGhost{j}, j);
            end
        end
        if(movG(2)==1)
            %en y on verifie que l'on est pas de mur vertical a gauche
               if(positionWallsVert{j}(positionGhost{j}(1),positionGhost{j}(2))==1)
                 fprintf('\t>erreur franchissement de murs Ghost= [%d %d] a j=%d\n', positionGhost{j}, j);
               end
        elseif(movG(2)==-1)
            %en y on verifie que l'on est pas de mur vertical a droit
            if(positionWallsVert{j}(positionGhost{j+1}(1),positionGhost{j+1}(2))==1)
                 fprintf('\t>erreur franchissement de murs Ghost= [%d %d]j=%d\n', positionGhost{j}, j);
            end
        end
end 
fprintf('\t>test finish\n')