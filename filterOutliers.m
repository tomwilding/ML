function filtered = filterOutliers(rental)
	numberOfStds = 10;
	limit = mean(rental(:,1)) + numberOfStds * std(rental(:,1));
	filtered = rental(rental(:,1) < limit,:);
end