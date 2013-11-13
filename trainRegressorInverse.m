function params = trainRegressorInverse(trainIn, trainOut)

    lat = normalise(trainIn(:,1));
    long = normalise(trainIn(:,2));

    numClusters = 15;
    meansOfGaussians = kmeans(lat, long, 15);

    numGauss = numClusters;
    mustep = 1/(numGauss+1);
    c = mustep:mustep:1-mustep;
    r = mustep;

    xmus = repmat(c,numGauss);
    xmus = xmus(1,:);
    ymus = reshape(repmat(c,numGauss), numGauss^2, numGauss);
    ymus = ymus(:,1)';
    w = ones(numGauss^2,1);

    % Calculate thi
    xminusmus = bsxfun(@minus, lat, xmus);
    yminusmus = bsxfun(@minus, long, ymus);
    thi = exp(-(((xminusmus.^2)/(2*r^2))+((yminusmus.^2)/(2*r^2))));
    % Log transform for better fit
    z = log(trainOut);
    % Optimisation using the pseudoinverse

    params.w = (thi' * thi) \ thi'*trainOut;
    params.r = r;
    params.c = c;
end