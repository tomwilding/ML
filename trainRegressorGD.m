function params = trainRegressorGD(trainIn, trainOut)
    
    lat = normalise(trainIn(:,1));
    long = normalise(trainIn(:,2));

    threshold = 1;
    rate = 0.9;
    numGauss = 3;

    % Basis function centre and radius
    c = (0:1/(numGauss-1):1);
    r = 1/(numGauss-1);

    wcurr = ones(numGauss, numGauss)
    wprev = zeros(numGauss, numGauss)
    
    while(sum(sum(abs(wcurr - wprev))) > threshold)
        sum(sum(abs(wcurr - wprev)))
        wprev = wcurr;
        for (m=1 : size(wcurr,1))
            for (n=1: size(wcurr,2))
            	% Estimated value for all i,j gaussians
                v = zeros(size(lat));
                for (i=1 : size(wcurr,1))
                	for (j=1 : size(wcurr,2))
                    	v = v + wcurr(i,j) * exp(-((((lat - c(i)).^2)/(2*r^2)) + (((long - c(j)).^2)/(2*r^2))));
                	end
                end
                % Update SSE (Estvalue - actual) * evalWithoutWeight
                sse = sum((v - trainOut) .* exp(-((((lat - c(m)).^2)/(2*r^2)) + (((long - c(n)).^2)/(2*r^2)))));
                err = sse / size(trainOut, 1);
                wcurr(m,n) - rate * err;
                wcurr(m,n) = wcurr(m,n) - rate * err;
            end
        end
        wcurr
    end 

    params = wcurr;
end