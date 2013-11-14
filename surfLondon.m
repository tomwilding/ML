clearvars *
load('rental.mat')

rentalFiltered = filterOutliers(rental);

trainIn = [rentalFiltered(:,3) rentalFiltered(:,4)];
trainOut = rentalFiltered(:,1);

% Combine input
combinedData = [trainOut, trainIn];
% Re-order data randomly
randomOrderData = combinedData(randperm(size(combinedData,1)),:);

% Change the mod n to segment different proportions of data
n = 4;
testIndicies = mod(1:size(randomOrderData,1), n)==1;
trainIndicies = ~testIndicies;

testIn(:,1) = randomOrderData(testIndicies,2);
testIn(:,2) = randomOrderData(testIndicies,3);

clearvars trainIn
trainIn(:,1) = randomOrderData(trainIndicies,2);
trainIn(:,2) = randomOrderData(trainIndicies,3);
trainOut = randomOrderData(trainIndicies,1);

% Train reg
params = trainRegressor(trainIn, trainOut);

%test regressor over range of long and lat coordinates
long = normalise(trainIn(:,1));
lat = normalise(trainIn(:,2));
longRangeStep = range(long) / 100;
latRangeStep = range(lat) / 100;
longRange = (min(long):longRangeStep:max(long));
latRange = (min(lat):latRangeStep:max(lat));

% size(testIn)
% gaussEval = testRegressor(testIn, params);
% plot3(testIn(:,1),testIn(:,2),gaussEval, '.r');
% 
[X,Y] = meshgrid(longRange, latRange);

for (i=1: size(X,1))
	for (j=1: size(Y,1))
		%Calculate value at this point
		doubleGaussEval(i,j) = testRegressor([X(i,j),Y(i,j)], params);
	end
end