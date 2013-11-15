function v = evalAllGaussTime(w, b, c, r, time, lat, long)
	cx = c(:,1);
	cy = c(:,2);
	cz = c(:,3);
	sdx = r(:,1);
	sdy = r(:,2);
	sdz = r(:,3);

	v = zeros(size(lat));
	for (i=1:length(lat))
        for (j=1:size(w,1))
            % Value of the gaussians at data point i
            v(i) = v(i) + w(j) * (b + exp(-((((lat(i) - cx(j))^2)/(2*sdx(j)^2)) + (((long(i) - cy(j))^2)/(2*sdy(j)^2)) + (((time(i) - cz(j))^2)/(2*sdz(j)^2)))));
        end
	end
	v = exp(v);
end