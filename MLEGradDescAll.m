function params = MLEGradDescAll(time, price, order)
    limit = 0.01;
    sigma = std(price);
    
    % Init Weights
    wCurr = zeros(order+1,1);
    for (o=1 : order+1)
        wCurr(o) = o+randn;
    end
    % Intial step
    n = 2;
    % Pertubation size
    delta = 10;
    % Learning rate
    step = 10;
    % Initial gradient
    gl =  LLgradAll(normalise(time), price, wCurr, sigma, delta);
    grad(n-1,:) = gl.g;

    while(gradAboveLimit(grad, n, order, limit))
        % Set previous weight
        wPrev = wCurr;
        % For all orders of the polynomial update weights
        for (o=1 : order+1)
            wCurr(o) = wPrev(o) + step*grad(n-1,o);
        end
        % Update next gradient
        gl = LLgradAll(normalise(time), price, wCurr, sigma, delta);
        grad(n,:) = gl.g;
        n = n + 1;  
    end
    params.ll = gl.ll;
    params.w = wCurr;
end

% Loop condition
function cond = gradAboveLimit(grad, n, order, limit)
    cond = true;
    for (o=1: order+1)
        cond = cond & (norm(grad(n-1,o)) > limit);
    end
end