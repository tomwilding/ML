function e = rmserror(predicted, actual)
	e = sqrt(1/(size(actual,1)) .* sum((predicted - actual).^2));
end