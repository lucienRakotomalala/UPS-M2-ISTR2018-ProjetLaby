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
