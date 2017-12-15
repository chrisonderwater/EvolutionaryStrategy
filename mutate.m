function [mutatedOffsprings, newIndividualParameterStepSizes] = mutate(offsprings,LocalMutationRate,GlobalMutationRate,individualParameterStepsizes)
    mutatedOffsprings = offsprings;
    amountOffsprings = size(offsprings, 1);
    sizeOffspring = 30;
    newIndividualParameterStepsizes = individualParameterStepsizes;
    
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

            currentStepSize = individualParameterStepsizes(i, randomMutationIndex);
            newStepSize = currentStepSize + exp(GlobalMutationRate * uniformNegativePositiveValue1 + LocalMutationRate * uniformNegativePositiveValue2);  
            newStepSize
            newIndividualParameterStepSizes(i, randomMutationIndex) = double(newStepSize); 
            newParameterValue = currentOffspring(randomMutationIndex) + newStepSize * uniformNegativePositiveValue3;
       
            %search domain
            if newParameterValue > 10000
                newParameterValue = 10000;
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