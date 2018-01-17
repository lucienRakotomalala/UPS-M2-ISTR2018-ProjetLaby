function Video = CreatePituresAndVideo(n, escape_i, labyState )



%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% VISUALISATION OF THE MAZE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% save state as one matrix
% > in a case : 0 nothing; 1 : wall ; 2 : ghost ; 3: pacman; 4 : escape 

Ms = max(size(labyState{1,3}));
N = 2*Ms+1; % total size of maze
Visu = zeros(N,N,n);

% escape (out{2} : ghost [x y]) in Visu 2 = ghost
escapePos = escape_i{1}*[0 2; 2 0];
Visu(escapePos(1),escapePos(2),:)=4;
%
Visu([1 N],:,:)=1; % Vertical sides

Visu(:,[1 N],:)=1; % Horizontal sides

 % Filling wall intersections
i = find((1:N).*mod((1:N),2));
Visu(i,i,:)=1;
% 
for i = 1:n
    %walls
    %Vertical walls
    [ymv, xmv]=find(labyState{i,3});
    yav = ymv.*2;
    xav = xmv.*2+1;
    %Horizontal walls
    [ymh, xmh]=find(labyState{i,4});
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

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% PICTURES AND VIDEO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Extension de l'affichage
% pour tout n
% 1. faire une 11x11x3 = 11x11
% 2. transformer la 11x11x3 (empty,walls,ghost,pacman,escape)
% 3. etendre la 11x11*3 avec kron
    
resImg = 100;%resolution of image in pixel size = resImg*(2*n+1)
emptyColor=[1,1,1];
wallsColor = [0,0,1];

ghostColor=[1,.5,0];
pacmanColor=[0,1,.5];
escapeColor=[1 ,0,0];

imgs=zeros(resImg*N,resImg*N,3,n); % n rgb pictures with ( x  pixels)
rgbImg = zeros(N,N,3);

%%
for i = 1 : n
    %1.11x11x3
    rgbImg(:,:,1)=repmat(Visu(:,:,i),[1 1 1]);
    %2.color
    rgbImg=setColor(rgbImg,Visu(:,:,i),emptyColor,0);
    rgbImg=setColor(rgbImg,Visu(:,:,i),wallsColor,1);
    rgbImg=setColor(rgbImg,Visu(:,:,i),ghostColor,2);
    rgbImg=setColor(rgbImg,Visu(:,:,i),pacmanColor,3);
    rgbImg=setColor(rgbImg,Visu(:,:,i),escapeColor,4);


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


%% save as pictures AND video 
repo = strcat('./data/',datestr(now,'yyyy-mm-dd_HH-MM'));
mkdir(repo);
save(strcat(repo,'/state'),'labyState');
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

end

