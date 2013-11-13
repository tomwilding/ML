function v = evalAllGauss(w, b, c, r, lat, long)
	cx = c(:,1);
	cy = c(:,2);
	sdx = r(:,1);
	sdy = r(:,2);

	v = zeros(size(lat));
	for (i=1:length(lat))
        for (j=1:size(w,1))
            % Value of the gaussians at data point i
            v(i) = v(i) + w(j) * (b + exp(-((((lat(i) - cx(j))^2)/(2*sdx(j)^2)) + (((long(i) - cy(j))^2)/(2*sdy(j)^2)))));
        end
	end
	v = exp(v);
end