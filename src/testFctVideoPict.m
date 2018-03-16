clear
% frame test 
NbCases = 5;
res = 100;
x_max = (NbCases+2 +NbCases-1)/2))*res;
%% grille carrée case 100x100
figure(1)
hold on
plot([0 0], [0 1100])
plot([0 1100], [0 0])


plot([0 1100], [1100 1100])
plot([1100 1100], [0 1100])

%
i = 0;
a = -1;
while i <1000
        if (mod(a,2)~=0)&& (a>0) && (a<1000) %100x100
            i = i + 50;
        
        else % sinon 50x50
            i = i + 100;            
        end
        plot([i i],[0 1100]);
        plot([0 1100],[i i])
        a
        a = a + 1;
end
hold off

axis([0 1100 0 1100])
axis square

%% grille murs 50x100 et case 100x100
figure(1)
hold on
a = 2;
for i = 0  :11
        if i ==0
        plot([i i],[0 1100]);
        plot([0 1100],[i i])
        end
end
hold off

axis([0 1100 0 1100])
axis square

