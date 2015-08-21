function out = LapIter(BV)

w = 1;
[m,n] = size(BV);
Fnew = zeros(m,n);         % Initialize the updated angle field
Fold = BV;
Fupdate = zeros(m,n) + 1;
Fupdate(1,:) = 0;
Fupdate(end,:) = 0;
Fupdate(:,1) = 0;
Fupdate(:,end) = 0;

iter = 0;
maxiter = 1000;

tic
while iter<maxiter
    iter = iter+1;
    disp(iter)
    
    Lap = del2(Fold);
    Fnew = Fold + Fupdate .* (w .* Lap);
    Fold = Fnew;
    if mod(iter,100) ==0
        figure
        pcolor(Fnew)
    end
    
end
toc
out = Fnew;

figure
pcolor(Fnew)

end