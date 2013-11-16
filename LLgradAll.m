function grad = LLgradAll(time, price, wCurr, delta)
	% Find grad with respect to each variable
	for (order=1 : length(wCurr))
    	grad(order) = LLAll(time, price, wCurr, order, delta/2) - LLAll(time, price, wCurr, order, -delta/2);
    end
    grad = grad/delta;
end
