state = load('state.mat');
positionWallsVert=cell(100,1);
positionWallsHoriz=cell(100,1);
positionGhost=cell(100,1);
positionPacman=cell(100,1);
caught= cell(100,1);
i=1;
prise = 0;
%for i=1 :100
while (isempty(state.labyState{i,1})~=1)
positionPacman{i}=state.labyState{i,1};
positionGhost{i}=state.labyState{i,2};
positionWallsVert{i}=state.labyState{i,3};
positionWallsHoriz{i}=state.labyState{i,4};
caught{i}=state.labyState{i,5};
i=i+1;
end

for j=1 : i-2
    mod=positionPacman{j}-positionGhost{j};
    if ((mod(1)==1  && mod(2)==0  && (positionWallsVert{j}(positionGhost{j}(2),positionGhost{j}(1))     ==0))|| + ...
        (mod(1)==-1 && mod(2)==0  && (positionWallsVert{j}(positionPacman{j}(2),positionPacman{j}(1))   ==0))|| + ...
        (mod(1)==0  && mod(2)==1  && (positionWallsHoriz{j}(positionGhost{j}(2),positionGhost{j}(1))    ==0))|| + ...
        (mod(1)==0  && mod(2)==-1 && (positionWallsHoriz{j}(positionPacman{j}(2),positionPacman{j}(1))  ==0)))
    
        prise=1;
    else
        prise=0;
    end
    if(caught{j}==0 && prise)
        fprintf('\t>erreur simulation caught a i=%d \n', j);
    end
end
fprintf('\t>fin simulation\n');