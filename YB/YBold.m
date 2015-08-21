function Vf = YBold(V0)

%YBiter Yanowitz/Bruckstein surface interpolation

w = 1.5;
maxiter = 1;
[m,n] = size(V0);

Vnew = zeros(m,n);
Vold = V0;

L = [0  1 0; ...  % Laplacian for central pixels
     1 -4 1; ...
     0  1 0];
 
L_E = [0  1 0; ... % for edge pixels
       1 -3 1; ...
       0  1 0];
   
L_C = [0  1 0; ... % for corner pixels
       1 -2 1; ...
       0  1 0];

iter = 0;
while iter<maxiter
    iter = iter+1;
    disp(iter)
    
    % Do middle pixels first
    for i = 2:m-1
        for j = 2:n-1
            Vnew(i,j) = Vold(i,j) + ...
                        w * LAP(Vold,L,i,j) / 4;
        end
    end
    
    % Do corners
    for i = [1 m]
        for j = [1 n]
            Vnew(i,j) = Vold(i,j) + ...
                        w * LAP_C(Vold,L_C,i,j) / 4;
        end
    end
    
    % Do edges
    for i = 2:m-1
        for j = [1 n]
            Vnew(i,j) = Vold(i,j) + ...
                        w * LAP_E(Vold,L_E,i,j) / 4;
        end
    end
    
    for i = [1 m]
        for j = 2:n-1
        Vnew(i,j) = Vold(i,j) + ...
                        w * LAP_E(Vold,L_E,i,j) / 4;
        end
    end
    
    Vold = Vnew;
end

Vf = Vnew;

end