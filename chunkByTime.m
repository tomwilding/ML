function rmse = chunkByTime()
	clearvars *
	load('rental.mat')
	rentalFiltered = filterOutliers(rental);
	allIn = [rentalFiltered(:,2), rentalFiltered(:,3),rentalFiltered(:,4), rentalFiltered(:,1)];
	allInByTime = sortrows(allIn,1);
	numChunks = 4;
	chunkSize = floor(size(allInByTime,1) / numChunks);

	for(i=1:numChunks)
		trainInTime1 = allInByTime(((i-1)*chunkSize) + 1 : i*chunkSize, :);
		rms(i) = crossValidation(trainInTime1(:,(2:3)), trainInTime1(:,4), 4);
	end
	rmse = mean(rms);
end 