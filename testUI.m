clear all
close all
h.fig = figure(1)
h.axe1 = axes
axis([0 5 0 5])
h.pacmanX = 1;
h.pacmanY = 2;
h.pacmanColor = 'r';

h.pacman = plot(h.pacmanX,h.pacmanY,'Color',h.pacmanColor,'Marker','*');

 e = 'pacman';
 h.(e) %  equivalent à h.pacman 
 
 
 %%
 a = magic(4)
 a(2,3)
 
 
 