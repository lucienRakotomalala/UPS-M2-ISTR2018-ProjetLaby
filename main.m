clear 


%% Récupération matrice murs

% init
n=10;% nb d'évolution
Ms = 5;
laby = ModelLaby();
Mverti = zeros(Ms,Ms-1,n);
Mhoriz = zeros(Ms-1,Ms,n);
ind_in = 0;
in = zeros(1,2); %2 : down ; 3 : right

% loop
for i = 1:n 
    % def in
    ind_in = (mod(i,2)==0)*1 + (mod(i,2)~=0)*2 ;     
    in(ind_in)=1;
    % f m g lab
    nextS = laby.f([ 0, in, zeros(1,8)]);
    laby.m(nextS,0);
    out = laby.g(); % 3 : Mvert ; 4 : Mhoriz
    Mverti(:,:,i) = out{3};
    Mhoriz(:,:,i) = out{4} ;
    in = zeros(1,2);
end

%% aff

%%%%%%%%%%%
% % % % % %
%%%%%%%%%%%
% % % % % %
%%%%%%%%%%%
% % % % % %
%%%%%%%%%%%
% % % % % %
%%%%%%%%%%%
% % % % % %
%%%%%%%%%%%
N = 2*Ms+1; % taille tab total
Aff = zeros(N,N,n)
%%
Aff([1 N],:,:)=1; % bords verticaux

Aff(:,[1 N],:)=1; % bords horizontaux
 %% Remplissage des intersections de murs
i = find((1:N).*mod((1:N),2));
Aff(i,i,:)=1;
%% 
for i = 1:n
    %vert
    [ymv, xmv]=find(Mverti(:,:,i));
    yav = ymv.*2;
    xav = xmv.*2+1;
    %hor
    [ymh, xmh]=find(Mhoriz(:,:,i));
    xah = xmh.*2;
    yah = ymh.*2+1;

 for ee = 1:max(size(yav))
     Aff(yav(ee),xav(ee),i) = 1;
 end
  for ee = 1:max(size(yah))
      Aff(yah(ee),xah(ee),i) = 1;
  end
end

%% rendu 
%figure(1)

%sprintf('(%d,%d)=>(%d,%d)\n',ymv,xmv,yav,xav)
name = strcat('./CollectedData/', datestr(now,'yyyy-mm-dd_HH-MM'));
save(name,'Aff');
