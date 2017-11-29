function mutatedOffsprings = mutate(offsprings, bitMutations)
    mutatedOffsprings = offsprings;
    amountOffsprings = size(offsprings, 1);
    sizeOffspring = 30;
   
    for i=1:amountOffsprings
        randomOffspringIndex = randi(amountOffsprings,1);
        currentOffspring = offsprings(randomOffspringIndex,:);
        for j=1:bitMutations
            randomMutationIndex = randi(sizeOffspring,1);
            uniformNegativePositiveValue = 1 - 2*rand()
            
            stepSize = 1
            
            newParameterValue = currentOffspring(randomMutationIndex) + stepSize * uniformNegativePositiveValue;
       
       
            if newParameterValue > 1
                newParameterValue = 1
            end
            if newParameterValue < 0
                newParameterValue = 0
            end
            
            mutatedOffspring = currentOffspring
            mutatedOffspring(randomMutationIndex) = newParameterValue;
            
        end
        mutatedOffsprings(randomOffspringIndex,:) = mutatedOffspring
    end
end