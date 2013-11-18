function x = normalise(x)
	% Normalise input vector x between 0 and 1
    m = min(x);
    r = range(x);
    for (i=1 : size(x,1))
       x(i) = ((x(i) - m) / r);
    end
end