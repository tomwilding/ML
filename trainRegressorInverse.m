function params = trainRegressorInverse(trainIn, trainOut)

    lat = normalise(trainIn(:,1));
    long = normalise(trainIn(:,2));

    numGauss = 2;
    numClusters = numGauss;
    [cx, sdx, cy, sdy] = kmeans(lat, long, numClusters);

    % Compose thi matrix
    for (i=1:length(trainOut))
        for (j=1:numGauss)
            % Base encoding of data point xi
            thi(i,j) = exp(-((((lat(i) - cx(j))^2)/(2*sdx(j)^2)) + (((long(i) - cy(j))^2)/(2*sdy(j)^2))));
        end
    end

    % Log transform for better fit
    z = log(trainOut);
    % Optimisation using the pseudoinverse
    (thi' * thi) \ thi'*z
    params.w = (thi' * thi) \ thi'*z;
    params.r = [sdx, sdy];
    params.c = [cx, cy];
end