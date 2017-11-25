function [xopt, fopt] = onderwater_maduro_es(eval_budget)
    population_size = 30;
    offsprings = 5;
    evolution_window_size = 

    t = 0;
    population = initialize(population_size);
    fitness = evaluate(population);
    while (t < eval_budget)
        offspring1 = recombine(population);
        offspring2 = mutate(offspring1);
        selection = select([population ; offspring2]);
        fitness = evaluate(population, selection);
        t = t + 1;
    end
    [fopt, xopt] = max(fitness);
end