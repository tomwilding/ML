function maxRowSum = maxRowSum(row)
	difference = diff([0; (row(:) ~= 0); 0]);
	indices = [find(difference > 0) find(difference < 0)-1];
	for (i=1:size(indices,1))
		partialSums(i) = sum(row(indices(i,1):indices(i,2)));
	end
	maxRowSum = max(partialSums);
end