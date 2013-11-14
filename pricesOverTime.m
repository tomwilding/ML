clearvars *
load('rental.mat')

rentalByTime = sortrows(rental,2);

rentalByTimeFiltered = filterOutliers(rentalByTime);
rentalFiltered = filterOutliers(rental);

time = rentalByTimeFiltered(:,2);
price = rentalByTimeFiltered(:,1);
% plot(time, price, '.');
% datetick('x', 12);

% Q1
% m = leastSquareFit(price, time, 1),
% %w = MLEGradDescAll(time, price);
% %w = MLEGradDescAll(time, price, 1);
% fit = polyEval(m, time);

% p1 = plot(time, price, '.k', time, fit, 'LineWidth', 2);
% set(p1, 'Markersize',6);
% datetick('x', 12);
% title('Polynomial 1st Order Regression for Rental Prices over Time','FontSize',16)
% xlabel('Time','FontSize',14);
% ylabel('$Price [£]','FontSize',14);
% grid on;
% Price against position for initial time period
%rentalT1 = rentalsWithoutOutliers(rentalsWithoutOutliers(:,2) <= 7.3521e+05, :);
% Split data into time samples
% samplesByTime = sampleOverTime(rentalsWithoutOutliers);

% Q2
% trainIn = [rentalFiltered(:,3) rentalFiltered(:,4)];
% trainOut = rentalFiltered(:,1);
% rms = crossValidation(trainIn, trainOut, 4)
% params = trainRegressor(trainIn, trainOut);


% Q2
trainIn = [rentalFiltered(:,2) rentalFiltered(:,4), rentalFiltered(:,3)];
trainOut = rentalFiltered(:,1);
rms = crossValidationTime(trainIn, trainOut, 4)

% plot3(trainIn(:,1),trainIn(:,2),trainOut,'.k');
% title('Rental Price against Location','FontSize',16)
% xlabel('Lattitude [Deg]','FontSize',14);
% ylabel('Longitude [Deg]','FontSize',14);
% zlabel('Price[£]','FontSize',14);
% grid on;

% hold on

% nlat = normalise(rentalFiltered(:,3));
% nlong = normalise(rentalFiltered(:,4));
% %Calculate value at this point
% gaussEval = evalAllGauss(params.w, params.c, params.r, nlat, nlong);
% plot3(trainIn(:,1),trainIn(:,2),gaussEval, '.r');
% gaussEval = testRegressor(trainIn, params);
% plot3(trainIn(:,1),trainIn(:,2),gaussEval, '.r');
% params = trainRegressor2(trainIn, trainOut);
% MU1 = params(1)
% MU2 = params(2)
% SD1 = params(3)
% SD2 = params(4)
% A = params(5)



% for (i=1: length(nlat))
% 	%Calculate value at this point
% 	doubleGaussEval(i) = A * exp(-( ((nlat(i)-MU1)^2/(2*(SD1^2))) + ((nlong(i)-MU2)^2/(2*(SD2^2))) ));
% end
% plot3(nlat,nlong,doubleGaussEval, '.');

% X = [0:0.01:1];
% Y = [0:0.01:1];
% for (i=1: length(X))
% 	for (j=1: length(Y))
% 		%Calculate value at this point
% 		doubleGaussEval(i,j) = exp(-( ((X(i)-0.5)^2/(2*(std(X)^2))) + ((Y(j)-0.5)^2/(2*(std(Y)^2))) ));
% 	end
% end

% surf(X,Y,doubleGaussEval)


% C = [0.5,0.5];
% R = 10;
% % Estimated value for all i,j gaussians
% X = [0:0.1:1];
% Y = [0:0.1:1];
% pred = zeros(1)
% for (x=1:length(X))
% 	for (y=1:length(Y))
% 		v = 0;
% 		for (i=1 : length(params))
% 			for (j=1 : length(params))
% 		    	v = v + params(i,j) * exp(-(((x + C(i,1))^2) + (y + C(i,2))^2)/2*R);
% 			end
% 		end
% 		pred(x,y) = v;
% 	end
% end

% surf(X,Y,pred);

% Single gauss
% m = mean(trainIn(:,1));
% s = std(trainIn(:,1));
% for (i=1 : length(trainIn(:,1)))
% 	G(i) = singleGauss(trainIn(i,1), m, s);
% end
%plot(trainIn(:,1), G, '.')

% Plot GaussComb for lat and long
% Gauss evaluated at all x and y

% lat = normalise(rental(:,3));
% long = normalise(rental(:,4));
% mx = mean(lat);
% my = mean(long);
% sdx = std(lat)
% sdy = std(long);
% egi = 1;
% egj = 1;
% A = 0 : 0.01 : 1;
% B = 0 : 0.01 : 1;
% for i=1 : length(A)
% 	for (j=1 : length(B))
% 		ex(i,j) = gauss(100, A(i), B(j), mx, my, 100, 100);
% 	end
% end
% surf(A, B, ex);

% A = 0 : 0.01 : 1;
% B = 0 : 0.01 : 1;
% for i=1 : length(A)
% 	for (j=1 : length(B))
% 		ex(i,j) = gauss(1, A(i), B(j), 0.5, 0.5, 0.2, 0.2);
% 	end
% end
% surf(A, B, ex);
%trainOut = rental(:,1);
%params = trainRegressor1(trainIn, trainOut);
