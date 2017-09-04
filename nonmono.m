function idx_out = nonmono(vec,symbol)

index=1:length(vec);
idx_out=1:length(vec);
idx = NaN;
vec = reshape(vec,length(vec),1);

if strcmp(symbol,'>') % trova i punti in cui non è crescente
    
    
    while ~isempty(idx)
        idx = find(vec>=[vec(2:end); vec(end)+1]);
        index(idx)=[];
        vec(idx)=[];
    end
    
    
elseif strcmp(symbol,'<')
    
    while ~isempty(idx)
        idx = find(vec<=[vec(2:end); vec(end)-1]);
        index(idx)=[];
        vec(idx)=[];
    end

else
    disp('??? Bisogna specificare se crescente (''>'') o decrescente (''<'')')
end

idx_out(index)=[];
idx_out=idx_out';