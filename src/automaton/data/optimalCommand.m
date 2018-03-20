function optimalCommand( transitionsMatrix, s_init, s_final )
U   = transitionsMatrix{1}; %cellule 1
      transitionsMatrix{1,2}='U';
D   = transitionsMatrix{2}; %cellule 2
      transitionsMatrix{2,2}='D';
L   = transitionsMatrix{3}; %cellule 3
      transitionsMatrix{3,2}='L';
R   = transitionsMatrix{4}; %cellule 4
      transitionsMatrix{4,2}='R';
nU  = transitionsMatrix{5};%cellule 5
      transitionsMatrix{5,2}='nU';
nD  = transitionsMatrix{6};%cellule 6
      transitionsMatrix{6,2}='nD';
nL  = transitionsMatrix{7};%cellule 7
      transitionsMatrix{7,2}='nL';
nR  = transitionsMatrix{8};%cellule 8
      transitionsMatrix{8,2}='nR';
wR  = transitionsMatrix{9};%cellule 9
      transitionsMatrix{9,2}='wR';
wD  = transitionsMatrix{10};%cellule 10
      transitionsMatrix{10,2}='wD';
esc= transitionsMatrix{11};%cellule 11
      transitionsMatrix{11,2}='escp';
n = length(U);  % Nbr States
M=[U D L R nU nD nL nR wR wD esc];
[s,t]=find(M~=0);
for k=1:length(t)
    if(t(k)<=4)
         w(k) = 1 ;
    else w(k) = 0;
    end
end
%w=t<=4*n
t=mod(t-1,n)+1;
G = digraph(s,t,w);
plot(G,'EdgeLabel',G.Edges.Weight)

path = shortestpath(G,s_init,s_final,'Method','positive'); %find the shortestpath giving by the states
%%
TransitionsTree = cell(n,n);
for l=1:length(transitionsMatrix)
  [r, c]=find(transitionsMatrix{l,1}==1) ;
    for m=1:length(r)
        TransitionsTree{r(m), c(m)}= transitionsMatrix{l,2} ;
    end
end

coup=1;
for t=1:(length(path)-1)
    tree{t}= TransitionsTree{path(t), path(t+1)};
    if( strcmp(tree{t},'L') || strcmp(tree{t},'D') || strcmp(tree{t},'U') || strcmp(tree{t},'R'))
    command{coup}= tree{t};
    coup=coup+1;
    end
end
disp(sprintf('For the initial state %d and the final state %d :' , s_init  ,s_final))
disp(strcat('  - the fatest sequence is :',strcat(sprintf(' %s ',tree{1,:}))))
disp(strcat('  - the fatest command is :',strcat(sprintf(' %s ',command{1,:}))))
disp(sprintf('\n'))
end

