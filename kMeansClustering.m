function [c,s] = kMeansClustering(data, k) % Prerequisite is that data provided is normalised between 0 and 1

% Number of dimensions 
n = size(data,2);

% Initialise cluster centres and standard deviations 
c = rand(k,n); s = zeros(k,n);

errPrev = Inf; err = 0;

maxIterations = 10000;

it = 0;

% Error is always reduced on every step, until we converge 
% and the error remains the same 
while ((err ~= errPrev) && (it < maxIterations))

% Calculate the distance from all data points to all cluster centres 
sqrDistances = 0; 
for dim = 1:n 
	sqrDistances = sqrDistances + bsxfun(@minus, c(:,dim), data(:,dim)').^2; end

% Assign data points to closest clusters 
[minValues, clusterIndexes] = min(sqrDistances, [], 1);

% Error is the sum of distances from a data point to it's assigned cluster centre 
errPrev = err; err = sum(minValues); for cluster = 1:k for dim = 1:n 
% Get all data points assigned to the current cluster 
dataInC = data(clusterIndexes == cluster,dim); 
% Move the cluster centre to the centre of gravity of the cluster 
c(cluster,dim) = mean(dataInC); 
% Set our standard deviation to the standard deviation of the cluster 
s(cluster,dim) = std(dataInC); end 
end

it = it + 1;

end

end