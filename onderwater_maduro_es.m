function [xopt, fopt] = onderwater_maduro_es(eval_budget)
    population_size = 5;
    lambda = 6;   %amount of offsprings per generation

    t = 0;
    population = initialize(population_size);
    fitness = evaluate(population);
    fitnessEvolution = zeros(eval_budget,1)
    while (t < eval_budget)
        offsprings1 = recombine(population,lambda);
        %offsprings2 = mutate(offsprings1,mu,lambda);
        [population, averageFitnessPopulation] = select(population, offsprings1);
        fitnessEvolution(t+1) = averageFitnessPopulation
        t = t + 1;
    end
    
    plot(fitnessEvolution)
    [fopt, xopt] = min(fitnessEvolution);
end