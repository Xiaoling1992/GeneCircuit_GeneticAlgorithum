# GeneCircuit_GeneticAlgorithum
In the Q-bio summer school CSU in 2017, which was around June 16, 2017, Danny, Juleen and I worked on this project to search the optimal gene circuit to produce the desired output.

How to initiate the project?
1. Change the desired output and feedback equation: 
   In fitscoreXZ.m, change the input, inhibit feedback and desired output function: f_in, f_inhibit and f_desire.
2. Change the parameters of Genetic Algorithm:
   In GenAlgo_JX2Loop.m, change parameters as you need.
   modules=[4];  %number of modules in the gene circuit.
   
   maxGen = 100;  %Maximum iteration times.
   
   popuSize = 100;  %Size of the population
   
   mutationRate = 0.1; % rate of a mutation to occur on a certain spot in 'chromosome'
   
  thresDel = 0.7; %0.7 30% of population with a low fitness score is removed
  
  thresFit = 0.3; % 0.3 30% of population is best fit
  
   presMut = 0.1; % 10% of population is mutated
   
   presCross = 0.7; % 0.7 change of a crossover to happen in the best fit population, keep random?
