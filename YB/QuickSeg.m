function BW = QuickSeg(G)

E = edge(G,'canny');                % Apply a Canny edge finder - 1's at the edges, 0's elsewhere
Gd = double(G);                     % Turn the grey image into double prec.
Ed = double(E);                     % Turn the edge image into double prec.
V0 = Gd.*Ed;                        % Fill in the grey values of the edge pixels in a new image file
% IMS.Edge = E;                       

Vf = YBiter(V0);                    % Perform Yanowitz-Bruckstein surface interpolation to create threshold surface from edge gray values
% IMS.ThreshSurf = uint8(Vf);         % Save the threshold surface

BW = G>Vf; 

end