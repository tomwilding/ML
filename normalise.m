function x = normalise(x)
    m = min(x);
    r = range(x);
    for (i=1 : size(x,1))
       x(i) = ((x(i) - m) / r);
    end
end