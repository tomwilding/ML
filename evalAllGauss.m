function v = evalAllGauss(w, c, r, lat, long)
	v = zeros(size(lat));
	for(i=1:length(w))
		for(j=1:length(w))
			v = v + w(i,j) * exp(-((((lat - c(i)).^2)/(2*r^2)) + (((long - c(j)).^2)/(2*r^2))));
		end
	end
end