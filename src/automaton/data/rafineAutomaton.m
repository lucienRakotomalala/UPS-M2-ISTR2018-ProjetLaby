clear
%% Ouverture fichier
myF = fopen('aOuvrir.fsm');

data = fread(myF,'*char');
dir = 'ULRD';
num ='1234567890';
bannedI = [];
%%
i=1;
while i <=length(data)
    
    
    if ~isempty(strfind(dir, data(i)))
        disp('updownluefright')
        ~isempty(strfind(num, data(i)))
        i = i+1;
        while ~isempty(strfind(num, data(i))) 
            bannedI = [bannedI, i];
            disp(data(i))
            i = i+1;
        end
        
    end
    i = i+1;
end
%%
fclose(myF);

%% 
data(bannedI) = [];
%% Ecriture fichier
name = strcat('memo','.fsm');
F = fopen(name, 'w');
fwrite(F,data);
fclose(F);
% 1. lecture un char
% 2. si U L R D
    % 3. On vérifie si un chiffre est apres
    %       