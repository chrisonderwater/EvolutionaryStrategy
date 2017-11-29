function [xopt, fopt] = onderwater_maduro_es(eval_budget)
    population_size = 5;
    lambda = 100;   %amount of offsprings per generation
    bitMutations = 1;
    individualParameterStepsizes = ones(30);
    LocalLearningRate = 1/sqrt(2*sqrt(30));
    GlobalLearningRate = 1/sqrt(2*30);

    t = 0;
    population = initialize(population_size);
    fitness = evaluate(population);
    fitnessEvolution = zeros(eval_budget,1);
    while (t < eval_budget)
        offsprings1 = recombine(population,lambda);
        offsprings2 = mutate(offsprings1, bitMutations,LocalLearningRate,GlobalLearningRate,individualParameterStepsizes);
        [population, averageFitnessPopulation] = select(population, offsprings2);
        fitnessEvolution(t+1) = averageFitnessPopulation;
        t = t + 1;
    end
    
    plot(fitnessEvolution)
    [fopt, xopt] = min(fitnessEvolution);
end