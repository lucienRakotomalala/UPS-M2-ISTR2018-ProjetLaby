function Video = CreatePituresAndVideo_textured(n, escape_i, labyState )
%%
%escape_i= labyInit.escape_i

%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% VISUALISATION OF THE MAZE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% save state as one matrix
% > in a case : 0 nothing; 1 : wall ; 2 : ghost ; 3: pacman; 4 : escape 
%%%%%%%%%  LABYSTATE  %%%%%%%%%%%
%            obj.out{1} = zeros(1,2); % pacman [x y]
%            obj.out{2} = zeros(1,2); % ghost  [x y]
%            obj.out{3} = zeros(size(obj.modelLaby.presentState.wallsV)); %  Vertical Walls
%            obj.out{4} = zeros(size(obj.modelLaby.presentState.wallsH)); %  Horizontal Walls
%            obj.out{5} = 0 ;         % caught
%            obj.out{6} = 0 ;         % escape
%            obj.out{7} = zeros(1,4); % Walls around pacman [Up Down Left Right]
%            obj.out{8} = zeros(1,4); % Walls around ghost  [Up Down Left Right]
%            obj.out{9} = zeros(1,4); % Ghost sees pacman   [Up Down Left Right]
Ms = max(size(labyState{1,3}));
%%
N = 2*Ms+1; % total size of maze

Visu = zeros(N,N,n);

%pacman (out{1} : pacman [x y]) in Visu 3 = pacman

% escape (out{2} : ghost [x y]) in Visu 2 = ghost


Visu(2:2:N-1,1,:)=5;                 % Vertical left border with size 100
Visu(3:2:N-2,1,:)=26;                % Vertical left border with size 50
Visu(2:2:N-1,N,:)=7;                 % Vertical Right border with size 100
Visu(3:2:N-2,N,:)=24;                % Vertical Right border with size 50
Visu(1,2:2:N-1,:)=6;                 % Horizontal top border with 100
Visu(1,3:2:N-2,:)=23;                 % Horizontal top border with size 50
Visu(N,2:2:N-1,:)=8;                 % Horizontal lower border with size 100
Visu(N,3:2:N-2,:)=25;                % Horizontal lower border with size 50
Visu(1,1,:)=9;                       % Border Corner NW
Visu(N,1,:)=12;                      % Border Corner SW
Visu(1,N,:)=10;                      % Border Corner NE
Visu(N,N,:)=11;                      % Border Corner SE


%Visu(:,[1 N],:)=1; % Horizontal sides

% Filling wall intersections
[~,~,iWallMidd] = find((2:N-1).*mod((2:N-1),2));

iCase =  2:2:N-1;
iVWall = 3:2:N-2;
iHWall = 2:2:N-1;

