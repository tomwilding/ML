function filtered = filterOutliers(rental)
	% Remove data values over 8 standard deviations from the mean
	numberOfStds = 8;
	limit = mean(rental(:,1)) + numberOfStds * std(rental(:,1));
	filtered = rental(rental(:,1) < limit,:);
end