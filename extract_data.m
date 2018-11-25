function L = extract_data(cellArray, rowNr)
    L = [];
    for i = 1:size(cellArray)%[1]
        extracted = cellArray{i}{rowNr};
        L(i) = extracted;
    end
end