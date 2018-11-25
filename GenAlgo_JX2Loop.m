modules=[4];  %number of modules in the gene circuit.
for sizeM=modules


close all;
% set parameters
maxGen = 100;
popuSize = 100;   
%Examples of parameters: [0.1, 0.5, 0.5, 0.1,  1];
%                        [0.07,0.7, 0.3, 0.1,0.7];
mutationRate = 0.1; % rate of a mutation to occur on a certain spot in 'chromosome'
thresDel = 0.7; %0.7 30% of population with a low fitness score is removed
thresFit = 0.3; % 0.3 30% of population is best fit
presMut = 0.1; % 10% of population is mutated
presCross = 0.7; % 0.7 change of a crossover to happen in the best fit population, keep random?

%sizeM = 2;   % The dimension of network

% initialize
%M 1 by 50 cell araray, contains cells with M, IN, OUT and fit matrices
population = cell(popuSize,1);
fit = [0];
for i = 1:size(population,1)
    M = randi([0,1],sizeM,sizeM);
    IN = randi([0,1],sizeM,1);
    OUT = randi([0,1],sizeM,1);
    population{i} = {M,IN,OUT,fit};
end
 population = fitness_indv(population,sizeM);
archive_bestfitness = {};

gen = 1;
% while loop over generations, with a maximum of a set generation size
while gen<maxGen+1
    disp('');
    disp('Generation and population');
    disp(gen);
    disp(size(population,1))
    % evaluate
    %disp('starting evaluation')
   
    fitness_data = extract_data(population, 4);   
    figure(999)
    plot(gen*ones(length(population),1),fitness_data,'O');
    hold on;
    [tem1,tem2]=min(fitness_data);
    disp('best fitness');
    disp(tem1);
    network=population{tem2}{1};
    in_vector=population{tem2}{2};
    out_vector=population{tem2}{3};
    

%         nedges=linspace(min(fitness_data),max(fitness_data),30);
%         nbins=(nedges(1:end-1)+nedges(2:end))/2;
%         dn= diff(nedges);
%     %Count of clusters whose sizes are in [nvec(i),nvec(i+1))
%         F= histcounts(fitness_data,nedges);
%     %Probability density
%         P= F./(dn*sum(F));
%         figure
%         plot(nbins,P,'-s');
    if(gen==maxGen)
     figure(999)
     xlabel('generation')
     ylabel('score');
     
      figure;
       histogram(fitness_data,10);
        xlabel('score')
       ylabel('distribution');
       break;
    end
    
    % selection
    [tem1,tem2]=sort(fitness_data);    %sort the fitness_data from minimum to maximum. tem1 is the sorted array, tem2 is the original index of every element of tem1 in population.
    stayFit_num=round(thresDel*length(tem2));  %The number of individuals;
    stayFit_index=tem2(1:1:stayFit_num);       %The indexs of the individuals which could stay in population
    population=population(stayFit_index,1);  
    disp('population size left')
    disp(size(population,1));
  
%     norm_data = tiedrank(fitness_data) / length(fitness_data);
%     selection = norm_data<thresDel;    
%     selection = ~selection;
%     population(selection,:) = [];
%     disp('population size left')
%     disp(size(population,1))    
    
    if (sizeM>1)
    % crossover
    disp('starting crossover, population becomes')
%     fitness_data2 = extract_data(population, 4);    
%     [tem1,tem2]=sort(fitness_data2);    %sort the fitness_data2 from minimum to maximum. tem1 is the sorted array, tem2 is the original index of every element of tem1 in population.
%     bestFit_num=round(thresFit*length(tem2));  %The individual numbers in bestFit;
%     bestFit_index=tem2(1:1:bestFit_num);       %The indexs of the best individuals in population
      bestFit_num=round(thresFit*length(population));    
      bestFit=population(1:1:bestFit_num,1);      %copy the best individual from poplation to bestFit.
    
    %select = selection_indv(fitness_data,thresFit);
%     norm_data2 = tiedrank(fitness_data2) / length(fitness_data2);
%     select = norm_data2<thresFit;    
    %bestFit = population(select,:);
    newIndvs = crossover(bestFit, presCross);
    newIndvs = fitness_indv(newIndvs,sizeM);
    population = [population;newIndvs];
    disp(size(population,1))
    end
    
    
    % mutation - bit flip for now, future duplication, deletion events
    disp('starting mutations, population becomes')
    sizeMuts=popuSize-size(population,1);
    %sizeMuts = round(size(population,1)*presMut);
    newIndvs2 = mutation_bitflip(population,mutationRate, sizeMuts);
    newIndvs2 = fitness_indv(newIndvs2,sizeM);
    population = [population;newIndvs2];
    disp(size(population,1))
    gen = gen + 1;
end

disp('Score Check, plot figures');
 scoreCheck(sizeM)=fitscoreXZ_Fig(network,in_vector,out_vector,sizeM); % plot the figures based on the best network;
disp(scoreCheck);
figure(2)
print(gcf,['../figure/curve_Nsci_step_pulse_',num2str(sizeM),'.png'],'-dpng','-r300');
figure(1)
print(gcf,['../figure/distribution_Nsci_step_pulse_',num2str(sizeM),'.png'],'-dpng','-r300');
figure(999)
print(gcf,['../figure/generation_Nsci_step_pulse_',num2str(sizeM),'.png'],'-dpng','-r300');
end

figure;
plot(modules,scoreCheck(modules),'-d','linewidth',2);
xlabel('# modules');
ylabel('best scores');
print(gcf,['../figure/scorefGen_Nsci_step_pulse_',num2str(sizeM),'.png'],'-dpng','-r300');
    