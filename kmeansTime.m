function [centresX, sdX, centresY, sdY, centresZ, sdZ] = kmeansTime(x ,y, z, clusters)
	% Initialse cluster centres and standard deviation randomly 
	centresX = rand(clusters,1);
	sdX = ones(clusters,1);
	centresY = rand(clusters,1);
	sdY = ones(clusters,1);
	centresZ = rand(clusters,1);
	sdZ = ones(clusters,1);
	% Loop threshold condition
	threshold = 0.5;
	dsquared = ones(size(centresX,1), size(x,1));
	clusterDistances = 0;
	clusterDistancesPrev = Inf; 

	while(clusterDistances ~= clusterDistancesPrev)
		clusterDistancesPrev = clusterDistances;
		for (i=1 : size(centresX,1))
			for (j=1: size(x,1))
				% Calculate the distance between the current cluster mean
				dsquared(i,j) = ((centresX(i) - x(j))^2 + (centresY(i) - y(j))^2 + (centresZ(i) - z(j))^2);
			end
		end
		[minValue, indicies] = min(dsquared);
		clusterDistances = sum(minValue);

		% Find values assigned to each cluster
		for c=1: clusters
			xsInCluster = x(indicies==c);
			ysInCluster = y(indicies==c);
			zsInCluster = z(indicies==c);
			centresX(c) = mean(xsInCluster);
			centresY(c) = mean(ysInCluster);
			centresZ(c) = mean(zsInCluster);
			sdX(c) = std(xsInCluster);
			sdY(c) = std(ysInCluster);
			sdZ(c) = std(zsInCluster);
		end
	end
end