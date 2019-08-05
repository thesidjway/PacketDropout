k= 1;
num_allowed = [];
for n=1:1:12
    disp('Calculating for n=')
    disp(n)
    a = [];
    x=de2bi(0:(2^n)-1);
    for i=2^n:-1:1
        for j=1:1:n-k
            if x(i,(j:j+k))==zeros(1,k+1)
                x(i,:)=[];
                a= sortrows(x);
            end
        end
    end %final answer stored in a
    num_allowed = [num_allowed size(a,1)];
end