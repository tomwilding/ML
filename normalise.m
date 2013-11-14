function x = normalise(x)
    m = min(x);
    r = range(x);
    if (size(x,1) > 1)
	    for (i=1 : size(x,1))
	       x(i) = ((x(i) - m) / r); 
	    end
	end
end