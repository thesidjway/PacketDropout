function [isSmaller] = compare(int1, int2)
signal1 = de2bi(int1);
signal2 = de2bi(int2);

if size(signal1,2) ~= size(signal2,2)
    if size(signal1,2) < size(signal2,2)
        for i = 1:(size(signal2,2) - size(signal1,2))
            signal1 = [0 signal1];
        end
    else
        for i = 1:(size(signal1,2) - size(signal2,2))
            signal2 = [0 signal2];
        end
    end
end

signal1;
signal2;

if signal1 == signal2
    isSmaller = true;
else
    for i=1:size(signal1, 2)
        if signal1(i) == 1
            if signal2(i) == 0
                isSmaller = false;
                return
            else
                continue
            end
        else
            continue
        end
    end
    isSmaller = true;
    return
end
end