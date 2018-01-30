close all
clear 
%% test represent graph joueur
% creation
nbPts = 32;
rayon = 1/3;
xPos = 1;
yPos = 2;
pos = pi/6:(5/3*pi)/(nbPts-1) :11/6*pi;
x = [0,rayon*cos(pos)]     + xPos-.5;
y = [0,rayon*sin(pos)]   + yPos-.5;
clr = 'b';
figure(1)
%axis([0 5 0 5])
axis square
grid on
%axis vis3d
pacman = patch(x,y,clr);


%% rpz g
xPos2 = 2;
yPos2 = 2;
%
Xpts = get(pacman,'XData');
initXpos = Xpts(1)+.5;

Ypts = get(pacman,'YData');
initYpos = Ypts(1)+.5;
%
nMvs = 10;
for i = linspace(0,1,nMvs)
    pause(1/nMvs);
    set(pacman,'XData',Xpts+ i*(xPos2-initXpos),'YData',Ypts + i*(yPos2-initYpos));
end
