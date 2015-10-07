function [] = Run2DOrder(Directory)

for i = 33:size(Directory,1)
    Order2D(Directory{i,2});
end

end