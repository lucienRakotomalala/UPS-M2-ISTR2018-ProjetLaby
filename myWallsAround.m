function wallsAround = myWallsAround(walls)
           wallsAround =  [ones(1,size(walls,2)+2);  [ones(size(walls,1),1) walls ones(size(walls,1),1)];  ...
                                ones(1,size(walls,2)+2)];
             
end
