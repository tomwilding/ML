clearvars *
load('rental.mat')

rentalFiltered = filterOutliers(rental);
% Prices against time plot on all data
allIn = [rentalFiltered(:,3),rentalFiltered(:,4)];
trainOut = rentalFiltered(:,1);
params = trainRegressor(allIn, trainOut);
%Calculate value at this point
gaussEval = testRegressor(allIn, params);
plot3(rentalFiltered(:,3),rentalFiltered(:,4),gaussEval,'.r');
hold on
plot3(rentalFiltered(:,3),rentalFiltered(:,4),rentalFiltered(:,1), '.');
title('Predicted and Actual Rental Prices','FontSize',16)
xlabel('Latitude [Deg]','FontSize',14);
% xlim([-0.8,0.4]);
% ylim([51.1,51.9]);
ylabel('Longitude [Deg]','FontSize',14);
zlabel('Price [£]','FontSize',14);
grid on;