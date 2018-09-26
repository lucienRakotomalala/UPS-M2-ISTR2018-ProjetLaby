%> @filename wallsBorder.m

% ================================================================
%> @brief Function to add the outlines of the labyrinth to a wall matrix.

% ================================================================
%> @brief Function.
%> @param walls Wall's matrix.
%> @return walls Wall's matrix with border.
% ================================================================
function walls = wallsBorder(walls)
           walls =  [ones(1,size(walls,2)+2);  [ones(size(walls,1),1) walls ones(size(walls,1),1)];  ...
                                ones(1,size(walls,2)+2)];
             
end
