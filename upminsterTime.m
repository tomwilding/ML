
function u = upminsterTime(trainIn, params)
	load('rental.mat')
	% rentalFiltered = filterOutliers(rental);

	% trainIn = [rentalFiltered(:,3) rentalFiltered(:,4)];
	% trainOut = rentalFiltered(:,1);

	% % Combine input
	% combinedData = [trainOut, trainIn];
	% % Re-order data randomly
	% randomOrderData = combinedData(randperm(size(combinedData,1)),:);

	% % Change the mod n to segment different proportions of data
	% n = 4;
	% clearvars testIn
	% testIndicies = mod(1:size(randomOrderData,1), n)==1;
	% trainIndicies = ~testIndicies;

	% clearvars trainIn
	% trainIn(:,1) = randomOrderData(trainIndicies,2);
	% trainIn(:,2) = randomOrderData(trainIndicies,3);
	% trainOut = randomOrderData(trainIndicies,1);

	% % Train reg
	% params = trainRegressorTime(trainIn, trainOut);

	% Pass all data train on plus upminster
	minTime = min(rental(:,2))
	maxTime = max(rental(:,2))
	upminsterAtTime = [minTime, tube.location(264,:)];
	trainIn = [trainIn;upminsterAtTime];

	upminsterPred = testRegressorTime(trainIn, params);
	u = upminsterPred(size(upminsterPred,1));
end
