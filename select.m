function population = select(offspring)
    % Calculate fitness values for offspring.
    offspringFitness = zeros(size(offspring, 1))
    for i = 1:size(offspring, 1)
        offspringFitness(i) = str2num( optical( offspring(i, :) ) );
    end
    
    % Create a matrix by concatenating the fitness and the parameters.
    concatenatedMatrix = [offspringFitness' offspring];
    sortedConcatenatedMatrix = sortrows(concatenatedMatrix, 1);
    population = sortedConcatenatedMatrix(size(offspring, 1), 2:31);
    
end