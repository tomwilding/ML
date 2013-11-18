function p = polyEval(w, x)
	% Normalise input
	x = normalise(x);
	% Evaluate at data at current weights
	for (i=1 : length(x))
		val = 0;
		for (o=1: length(w))
			% Evaluate polynomial at this point
			val = val + w(o)*(x(i)^(o-1));
		end
		p(i) = val;
 	end

end