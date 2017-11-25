function [population,averageFitnessPopulation]  = select(population, offsprings)
    pop_size       = size(population,1)   %count rows = 1
    offspring_size = size(population, 2)  %count columns = 2
    countOffsprings = size(offsprings,1)
    format long
        
    fitnessPopulation = zeros(pop_size,1)
    
    % Calculate fitness values for all offsprings.
    allOffspringFitnesses = zeros(countOffsprings,1)
    for i = 1:countOffsprings
        currentOffspring = offsprings(i, :)
        allOffspringFitnesses(i) = str2double( optical( currentOffspring ) )
    end
    
    % Get indexes top offsprings equal to population size
    
    %OBJECTIVE = Fitness Minimization
    maxValueFitness = 9999%max(allOffspringFitnesses)
    
    for j = 1:pop_size
        [minimumFitnessValue,indexCurrentMinimumFitnessValue] = min(allOffspringFitnesses)
        currentBestOffspring = allOffspringFitnesses(indexCurrentMinimumFitnessValue)
        population(j) = currentBestOffspring
        fitnessPopulation(j) = minimumFitnessValue
        allOffspringFitnesses(indexCurrentMinimumFitnessValue) = maxValueFitness
        averageFitnessPopulation = mean(fitnessPopulation)
    end  
end