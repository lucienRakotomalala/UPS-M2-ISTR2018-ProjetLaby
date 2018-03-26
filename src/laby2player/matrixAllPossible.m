tic
Binary=[ 0 0 0 0; 0 0 0 1; 0 0 1 0; 0 0 1 1; 0 1 0 0; 0 1 0 1; 0 1 1 0; 0 1 1 1; 1 0 0 0; 1 0 0 1; 1 0 1 0; 1 0 1 1; 1 1 0 0; 1 1 0 1; 1 1 1 0; 1 1 1 1];
Matrice_V = zeros(5,4);
Matrice_H = zeros(4,5);
nombre=1;

for i=1:16
    Matrice_V(1,:) = Binary(i,:);
    Matrice_H(:,1) = Binary(i,:)';
    for(j=1:16)
        Matrice_V(2,:) = Binary(j,:);
        Matrice_H(:,2) = Binary(j,:)';
        for (k=1:16)
            Matrice_V(3,:) = Binary(k,:);
            Matrice_H(:,3) = Binary(k,:)';
            for (l=1:16)
                Matrice_V(4,:) = Binary(l,:);
                Matrice_H(:,4) = Binary(1,:)';
                for(m=1:16)
                    Matrice_V(5,:) = Binary(m,:);
                    Matrice_H(:,5) = Binary(m,:)';
                    Vwalls{nombre}=Matrice_V;
                    Hwalls{nombre}=Matrice_H;
                    nombre=nombre+1;
                end
            end

        end
 
    end
  
end

save('./allVerticalMatrix','Vwalls');
save('./allHorizontalMatrix','Hwalls');
toc