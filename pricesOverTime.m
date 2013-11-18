% QA
clearvars *
load('rental.mat')

% Sort rental by time and filter outliers
rentalByTime = sortrows(rental,2);
rentalByTimeFiltered = filterOutliers(rentalByTime);

% Prices over time
time = rentalByTimeFiltered(:,2);
price = rentalByTimeFiltered(:,1);
% plot(time, price, '.');
% datetick('x', 12);

% MLE regression
% Change order to approximate 0th or 1st order ploynomial
order = 1;
params = MLEGradDescAll(time, price, order);
loglik = params.ll
fit = polyEval(params.w, time);

p1 = plot(time, price, '.k', time, fit, 'LineWidth', 2);
set(p1, 'Markersize',6);
datetick('x', 12);
title('Polynomial 1st Order Regression for Rental Prices over Time','FontSize',16)
xlabel('Time','FontSize',14);
ylabel('Price [£]','FontSize',14);
grid on;