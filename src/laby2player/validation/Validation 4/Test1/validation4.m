state = load('state.mat');
wallsComV = load('mursVert.mat');
wallsComH = load('mursHoriz.mat');
positionWallsVert=cell(100,1);
positionWallsHoriz=cell(100,1);
i=1;
for i=1 :10
%while (isempty(state.labyState{i,1})~=1)
positionWallsVert{i}=state.labyState{i,3};
positionWallsHoriz{i}=state.labyState{i,4};
%i=i+1;
end

for j=1 : i-1
    if(isequal(wallsComV.mursV{j},positionWallsVert{j})==0)
        fprintf('\t>erreur murs vertical différent\n')
    end
    
    if(isequal(wallsComH.mursH{j},positionWallsHoriz{j})==0)
        fprintf('\t>erreur murs horizontal différent\n')
    end    
end
fprintf('\t>test finish\n')