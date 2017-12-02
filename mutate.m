function mutatedOffsprings = mutate(offsprings, bitMutations,LocalMutationRate,GlobalMutationRate,individualParameterStepsizes)
    mutatedOffsprings = offsprings;
    amountOffsprings = size(offsprings, 1);
    sizeOffspring = 30;
    
    % x = exprnd(5:10);
    %bitMutations = int16();
    bitMutations = randi(30);
    
    for i=1:amountOffsprings
        randomOffspringIndex = randi(amountOffsprings,1);
        currentOffspring = offsprings(randomOffspringIndex,:);
        for j=1:bitMutations
            randomMutationIndex = randi(sizeOffspring,1);
            uniformNegativePositiveValue1 = normrnd(0, 1);
            uniformNegativePositiveValue2 = normrnd(0, 1);
            uniformNegativePositiveValue3 = normrnd(0, 1);
            
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