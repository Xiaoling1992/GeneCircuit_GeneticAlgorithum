function newIndvs = crossover(bestFit, presCross)
    y = 1;
    newIndvs = cell(round(size(bestFit,1)*presCross),1);
    % double crossover for now
    while y<round(size(bestFit,1)*presCross)+1
        % percentage random choosen individuals with best fitness
        indv = randi(size(bestFit, 1), 1);
        vectorlength = size(bestFit{indv}{1},1)*size(bestFit{indv}{1},2);
        
        % create 'chromosome' out of matrix
        bestFit_indv = reshape(bestFit{indv}{1},vectorlength,1);
        
        % select random part in 'chromosome'
        start_i = randi([1,length(bestFit_indv)-1]);
        end_i = randi([start_i+1,length(bestFit_indv)]);
        new_bestFit_indv = bestFit_indv(start_i:end_i); % part of 'chromosome' that will be crossed over
        
        % combine with random individual
        indv2 = indv;
        while indv == indv2
            indv2 = randi(size(bestFit, 1), 1);
        end
        bestFit_indv2 = reshape(bestFit{indv2}{1},vectorlength,1);

        try 
            bestFit_indv2(start_i:end_i) = new_bestFit_indv;
        catch
            % do nothing
        end
        newIndvs{y} = bestFit{indv2};
        newIndvs{y}{1} = reshape(bestFit_indv2,size(bestFit{indv2}{1},1),size(bestFit{indv2}{1},2));
        y = y+1;
    end
end
