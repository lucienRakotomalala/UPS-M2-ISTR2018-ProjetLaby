%% This function permits to clean the procede automata from a FSM file
%   It keep the good name of transition to do a Parallel Product with a
%   command
%
clear
%% Open File
myF = fopen('procede.fsm');
% Take all char
data = fread(myF,'*char');

% Char we will analyse
dir = 'ULRD';
num ='1234567890';

% add of char we will delete
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
%% Write the clean file
name = strcat('procede','.fsm');
F = fopen(name, 'w');
fwrite(F,data);
fclose(F);
% 1. lecture un char
% 2. si U L R D
    % 3. On vérifie si un chiffre est apres
    %       