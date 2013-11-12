function wcurr = leastSquareFit(rental, time, order)
    time = normalise(time);
    threshold = 0.01;
    rate = 0.5;
    wcurr = zeros(order+1, 1);
    wprev = ones(order+1, 1);
    
    while(sum(abs(wcurr - wprev)) > threshold)
        sum(abs(wcurr - wprev))
        wprev = wcurr;
        for (o=0 : order)
            sse = 0;
            for(i=1 : length(rental))
                % Estimated value
                v = 0;
                for (j=1 : length(wcurr))
                    v = v + (time(i)^(j-1)) * wcurr(j);
                end
                % Update SSE
                sse = sse + (v - rental(i)) * time(i)^o;
            end
            err = sse / length(rental);
            wcurr(o+1) = wcurr(o+1) - rate * err;
        end
    end  
end

function v = est(x, weights)
    % Value of the estimation with the current weights
    v = 0;
    for (i=1 : length(weights))
        v = v + (x^(i-1)) * weights(i);
    end
end
    
    