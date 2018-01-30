state = load('state.mat');
%positionPacman=cell(100,1);
escape= cell(100,1);
i=1;
%for i=1 :100
while (isempty(state.labyState{i,1})~=1)
%positionPacman{i}=state.labyState{i,1};
escape{i}=state.labyState{i,6};
i=i+1;
end

for j=1 : i-1
    if(escape{j}==1)
        if (j~=i-1)
            fprintf('\t>erreur simulation non fini apres que pacman ce sois echappe\n');
        end
    end
end
fprintf('\t>fin simulation\n');