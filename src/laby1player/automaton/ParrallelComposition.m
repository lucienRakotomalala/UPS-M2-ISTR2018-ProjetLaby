function [A] = ParrallelComposition(A1, A2)
% ParrallelComposition 
%   This function returns the parrallel composition of 2 Automata A1 and
%   A2.
%   Input       : A1 and A2 are a struct which contain :
%                    field 1 --> langage
%                    field 2 --> vectors
%% Shielding Inputs  
    if ~isa(A1, 'AutomateGraph')
        error('Input A1 must be an object from class AutomateGraph')
    end
    if ~isa(A2, 'AutomateGraph')
        error('Input A2 must be an object from class AutomateGraph')
    end

%% Creation Final Automata
    A = AutomateGraph();
%% Association of langage
    A.langage = union(A1.langage, A2.langage);
%% Establish Matrix
    if ~isa(A1.matrixTrans, 'struct')
        A1 = A1.vector2matrices();
    end
    if ~isa(A2.matrixTrans, 'struct') 
       A2 = A2.vector2matrices();
    end
%% Establish vectors    
    %   If L(A1 U A2)(i) is contain in L(A1)
    %       If L(A1 U A2)(i) is contain in L(A2)
    %           kron(v1, v2)
    %       Else
    %           kron(v1, 1)
    %   Else
    %       kron(1, v2)
    for i = 1:length(A.langage)
        L_A1member = find(ismember(A1.langage, A.langage(i))==1) ;
        if ~isempty(L_A1member)  % if L(A)(i) is in L(A1)
            L_A2member = find(ismember(A2.langage, A1.langage(L_A1member))==1);
            if ~isempty(L_A2member) % if L(A2)(i) is in L(A1) recognize in L(A1)
                A.matrixTrans(end+1).Name = A1.langage(L_A1member);
                A.matrixTrans(end).matrice = kron(A1.matrixTrans(L_A1member).matrice, A2.matrixTrans(L_A2member).matrice);
            else
                A.matrixTrans(end+1).Name = A1.langage(L_A1member);
                A.matrixTrans(end).matrice = kron(A1.matrixTrans(L_A1member).matrice, eye(length(A2.state)));
            end
        else
            L_A2member = find(ismember(A2.langage, A.langage(i))==1);
            A.matrixTrans(end+1).Name = A2.langage(L_A2member);
            A.matrixTrans(end).matrice = kron(eye(length(A1.state)), A2.matrixTrans(L_A2member).matrice);
        end
    end
	
%% Association of state Name, Initial and Marked Information
	if ~(isa(A1.state,'struct')*isa(A2.state,'struct'))
		disp('No State Information can be add because the Inputs don"t have state struct')
	else
		for i = 1:length(A1.state)
			for j = 1:length(A2.state)
				% A.state(j + (i-1)*length(A2.state)).Name = A1.state(i).Name * A2.state(j).Name;
				A.state(j + (i-1)*length(A2.state)).Initial = A1.state(i).Initial * A2.state(j).Initial;
				A.state(j + (i-1)*length(A2.state)).Marked = A1.state(i).Marked * A2.state(j).Marked;
			end
		end 
    end
%% Convert to vector
    
    A = A.matrices2vector();
    
%% Delete matrice
    %A.matrixTrans = [];
end

