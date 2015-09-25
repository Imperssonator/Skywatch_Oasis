XYZmat = cell2mat(XYZ(:,1:3));

[m,n] = size(XYZmat);

NN = zeros(1,3);

DM = ipdm(XYZmat);

count = 1;
for i = 1:m
    distances = DM(i,:);
    neighbors = find(distances<0.39)-1;
%     disp(neighbors)
%     disp(i-1)
    for j = 1:length(neighbors)
        if neighbors(j)>(i-1)
            NN(count,1) = i-1;              % Starting point of edge
            NN(count,2) = neighbors(j);     % Ending point of edge
            NN(count,3) = 0.1;              % Transfer integral of edge
            count = count+1;
        end
    end
end

[M,N] = size(NN);

C = mat2cell(NN,ones(M,1),ones(1,N));

edit P3HTfiber.edge
fileID = fopen('P3HTfiber.edge','w');

formatSpec = '%d %d %f\n';
[nrows,ncols] = size(C);
for row = 1:nrows
    fprintf(fileID,formatSpec,C{row,:});
end