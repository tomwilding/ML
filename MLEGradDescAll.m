function wCurr = MLEGradDescAll(time, price, order)
    limit = 0.01;
    
    % Init Weights TODO: Ensure they are not equal
    wCurr = zeros(order+1,1);
    for (o=1 : order+1)
        wCurr(o) = randn;
    end

    n = 2;
    delta = 10;
    step = 10;
    grad(n-1,:) =  (normalise(time), price, wCurr, delta);

    while(norm(grad(n-1,2)) > 0.01 & norm(grad(n-1,1)) > 0.01)
        wPrev = wCurr;
        % grad(n-1,1)
        for (o=1 : order+1)
            wCurr(o) = wPrev(o) + step*grad(n-1,o);
        end
        % Update next gradient
        grad(n,:) = LLgradAll(normalise(time), price, wCurr, delta);
        n = n + 1;  
    end

end

function cond = gradAboveLimit(grad, n, order)
    cond = true;
    for (o=1: order+1)
        cond = cond & norm(grad(n-1,o));
    end
end