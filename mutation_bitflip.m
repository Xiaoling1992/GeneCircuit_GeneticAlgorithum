function newIndvs = mutation_bitflip(population, mutationRate,sizeMuts)
    y = 1;
    newIndvs = cell(sizeMuts,1);
    while y<=sizeMuts
         indv = randi(size(population, 1));
         M_indv = population{indv}{1};
         for i=1:size(M_indv,1)
             for j=1:size(M_indv,2)
                % draw random number and determine if it will be mutated
                randomnr = rand();
                if randomnr<mutationRate
                    M_indv(i,j) = ~M_indv(i,j);
                end
             end
         end
         in_indv = population{indv}{2};
         for i=1:size(in_indv,1)
             % draw random number and determine if it will be mutated
             randomnr = rand();
             if randomnr<mutationRate
                 in_indv(i,1) = ~in_indv(i,1);
             end
         end
         out_indv = population{indv}{3};
         for i=1:size(in_indv,1)
             % draw random number and determine if it will be mutated
             randomnr = rand();
             if randomnr<mutationRate
                 out_indv(i,1) = ~out_indv(i,1);
             end
         end
         
         newIndvs{y} = population{indv};
         newIndvs{y}{1} = M_indv;
         newIndvs{y}{2} = in_indv;
         newIndvs{y}{3} = out_indv;
         y = 1+y;
    end
end