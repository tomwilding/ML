function params = LLgradAll(time, price, wCurr, sigma, delta)
	% Find grad with respect to each variable
	for (order=1 : length(wCurr))
    	grad(order) = LLAll(time, price, wCurr, sigma, order, delta/2) - LLAll(time, price, wCurr, sigma, order, -delta/2);
    end
    params.g = grad/delta;
    params.ll = LLAll(time, price, wCurr, sigma, order, delta/2);
end