for i = 1:n
    %walls
    %Vertical walls
    
    Visu(iHWall, iVWall,i)=15;
    [xmv, ymv]=find(labyState{i,3});
    xav = xmv.*2;
    yav = ymv.*2+1;
    %Horizontal walls
    Visu(iVWall,iHWall,i)=13;
    [xmh, ymh]=find(labyState{i,4});
    xah = xmh.*2+1;
    yah = ymh.*2;
    for ee = 1:max(size(yav))
        Visu(xav(ee),yav(ee),i) = 16;
    end
    for ee = 1:max(size(xah))
        Visu(xah(ee),yah(ee),i) = 14;
    end
    
    pacpos =  labyState{i,1}*[2 0; 0 2]; % adapt position and flip
    
    Visu(pacpos(2),pacpos(1),i)=1;  % Pacman Position
    escapePos = escape_i{1}*[2 0; 0 2];
    if pacpos==escapePos
        Visu(escapePos(1),escapePos(2),:)=4;     % Pacman on Escape
    else
        Visu(escapePos(1),escapePos(2),:)=3; % Escape Position
    end
    
    %
    
    %ghost (out{2} : ghost [x y]) in Visu 2 = ghost
    ghostpos =  labyState{i,2}*[0 2; 2 0]; % adapt position and flip
    Visu(ghostpos(1),ghostpos(2),i)=2;
     for z = 3:2:N-2
         for j = 3:2:N-2
            if (int8(Visu(z-1,j,i)==16) + int8(Visu(z+1,j,i)==16) + int8(Visu(z,j-1,i)==14) + int8(Visu(z,j+1,i)==14))<2
                %fprintf('n(%d)z(%d)j(%d)\t Empty Middle Walls\n',i,z,j)
                Visu(z,j,i)= 17; %% Middle Wall is Empty
            elseif (int8(Visu(z-1,j,i)==16) + int8(Visu(z+1,j,i)==16) + int8(Visu(z,j-1,i)==14) + int8(Visu(z,j+1,i)==14))>=3
                %fprintf('n(%d)z(%d)j(%d)\t Full Middle Walls\n',i,z,j)
               Visu(z,j,i)=18; %% Middle Wall is Full
            elseif ( int8(Visu(z,j-1,i)==14) + int8(Visu(z-1,j,i)==16))==2
                %fprintf('z(%d)j(%d)\t NW Middle Walls\n',z,j)
                Visu(z,j,i)= 19; % Wall Middle NW
            elseif (int8(Visu(z,j+1,i)==14) + int8(Visu(z-1,j,i)==16))==2
               % fprintf('z(%d)j(%d)\t NE Middle Walls\n',z,j)
                Visu(z,j,i)= 20; % Wall Middle NE
            elseif (int8(Visu(z+1,j,i)==16) + int8(Visu(z,j-1,i)==14))==2
                %fprintf('z(%d)j(%d)\t SW Middle Walls\n',z,j)
                Visu(z,j,i)=21; % Wall Middle SW
            elseif (int8(Visu(z,j+1,i)==14) + int8(Visu(z+1,j,i)==16))==2
               % fprintf('z(%d)j(%d)\t SE Middle Walls\n',z,j)
                Visu(z,j,i)=22; % Wall Middle SE
            elseif (int8(Visu(z-1,j,i)==16) + int8(Visu(z+1,j,i)==16))==2 
                 Visu(z,j,i)=18; %% Middle Wall is Full
            elseif (int8(Visu(z,j-1,i)==14) + int8(Visu(z,j+1,i)==14))==2 
                 Visu(z,j,i)=18; %% Middle Wall is Full
            end
         end
     end
end





%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% PICTURES AND VIDEO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Extension de l'affichage
% pour tout n
% 1. faire une 11x11x3 = 11x11
% 2. transformer la 11x11x3 (empty,walls,ghost,pacman,escape)
% 3. etendre la 11x11*3 avec kron
    
resCase     = 100;  %resolution of image in pixel size = resImg*(2*n+1)
resWall     = 50; 
% texture reading
text.n = {'empty.png',...                   %1
                'pacman.png',...            %2
                'ghost.png',...             %3
                'escape.png',...            %4
                'pacman_escaped.png',...    %5
                'border.png',...            %6
                'border_corner.png',...     %7
                'wall_empty.png',...        %8
                'wall.png',...              %9
                'wall_middle_empty.png',... %10
                'wall_middle_full.png',...  %11
                'wall_middle_half.png'};    %12
%dir ='.\texture\';
dir ='./texture/';
text.n = strcat(dir,text.n);            
% all the different cases
for i = 1 : 5
    text.img{i} = imread(text.n{i});
end
% border
text.img{6} = rot90( imread(text.n{6}));        % left border
text.img{7} = imread(text.n{6});                % up border
text.img{8} = rot90(flip( imread(text.n{6})));  % right border
text.img{9} = flip( imread(text.n{6}));         % down border
% border corner

