function c = kmeans(x ,y, clusters)
	x=x';
	y=y';
	centresX = rand(clusters,1)
	centresY = rand(clusters,1)
	threshold = 0.5;
	clusterDistances = Inf;

	while(clusterDistances < threshold)
		
		clusterDistances = bsxfun(@minus, centresX, x).^2 + bsxfun(@minus, centresY, y).^2;
		[minValue, indicies] = min(clusterDistances);

		% Find values assigned to each cluster
		for c=1: clusters
			xsInCluster = x(indicies==c)
			ysInCluster = y(indicies==c)
			centresX(c) = mean(sxInCluster)
			centresY(c) = mean(ysInCluster)
		end

	end
	c = [centresX, centresY];
end