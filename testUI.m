clear all
close all
h.fig = figure(1)
h.axe1 = axes
axis([0 5 0 5])
h.pacmanX = 1;
h.pacmanY = 2;
h.pacmanColor = 'r';

%h.pacman = plot(h.pacmanX,h.pacmanY,'Color',h.pacmanColor,'Marker','*');

%h.rect = rectangle('Position',[0 0 2 2]);
%%
size = 5;
 y = 0:size-1;
h.walls= [];

 for k = 1:size-1
    h.walls = [h.walls ,line([k k],[y' y'+1],'linewidth',2)]
 end