text.img{10} = imread(text.n{7});           %corner NW
text.img{11} = fliplr(imread(text.n{7}));   %corner NE
text.img{12} =rot90(imread(text.n{7}),2);   %corner SE
text.img{13} = flipud(imread(text.n{7}));   %corner SW
% walls
text.img{14} = imread(text.n{8});           % wall horiz empty
text.img{16} = rot90(imread(text.n{8}));           % wall verti empty
text.img{15} = imread(text.n{9});           % wall horiz
text.img{17} = rot90(imread(text.n{9}));    % wall verti
% wall middles
text.img{18} = imread(text.n{10});          % emtpy
text.img{19} = imread(text.n{11});          % full
text.img{20} = flipud(imread(text.n{12}));  % NW
text.img{21} = rot90(imread(text.n{12}),2); % NE
text.img{23} = rot90(imread(text.n{12}));   % SE
text.img{22} = imread(text.n{12});          % SW
%% half border 
text.img{24} = text.img{7}(:,1:end/2,:);          % half up border
text.img{25} = text.img{8}(1:end/2,:,:);           % half right border
text.img{26} = text.img{9}(:,1:end/2,:);         % half down border
text.img{27} = text.img{6}(1:end/2,:,:);          % half left border

% uint8 to double 
for i = 1 : 27
    text.img{i}    = double(text.img{i})/255;
end


% end
% cim image :
imgsSize = resCase*(2+Ms) +resWall*(Ms-1);
imgs        = (ones(imgsSize,imgsSize , 3 , n))/2; % n rgb pictures with ( x  pixels)
%%
x = 1;
y = 1;
xl = 0;
yl = 0;
sm = 0;
for a = 1:n
    for i = 1 :N %x -> 
        for j = 1: N%y \V/
            % lecture dim text a placer
            [yl , xl,~] = size(text.img{Visu(i,j,a)+1});
            
            %fprintf('i%d j%d \t xl,yl = %d,%d\n',i,j,xl,yl)
            %fprintf('x : %d-%d \t y : %d-%d\n',x,x+xl-1,y,y+yl-1)
           % disp(size(imgs))
            % application text canal R
           % fprintf('[%dx%d(%d)] ',xl,yl,Visu(i,j,a)+1);
                imgs(y:y+yl-1,x:x+xl-1,1,a) = text.img{Visu(i,j,a)+1}(:,:,1);% R
                %sm = sm +size(text.img{Visu(i,j,a)+1}(:,:,1),2)
            % application text canal G
                imgs(y:y+yl-1,x:x+xl-1,2,a) = text.img{Visu(i,j,a)+1}(:,:,2);% G
            % application text canal B
                imgs(y:y+yl-1,x:x+xl-1,3,a) = text.img{Visu(i,j,a)+1}(:,:,3);% B
            % calcul nouveau curseur
            x = x + xl;
            % y pareil pr la m?me ligne
           % fprintf('i(%d) j(%d) x(%d) y(%d) xl(%d) yl(%d)\n',i,j,x,y,xl,yl)
%            figure(1)
%            imshow(imgs(:,:,:,a)) 
%            figure(2)
%                imagesc(text.img{Visu(i,j,a)+1})
%             pause(.51)
        end
        %fprintf('\n');
        x = 1;%?
        y = y + yl;
    end
    y = 1;% ?
end
%% save as pictures AND video 
repo = strcat('./data/',datestr(now,'yyyy-mm-dd_HH-MM'));
mkdir(repo);
save(strcat(repo,'/state'),'labyState');
video = VideoWriter(strcat(repo,'/video.avi'),'Motion JPEG AVI');
open(video)
for i = 1 : n
    name = strcat(repo,'/Simu_',int2str(i),'.jpg');
    imwrite(imgs(:,:,:,i),name,'jpg'); 
    %A = imread(name);
    for j = 1 : 20
        writeVideo(video,imgs(:,:,:,i));
    end
end
close(video)



end


