function v = evalAllGaussTimeChunks(params, time, lat, long)
	numberOfChunks = size(params,2);
	chunkGap = range(time) / numberOfChunks;
	numberOfGaussians = size(params(1).w,1);
	minTime = min(time);

	% Initialise predictions as zeros
	v = zeros(size(lat));

	for (i=1:length(lat))
		% For each time input find time chunk and therefore regressor to evaluate with
		for(bin=1:numberOfChunks)
			minOfChunk = minTime + (bin-1)*chunkGap;
			maxOfChunk = minTime + bin*chunkGap;
			% If time is in chunk
			if ((ge(time(i),minOfChunk)) && (le(time(i),maxOfChunk)))
				% in this chunk
				chunk = bin;
				break;
			end
		end
		% Find params
		cx = params(chunk).c(:,1);
		cy = params(chunk).c(:,2);
		sdx = params(chunk).r(:,1);
		sdy = params(chunk).r(:,2);
		w = params(chunk).w;
		b = params(chunk).b;

		% Value of the gaussians at data point i using associated regressor
	    for (j=1:numberOfGaussians)
			v(i) = v(i) + w(j) * (b + exp(-((((lat(i) - cx(j))^2)/(2*sdx(j)^2)) + (((long(i) - cy(j))^2)/(2*sdy(j)^2)))));	    
		end
	end
	v = exp(v);
end