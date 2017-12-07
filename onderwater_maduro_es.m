function [xopt, fopt] = onderwater_maduro_es(eval_budget)

    individualParameterStepsizes = ones(30);
    LocalLearningRate = 1/sqrt(2*sqrt(30));
    GlobalLearningRate = 1/sqrt(2*30);
   
    simulations = 50;       %20
    muLambdaSimulations = zeros(simulations,2);
    minFopt = 999999999999;
    minFoptMuLambdaSimulation = 0;
    fitnessSimulations = zeros(simulations,1);
    
    fitnessSurface = zeros(50,100)
    
    
    %when we know optimal parameters use this part below..
    %population_size = 5 %optimaal;            %
    %lambda = 20 %optimaal;   %
    %generations = floor( (eval_budget - population_size ) / lambda )
    %fitnessSimulationsEvolution = zeros(generations,simulations)
    
    for i=1:simulations
        population_size = randi(50)            %
        lambda = population_size + randi(50)   %
        generations = floor( (eval_budget - population_size ) / lambda )
        
        if generations <= 0
            generations = 10
        end
        
        t = 1;
        population = initialize(population_size);
        fitness = evaluate(population);
        fitnessEvolution = zeros(generations,1);
        while (t <= generations)
            offsprings1 = recombine(population,lambda);
            offsprings2 = mutate(offsprings1,LocalLearningRate,GlobalLearningRate,individualParameterStepsizes);
            [population, averageFitnessPopulation] = select(population, offsprings2);
            fitnessEvolution(t) = averageFitnessPopulation;
            
            %when we know optimal parameters
            %fitnessSimulationsEvolution(t,i) = averageFitnessPopulation
            
            t = t + 1;
        end
        fitnessEvolution
        [fopt, xopt] = min(fitnessEvolution);
        
        fitnessSurface(population_size,lambda) = fopt;
        
        
        
        muLambdaSimulations(i, :) = [population_size lambda];
        fitnessSimulations(i) = fopt;
        if fopt < minFopt
            minFopt = fopt;
            minFoptPlotData = fitnessEvolution;
            minFoptMuLambdaSimulation = [population_size lambda];
        end
        t
    end
    
    amountOfContours = 10  
    contourf(fitnessSurface,amountOfContours)  %can crash if amount of contours to large
  
    % Find the best simulation.
    [minFopt, minFoptPos] = min(fitnessSimulations);
    %plot(minFoptPlotData)
    minFoptMuLambdaSimulation
    minFopt
    
    %when we know optimal parameters use this part below..
    %averageFitnessSimulations = mean(fitnessEvolution)
    %stdFitnessSimulations = std(fitnessEvolution)
    %meanFitnessEvolutionSimulations = mean(fitnessSimulationsEvolution,2)
    %plot(meanFitnessEvolutionSimulations)
    

    
    
    
    
    
    %plot..
    %plot(fitnessEvolution)
    
end