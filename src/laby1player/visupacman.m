%% VISUALIZATION By S.Durola
clear all
close all

XY = [0 2 1 -1 -3 -3 -1 1 2 0;
      0 2 3 3 1 -1 -3 -3 -2 0];

figure(1);
axis([-4 4 -4 4]);
grid on
axis vis3d
hPacman = patch(XY(1,:),XY(2,:),[1 1 0]);

set(hPacman,'EdgeColor',[1 1 0]);

%%
n =100;
for k=0:n
    pause(1/n)
    angle = 2*pi/n*k;
    XY2 = XY;
    XY2(1,2) = XY2(1,2) + sin(k/(n/20));
    XY2(1,9) = XY2(1,9) + sin(k/(n/20));
    XY2(2,2) = XY2(2,2) - sin(k/(n/20));
    XY2(2,9) = XY2(2,9) + sin(k/(n/20));
    nexXY = [cos(angle) -sin(angle);sin(angle) cos(angle)]*XY2;
    %set(hPacman,'XData',XY(1,:)+k/100,'YData',XY(2,:)-k/100);
    set(hPacman,'XData',nexXY(1,:),'YData',nexXY(2,:));
    %set(hPacman,'XData',XY2(1,:),'YData',XY2(2,:));
end