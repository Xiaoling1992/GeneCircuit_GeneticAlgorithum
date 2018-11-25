function population = fitness_indv(population,sizeM)
    % some function to calculate the fitness
    for i=1:size(population,1)
        fitnessScoreIndv = fitscoreXZ(population{i}{1},population{i}{2},population{i}{3},sizeM);
        population{i}{4} = fitnessScoreIndv;
    end
end