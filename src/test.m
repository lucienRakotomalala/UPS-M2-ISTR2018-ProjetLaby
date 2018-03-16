clear 
Ms = 3;
n = 1;

%%
N = 2*Ms+1; % total size of maze

Visu = [9   6   23  6   23  6   10;
        5   1   15  2   15  0   7;
        26  13  17   13  18   13  24;
        5   0   15  0   15  0   7;
        26  13  19   13  20   13  24;
        5   0   15  0   15  3   7;
        12  8   25  8   25  8   11];

%% escape (out{2} : ghost [x y]) in Visu 2 = ghost

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
dir ='.\texture\';
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

%% toutes images correspondent bien => verif ok
% for i =1:23
%     figure(i)
%     imshow(text.img{i})
%     title(sprintf('image %d',i))
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
            fprintf('[%dx%d(%d)] ',xl,yl,Visu(i,j,a)+1);
                imgs(y:y+yl-1,x:x+xl-1,1,a) = text.img{Visu(i,j,a)+1}(:,:,1);% R
                %sm = sm +size(text.img{Visu(i,j,a)+1}(:,:,1),2)
            % application text canal G
                imgs(y:y+yl-1,x:x+xl-1,2,a) = text.img{Visu(i,j,a)+1}(:,:,2);% G
            % application text canal B
                imgs(y:y+yl-1,x:x+xl-1,3,a) = text.img{Visu(i,j,a)+1}(:,:,3);% B
            % calcul nouveau curseur
            x = x + xl;
            % y pareil pr la même ligne
           % fprintf('i(%d) j(%d) x(%d) y(%d) xl(%d) yl(%d)\n',i,j,x,y,xl,yl)
           figure(1)
           imshow(imgs) 
           figure(2)
                imagesc(text.img{Visu(i,j,a)+1})
            pause(.1)
        end
        fprintf('\n');
        x = 1;%?
        y = y + yl;
    end
    y = 1;% ?
end
