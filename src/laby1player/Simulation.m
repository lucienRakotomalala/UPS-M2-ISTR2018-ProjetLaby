%% Script to launch the labyrinth simulation.
% This script allows you to run a complete simulation of the labyrinth 
% without graphical interface and with picture and video generation. 
%
% It stops according to the stop conditions that are entered in the script.

% for a clean workspace, not obligatory
clear
close all
%% %%%%%%%%%%%%%%%%%%%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Number of iterations. (static dimension)
%
n= 100; 
%%
% states of laby (static dimension)
% where all the out{} genereted will be stored.
labyState=cell(n,9);
etat =0; % static dimension
etatS=0; % static dimension

%% 
% Initialization Of labyrinth
% Select if there is an escape or no 
%
noEscape = 0; 

%% Initial laby state
% Structure containing all element to initialize the labyrinth. 
% It is described as follows :
%%
% * "walls.V_i" for Vertical Walls, 
% * "walls.H_i" for Horizontal Walls, 
% * "pacman_i" for Pacman Initial position and 
% * "ghost_i" for ghost Initial Position. 
% (Dimensions can change)
 labyInit.wallsV_i =   [1 0 1 0;
                        1 1 0 1; 
                        0 0 0 0;
                        0 1 1 1; 
                        1 0 0 0];%  dimension can change
                    
 labyInit.wallsH_i =   [0 0 0 1 0;
                        0 1 0 1 0;
                        0 1 0 1 0;
                        0 1 0 0 1]; %  dimension can change
%    
%  labyInit.wallsV_i =   [1 1;
%              0 1; 
%              0 0]; %  dimension can change
%  labyInit.wallsH_i = [1 0 0; 
%                             1 0 0];  %  d

%% 
% size of lab (static dimension)
%
 Ms = max(size(labyInit.wallsH_i)); 
%%
% Pacman position (static dimension)
%
 labyInit.pacman_i = [2,	1];
%%
% Escape position (static dimension)
%
 labyInit.escape_i = {[5 5], 0};

%% Commands
%%
% Initial value of walls command
%
% =0 : begin with right move
%
% =1 : begin with up move
%
wallsInit.wallsCommand_i = 0;

%%
% Initial value of pacman command 
%(if command change, dimension can change, else not)
%
pacmanInit.pacmanCommand_i= zeros(1,5);
%%
% initial value of stop
%
stopInit.escape = 0;
stopInit.pacman = 0;
%% %%%%%%%%%%%%%%%%%%%%%%%%% MAIN SCRIPT %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% For count iteration of loop
%
 i = 1 ;     
%%
% For break condition
 SimulationStopped = 0; 
%%
% Creation of needed class
%
 wrapper = Wrapper(11, 9, labyInit, wallsInit, pacmanInit, stopInit);
 
%% 
% Connection of all the commands
%
 wrapper=wrapper.updateConnexion(1,1); % walls
 wrapper=wrapper.updateConnexion(3,1); % pacman
%%
% Empty in vector for the simulation
%
 in = zeros(1,11);
%%
% The first 'step' is the labyrinth at the begining
%
 labyState(1,:)=wrapper.get_out();
 i=i+1;

%%
% The loop will run until i>n or one stop condition stop the simulation
%
while (i<=n && ~SimulationStopped)
    wrapper = wrapper.orderer(in);
    labyState(i,:)= wrapper.get_out();
    stop=wrapper.get_stop();
    %%%%%%%%%%%%%% stop condition %%%%%%%%%%%%%%%%%%%%%%%    
     if (sum(stop)~=0)
         SimulationStopped = 1;
     end
     i = i + 1;
     %pause
    %%%%%%%%%%%%%%%%%%    
end
%% log message (terminal)

fprintf('End of simulation :\n');
if(i>n) % sim finish
    fprintf('\t The simulation was not stopped (%d steps)\n',n);
else %sim break
    fprintf('\t the simulation have been stopped at the %d step on %d\n',i,n);
    if(stop(1))
        fprintf('\t>Pacman escaped\n');
    end
    if(stop(3))
        fprintf('\t>Pacman trapped\n');
    end
end
    n = i-1; % new number of iteration;
%% Create picture for each iteration and Video in file data

CreatePituresAndVideo_textured(n,  labyInit.escape_i, labyState);
