function fitness = evaluate(population)
    pop_size = size(population, 1);
    pop_fitness = zeros(pop_size);
    for i=1:pop_size
        i
        pop_fitness(i) = optical( population(i, :) );
    end
end