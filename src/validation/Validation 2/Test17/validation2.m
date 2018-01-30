state = load('state.mat');
i=1;
positionPacman=cell(100,1);
positionGhost=cell(100,1);
while (isempty(state.labyState{i,1})~=1)
positionPacman{i}=state.labyState{i,1};
positionGhost{i}=state.labyState{i,2};
i=i+1;
end

for j=1 : i-1
    if (positionPacman{j} == positionGhost{j})
      fprintf('\t>erreur position pacman= [%d %d] et ghost= [%d %d]\n', positionPacman{j}, positionGhost{j});
    end
end 
fprintf('\t>test finish\n')