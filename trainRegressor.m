% params = trainRegressor(trainIn, trainOut)
% 
% trainRegressor builds a mapping from two-dimensional input to
% one-dimensional output.
%
% trainRegressor returns a structure that contains all information needed
% for testRegressor.
%
% Inputs:
%
% trainIn    testing input locations. Size: Nx2
%
% params    output of trainRegressor function
%
% Outputs:
%
% results   predicted price to rent at the input locationss. Size: Nx1

function params = trainRegressor(trainIn, trainOut)
    lat = normalise(trainIn(:,1));
    long = normalise(trainIn(:,2));

    numGauss = 6;
    numClusters = numGauss;

    [cx, sdx, cy, sdy] = kmeans(lat, long, numClusters);
    
    % Log transform for better fit
    z = log(trainOut);
    
    % Introduce bias parameter
    b = min(z);

    % Compose thi matrix

    for (i=1:length(trainOut))
        for (j=1:numGauss)
            % Base encoding of data point xi
            thi(i,j) = b + exp(-((((lat(i) - cx(j))^2)/(2*sdx(j)^2)) + (((long(i) - cy(j))^2)/(2*sdy(j)^2))));
        end
    end

    % Optimisation using the pseudoinverse
    w = (thi' * thi) \ thi'*z;
    
    params.w = w;
    params.b = b;
    params.r = [sdx, sdy];
    params.c = [cx, cy];
end