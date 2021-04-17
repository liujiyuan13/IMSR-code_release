function [X] = update_X(X, Im, Z)

V = length(X);
n = size(X{1}, 2);
 
B = eye(n) - Z - Z' + Z*Z';
for v=1:V
    Io{v} = setdiff([1:n], Im{v});
    X{v}(:,Im{v}) = -X{v}(:,Io{v})*B(Io{v},Im{v})/B(Im{v},Im{v});  
end

end

