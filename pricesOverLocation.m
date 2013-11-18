% QBa)
clearvars *
load('rental.mat')
rentalFiltered = filterOutliers(rental);
% Prices against time plot
locations = [rentalFiltered(:,3),rentalFiltered(:,4)];
price = rentalFiltered(:,1);
plot3(locations(:,1),locations(:,2),price,'.');
title('Rental Price against Location','FontSize',16)
xlabel('Lattitude [Deg]','FontSize',14);
ylabel('Longitude [Deg]','FontSize',14);
zlabel('Price[£]','FontSize',14);
grid on;