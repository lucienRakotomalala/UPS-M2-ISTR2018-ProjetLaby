

% simulation totale
clear
close all
%%%%%%%%%%%%%%%%%%%%%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Number of iterations
n= 100; % static dimension

% state of laby 
labyState=cell(n,9); % static dimension
etat =0; % static dimension
etatS=0; % static dimension
numberOfPossibleCaught = 3;% static dimension
% Initial laby state
   wallsV_i =  [1 0 0 0 ; 1 0 0 1 ; 1 1 1 1 ; 1 0 0 1 ; 0 0 0 0]; %  dimension can change
    wallsH_i =  [0 1 1 1 0; 0 0 1 0 0; 0 0 1 0 0; 0 1 1 1 0]; %  dimension can change
    Ms = max(size(wallsH_i)); % size of lab  % static dimension

    pacman_i = [3 1]; % static dimension
    ghost_i  = [1 4]; % static dimension
    escape_i = {[5 5], 0}; % static dimension
    caught_i = 0; % static dimension

    % initial value of walls command
    wallsCommand_i = 0; % dimension can change
    % =0 : begin with right move 
    % =1 : begin with up move 

    % initial value of pacman command
    pacmanCommand_i= zeros(1,4);% dimension can change

    % initial value of pacman command
    ghostCommand_i= zeros(1,5);% dimension can change
%%%%%%%%%%%%%%%%%%%%%%%%%%% MAIN SCRIPT %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    i = 1 ;     
    SimulationStoped = 0;

    % creation of needed class
    lab = ModelLaby(wallsV_i,wallsH_i,pacman_i,ghost_i,escape_i,caught_i);
    wallCom = ModelWalls(wallsCommand_i);
    pacmanCom = ModelPacman(pacmanCommand_i);
    ghostCom = ModelGhost(ghostCommand_i);    
   % run 

while (i<=n && ~SimulationStoped)
    in = zeros(1,11);
    switch etat
        case 0  % Walls command
            etatS = 1;
            %'walls'
                nextStateWalls = wallCom.f(); 
                wallCom.m(nextStateWalls,in(1)); 
                in(2:3) = wallCom.g(); 
                
        case 1  % pacman command
            etatS = 2;
            %'pacman'
                nextStatePacman = pacmanCom.f(out{7});
                pacmanCom.m(nextStatePacman,in(1));
                in(4:7) = pacmanCom.g() ;   
                
        case 2  % ghost command
            etatS = 0;
            %'ghost'
                nextStateGhost = ghostCom.f(out{8}, out{9}, out{3}, out{4}, out{2} ); %Walls around ghost,ghost sees pacman, wallsV, wallsH, ghost_position)
                %nextStateGhost = ghostCom.f(out{8}, out{9}); %Walls around ghost,ghost sees pacman
                ghostCom.m(nextStateGhost,in(1));
                in(8:11) = ghostCom.g();
    end
    % m 
    etat=etatS;
    % laby 
    %'lab'
    nextStateLaby = lab.f(in);
    lab.m(nextStateLaby,in(1));
    out = lab.g();
    % keep out in a vect 
    labyState(i,:)= out;
    %%%%%%%%%%%%%% stop condition %%%%%%%%%%%%%%%%%%%%%%%    
    EscapeBreak         = out{6};
    CaughtBreak         = out{5}>numberOfPossibleCaught;
    PacmanWallsBreak    = sum(out{7}) == 4;
    GhostWallsBreak     = sum(out{8}) == 4;
     if (EscapeBreak || CaughtBreak || PacmanWallsBreak || GhostWallsBreak)
         SimulationStoped = 1;
     else
         i = i + 1;
     end
     %pause
    %%%%%%%%%%%%%%%%%%    
end
%% log message

fprintf('End of simulation :\n');
if(i>n) % sim finish
    fprintf('\t The simulation was not stopped (%d steps)\n',n);
else %sim break
    fprintf('\t the simulation have been stopped at the %d step on %d\n',i,n);
    if(EscapeBreak)
        fprintf('\t>Pacman escaped\n');
    end
    if(CaughtBreak)
        fprintf('\t>Ghost caught Pacman  %d times\n',numberOfPossibleCaught+1);
    end
    if(PacmanWallsBreak)
        fprintf('\t>Pacman trapped\n');
    end
    if(GhostWallsBreak)
        fprintf('\t>Ghost trapped\n');
    end
end
n = i; % now number of iteration is i-1;

%% Create picture for each iteration and Video in file data
CreatePituresAndVideo(wallsH_i, n, escape_i, labyState);