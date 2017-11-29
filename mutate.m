function mutatedOffsprings = mutate(offsprings, bitMutations,LocalMutationRate,GlobalMutationRate,individualParameterStepsizes)
    mutatedOffsprings = offsprings;
    amountOffsprings = size(offsprings, 1);
    sizeOffspring = 30;
    
    bitMutations = randi(30,1);
    
    for i=1:amountOffsprings
        randomOffspringIndex = randi(amountOffsprings,1);
        currentOffspring = offsprings(randomOffspringIndex,:);
        for j=1:bitMutations
            randomMutationIndex = randi(sizeOffspring,1);
            uniformNegativePositiveValue1 = 1 - 2*rand();
            uniformNegativePositiveValue2 = 1 - 2*rand();
            uniformNegativePositiveValue3 = 1 - 2*rand();
            
            currentStepSize = individualParameterStepsizes(randomMutationIndex);
            newStepSize = currentStepSize + exp(GlobalMutationRate * uniformNegativePositiveValue1 + LocalMutationRate * uniformNegativePositiveValue2);  
            
            newParameterValue = currentOffspring(randomMutationIndex) + newStepSize * uniformNegativePositiveValue3;
       
       
            if newParameterValue > 1
                newParameterValue = 1;
            end
            if newParameterValue < 0
                newParameterValue = 0;
            end
            
            mutatedOffspring = currentOffspring;
            mutatedOffspring(randomMutationIndex) = newParameterValue;
            
        end
        mutatedOffsprings(randomOffspringIndex,:) = mutatedOffspring;
    end
end