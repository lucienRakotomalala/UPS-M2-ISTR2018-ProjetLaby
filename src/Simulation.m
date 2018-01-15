

% simulation totale
clear
close all
%%%%%%%%%%%%%%%%%%%%%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Number of interation
n= 100; % static dimension
% init 
labyState=cell(n,9); % static dimension
etat =0; % static dimension
etatS=0; % static dimension
numberOfPossibleCaught = 3;
noEscape = 0; % select if there is an escape or no
% Initial laby state
   wallsV_i = [1 0 1 1 ; 1 0 1 1; 1 0 0 0; 1 0 0 1; 1 0 1 0]; %  dimension can change
    wallsH_i = [1 0 1 1 1; 1 0 1 0 0; 1 0 1 0 0; 1 0 0 1 1];  %  dimension can change
    Ms = max(size(wallsH_i)); % size of lab  % static dimension

    pacman_i = [3 3]; % static dimension
    ghost_i  = [2 2]; % static dimension
    escape_i = {[4 4], 0}; % static dimension
    caught_i = 0; % static dimension

    % initial value of walls command
    wallsCommand_i = 0; % dimension can change
    % =0 : begin with right move 
    % =1 : begin with up move 

    % initial value of pacman command
    pacmanCommand_i= zeros(1,4);% dimension can change

    % initial value of pacman command
    ghostCommand_i= zeros(1,4);% dimension can change
i = 1 ; 
SimulationStoped = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%% MAIN SCRIPT %%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                nextStateGhost = ghostCom.f(out{8},out{9});
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
    if (noEscape == 0)
    EscapeBreak         = out{6};
    else
        EscapeBreak     = 0;
    end
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
    fprintf('\t the simulation have be stopped at the %d step of %d\n',i,n);
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
%% --- Visualisation

%%%%%%%%%%%%%%%%% 
% save state as one matrix
% > in a case : 0 nothing; 1 : wall ; 2 : ghost ; 3: pacman; 4 : escape 


N = 2*Ms+1; % taille tab total
Visu = zeros(N,N,n);

% escape (out{2} : ghost [x y]) in Visu 2 = ghost
if (noEscape==0)
    escapePos = escape_i{1}*[0 2; 2 0];
    Visu(escapePos(1),escapePos(2),:)=4;
end
%
Visu([1 N],:,:)=1; % bords verticaux

Visu(:,[1 N],:)=1; % bords horizontaux
 % Remplissage des intersections de murs
i = find((1:N).*mod((1:N),2));
Visu(i,i,:)=1;
% 
for i = 1:n
  %walls
    %vert
    [ymv, xmv]=find(labyState{i,3});%Mverti
    yav = ymv.*2;
    xav = xmv.*2+1;
    %hor
    [ymh, xmh]=find(labyState{i,4});%Mhoriz
    xah = xmh.*2;
    yah = ymh.*2+1;
 for ee = 1:max(size(yav))
     Visu(yav(ee),xav(ee),i) = 1;
 end
  for ee = 1:max(size(yah))
      Visu(yah(ee),xah(ee),i) = 1;
  end
  
  %pacman (out{1} : pacman [x y]) in Visu 3 = pacman
    pacpos =  labyState{i,1}*[0 2; 2 0]; % adapt position and flip
    Visu(pacpos(1),pacpos(2),i)=3;
  %ghost (out{2} : ghost [x y]) in Visu 2 = ghost
    ghostpos =  labyState{i,2}*[0 2; 2 0]; % adapt position and flip
    Visu(ghostpos(1),ghostpos(2),i)=2;
  
  
end



%%%%%%%%%%%%%%%%%%%%%%%%%% Rendu image %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Extension de l'affichage
% pour tout n
% 1. faire une 11x11x3 = 11x11
% 2. transformer la 11x11x3 (empty,walls,ghost,pacman,escape)
% 3. etendre la 11x11*3 avec kron
    
resImg = 100;%resolution of image in pixel
%=1 : no escape
%=0 : there is an escape place
emptyColor=[1,1,1];
wallsColor = [0,0,1];

pacmanColor=[1,.5,0];
ghostColor=[0,1,.5];
if (noEscape==0)
    escapeColor=[1 ,0,0];
end
%%

imgs=zeros(resImg*N,resImg*N,3,n); % n rgb pictures with (resolutionImage x resolutionImage pixels)
rgbImg = zeros(N,N,3);
%%
for i = 1 : n
    %%
    %1.11x11x3
    rgbImg(:,:,1)=repmat(Visu(:,:,i),[1 1 1]);
    %2.color
    rgbImg=setColor(rgbImg,Visu(:,:,i),emptyColor,0);
    rgbImg=setColor(rgbImg,Visu(:,:,i),wallsColor,1);
    rgbImg=setColor(rgbImg,Visu(:,:,i),ghostColor,2);
    rgbImg=setColor(rgbImg,Visu(:,:,i),pacmanColor,3);
    if(noEscape==0)
        rgbImg=setColor(rgbImg,Visu(:,:,i),escapeColor,4);
    end

    %3.kron
    imgs(:,:,1,i)=kron(rgbImg(:,:,1),ones(resImg,resImg));
    imgs(:,:,2,i)=kron(rgbImg(:,:,2),ones(resImg,resImg));
    imgs(:,:,3,i)=kron(rgbImg(:,:,3),ones(resImg,resImg));
end
% %% test 
% stepToSee = 1; % range 1 : n
% imtest= imgs(:,:,:,stepToSee);
% figure(1)
% imshow(imtest);


%% save as picture AND video 
repo = strcat('./data/', datestr(now,'yyyy-mm-dd_HH-MM'));
mkdir(repo);
video = VideoWriter(strcat(repo,'/video.avi'),'Motion JPEG AVI');
open(video)
for i = 1 : n
    name = strcat(repo,'/Simu_',int2str(i),'.jpg');
    imwrite(imgs(:,:,:,i),name,'jpg'); 
    A = imread(name);
    for j = 1 : 20
        writeVideo(video,A);
    end
end
close(video)

 
%imgs(indP)
% %% create video from simulation 
% 
% % Create a |VideoWriter| object for a new uncompressed AVI file for RGB24 video.

% 
% % Open the file for writing.
% 
% 
% % Write the image in |A| to the video file.
%
% 
% % Close the file.
% 

%% Trie des cases pertinentes
% i impair  &   j impair    => +
% i impair  &   j pair      => |
% i pair    &   j impair    => -
% i pair    &   j pair      => pas concerné
% A = ones(12);
% 
% for i = 1:12 % x axis
%     for j = 1 : 12 % y axis
%         if ( mod(i,2)==1 || mod(j,2)==1 )% si au moins un des 2 est impart
%             if(mod(i,2)==1)
%                 A(j,i)
%             end
%             A(i,j)
%         end
%     end
% end