XYZ = {};

count = 1;
for j = 1:100
    for i = 1:25
        if j == 1
            XYZ(count,:) = {0 (i-1)*0.38 0 'g' 0};
        elseif j == 100
            XYZ(count,:) = {0 (i-1)*0.38 (j-1)*0.38 'c' 0};
        else
            XYZ(count,:) = {0 (i-1)*0.38 (j-1)*0.38 '-' 0};
        end
        count = count+1;
    end
end

edit P3HTfiber.xyz
fileID = fopen('P3HTfiber.xyz','w');

formatSpec = '%f %f %f %s %f\n';
[nrows,ncols] = size(XYZ);
for row = 1:nrows
    fprintf(fileID,formatSpec,XYZ{row,:});
end