function v = evalAllGaussTime(w, b, c, r, time, long, lat)
	ct = c(:,1);
	clong = c(:,2);
	clat = c(:,3);
	sdt = r(:,1);
	sdlong = r(:,2);
	sdlat = r(:,3);


	v = zeros(size(lat));
	for (i=1:length(lat))
        for (j=1:size(w,1))
            % Value of the gaussians at data point i
            v(i) = v(i) + w(j) * (b + exp(-((((time(i) - ct(j))^2)/(2*sdt(j)^2)) ...
            							+ (((long(i) - clong(j))^2)/(2*sdlong(j)^2)) ...
										+ (((time(i) - clat(j))^2)/(2*sdlat(j)^2)))));
        end
	end
	v = exp(v);
end