function o = ownRent(trainIn, params)
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
	% params = trainRegressor(trainIn, trainOut);

	% Pass all data train on plus upminster
	ownLocation = [51.4861229, -0.2089814999]
	trainIn = [trainIn;ownLocation];

	ownPred = testRegressor(trainIn, params);
	o = ownPred(size(ownPred,1));
end
