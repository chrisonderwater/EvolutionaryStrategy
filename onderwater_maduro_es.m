function [xopt, fopt] = onderwater_maduro_es(eval_budget)
    population_size = 5;
    lambda = 5;   %amount of offsprings per generation

    t = 0;
    population = initialize(population_size);
    fitness = evaluate(population);
    while (t < eval_budget)
        offsprings1 = recombine(population,lambda);
        %offsprings2 = mutate(offsprings1,mu,lambda);
        selection = select([population ; offsprings1]);
        t = t + 1;
    end
    [fopt, xopt] = max(fitness);
end