function cls = sortCentralLine(names, lats, longs, labels)
	% Sort stations according to central line order
	orderedNames = {};
	orderedLats = zeros(length(labels),1);
	orderedLongs = zeros(length(labels),1);

	% get index of name in ordered list
	for(nameIndex=1:size(names,1))
		name = names(nameIndex);
		% Get index of this name in labels
		for(labelIndex=1:size(labels,1))
			if (strcmp(name,labels(labelIndex)))
				orderedNames(labelIndex) = name;
				orderedLats(labelIndex) = lats(nameIndex);
				orderedLongs(labelIndex) = longs(nameIndex);
			end
		end
	end
	cls.names = orderedNames';
	cls.lats = orderedLats;
	cls.longs = orderedLongs;
end