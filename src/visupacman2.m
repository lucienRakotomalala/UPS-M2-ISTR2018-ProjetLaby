close all
clear 
%% test represent graph joueur
% creation
nbPts = 100;
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
    set(pacman,'XData',Xpts([0,Binf:Bsup,end-1])+ i*(xPos2-initXpos),'YData',Ypts + i*(yPos2-initYpos));
end

%%%%%%%%%%%%%%%% nonlinéar moving
%% 
close all 
clear
omega_n = 7;
xi = .7;
K=1;
ft = K*tf([omega_n^2],[1 2*xi*omega_n omega_n^2]);
%step(ft)

syms p;

F=K*(omega_n^2)/(1*p^2+ 2*xi*omega_n*p+ omega_n^2);
f = ilaplace(F,p);


%t = 0 : .01 : 1;
t = [zeros(1,50) , ones(1,1000)];
g=zeros(size(t));

for i = 1:length(t)
    g(i)=( 70*51^(1/2) * exp(-(49*t(i))/10) * sin((7*51^(1/2)*t(i))/10)  )/51;
end
abs = 1:length(t);
plot(abs,t,abs,g)

%%
close all; clear
t =-0.01:.001:5;
%f  = exp(t);
f1 = exp(-t);
f2 = 2*exp(-t);
f3 = exp(-2*t);
f4 = exp(-t+2);
f5 = exp(-t+3);
f6 = 1./(3*exp(-t)+1);
figure(1)
plot(...%t,f,...
    t,f1,...
    t,f2,...
    t,f3,...
    t,f4,...
    t,f5,...
    t,f6);
legend( '-t', '2*(-t)', '-2*t', '-t+2','-t+3','1/e+1')
grid on
%%
close all; clear
hold on 

%% smooth movement for parman and ghost
t =0:.01:1;
om = 72.89105;
cv = -11.27357;
f6 = ((om+1)./(om*exp(cv*t)+1)-1)/om;
figure(1)
plot(t,f6);
grid on
%% Ghost
clear ;close
nbPts = 200; % Definition of object
%%%%%

h.ghostPositionInit  = [2 1];
h.ghostColor         = [0.83 .33 0.1] ; % strange orange

circle = 1/4;
hold on;

pos = linspace(0,pi,floor(nbPts/2));

% Ghost cape
x_v = linspace(h.ghostPositionInit(1)-.5 - circle, h.ghostPositionInit(1)-.5 + circle, ceil(nbPts/2));
y_v = h.ghostPositionInit(2)-.5-circle + circle*.25*sin(linspace(pi, 8*pi ,length(x_v)));

% All point
x = [h.ghostPositionInit(1)-.5 [circle*cos(pos)+ h.ghostPositionInit(1)-.5] ... Head of ghost
    h.ghostPositionInit(1)-.5 h.ghostPositionInit(1)-.5-circle ... Made a line which separate the ghost in two parts
    h.ghostPositionInit(1)-.5-circle ...
    x_v ...     Cape
    h.ghostPositionInit(1)-.5+circle h.ghostPositionInit(1)-.5+circle];

y = [h.ghostPositionInit(2)-.5 [circle*sin(pos)+h.ghostPositionInit(2)-.5] ...
    h.ghostPositionInit(2)-.5 h.ghostPositionInit(2)-.5...
    h.ghostPositionInit(2)-.5-circle ...
    y_v ...
    h.ghostPositionInit(2)-.5-circle h.ghostPositionInit(2)-.5];
%x = [0: ,x]
%y = [ ,y]
%axes(h.axes1);
h.ghost = patch(x,y,h.ghostColor);
axis([0 5 0 5])
axis square
grid on 
hold off;
%%
clear
close
nbPts = 50;
ang = linspace( 0 , 2*pi , nbPts );

x = [ cos(ang) , .3+.35*cos(ang) , .4*cos(ang) ];
y = [ sin(ang) , .3+.2*sin(ang)  , .4*sin(ang) ];

h = patch(x,y,'b')
axis square