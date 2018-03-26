state = load('state.mat');
%i=1;
positionPacman=cell(110,1);
positionGhost=cell(110,1);
for i=1 : 100
positionPacman{i}=stat.labyState{i,1};
positionGhost{i}=stat.labyState{i,2};
end

for j=1 : i
    if (positionPacman{j} == positionGhost{j})
      fprintf('\t>erreur position pacman= [%d %d] et ghost= [%d %d]\n', positionPacman{j}, positionGhost{j});
    end
end 
fprintf('\t>test finish\n')