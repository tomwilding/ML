function lli = LLAll(time, price, wCurr, sigma, order, delta)
    wCurr(order) = wCurr(order) + delta;
		lli = 0;
	    for (i=1 : length(time))
	    	v = 0;
    		for (j=1 : length(wCurr))
        		v = v + (time(i)^(j-1)) * wCurr(j);
       		end
	       	lli = lli + (log(1/sqrt(2*pi*(sigma^2))) - (((price(i) - v)^2)/(2*sigma^2)));
	    end
end