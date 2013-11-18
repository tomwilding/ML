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
    % Normalsie input values
    lat = normalise(trainIn(:,1));
    long = normalise(trainIn(:,2));
    % Constant: Number of gaussians used as basis functions
    numGauss = 6;
    % Number of clusters used in k-means
    numClusters = numGauss;

    % Centres and standard deviations of gaussians from k-means
    [cx, sdx, cy, sdy] = kmeans(lat, long, numClusters);
    
    % Log transform for better fit
    z = log(trainOut);
    
    % Introduce bias parameter
    b = min(z);

    % Compose thi matrix used to calculate weights
    for (i=1:length(trainOut))
        for (j=1:numGauss)
            % Base encoding of data point xi
            thi(i,j) = b + exp(-((((lat(i) - cx(j))^2)/(2*sdx(j)^2)) + (((long(i) - cy(j))^2)/(2*sdy(j)^2))));
        end
    end

    % Optimisation using the pseudoinverse to get the weights
    w = (thi' * thi) \ thi'*z;
    
    % Return params
    params.w = w;
    params.b = b;
    params.r = [sdx, sdy];
    params.c = [cx, cy];
end