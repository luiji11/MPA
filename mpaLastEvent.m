function event = mpaLastEvent(sig, j) 
% MPALAST EVENT event = mpaLastEvent(sig, i)
% j is the column or columnS to get

if find(sig == 0,1)-1 == 0
    event = zeros(1,numel(j));
else
    event = sig( find(sig == 0,1)-1, j );

end

