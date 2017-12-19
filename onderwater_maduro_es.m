function [xopt, fopt] = onderwater_maduro_es(eval_budget)
    LocalLearningRate = 1/sqrt(2*sqrt(30));
    GlobalLearningRate = 1/sqrt(2*30);
   
    %when we do not know optimal combinations
    %{
    muMAX = 5  %dont change
    lambdaMAX = 10  %dont change
    fitnessSurface = ones(muMAX,lambdaMAX);
    simulations = lambdaMAX;
    %to compute all combinations for muMAX and lambdaMAX
    for s=1:muMAX-1
        simulations = simulations + lambdaMAX - s
    end    
    simulations
    %}
    
    %when we know optimal combination
    simulations = 20;
    population_size = 1; %optimaal;            %
    lambda = 3;         %optimaal;   %
    generations = floor( (eval_budget - population_size ) / lambda );
    averageFitnessParentsSimulationsEvolution = zeros(generations,simulations);
    
    
    muLambdaSimulations = zeros(simulations,2);
    minFopt = 999999999999;
    minFoptMuLambdaSimulation = 0;
    minimumFitnessSimulations = zeros(simulations,1);
     

    %when we know optimal parameters
    for i=1:simulations
        i
        
        %when we do not know optimal parameters
         %{
        population_size = randi(muMAX)            %
        lambda = randi(lambdaMAX) 
        if lambda < population_size
           lambda = population_size + randi(muMAX)
        end
       
        if fitnessSurface(population_size,lambda) ~= 1  %already computed this fitness
            "already computed"
            while fitnessSurface(population_size,lambda) < 1  %check if fitness already computed
                population_size = randi(muMAX)            %
                lambda = randi(lambdaMAX)   
                if lambda < population_size
                    lambda = population_size + randi(muMAX)
                end
            end
            "new Parameters"
            population_size
            lambda
        end
        
        generations = floor( (eval_budget - population_size ) / lambda )
        
        %}
              
        %helps with testing
        if generations <= 0
            generations = 5;
        end
         
        t = 1;
        population = initialize(population_size);
        fitness = evaluate(population);
        fitnessEvolution = zeros(generations,1);
        individualParameterStepsizes = ones(population_size, 30)*0.5;
        while (t <= generations)
            [offsprings1, individualParameterStepsizesOffspring1] = recombine(population, lambda, individualParameterStepsizes);
            [offsprings2, individualParameterStepsizesOffspring2] = mutate(offsprings1,LocalLearningRate,GlobalLearningRate,individualParameterStepsizesOffspring1);
            [population, averageFitnessPopulation, individualParameterStepsizes] = select(population, offsprings2, individualParameterStepsizes, individualParameterStepsizesOffspring2);
            fitnessEvolution(t) = averageFitnessPopulation;
            %when we know optimal parameters
            averageFitnessParentsSimulationsEvolution(t,i) = averageFitnessPopulation;
            
            t = t + 1;
        end
        fitnessEvolution
        [fopt, xopt] = min(fitnessEvolution);
        
        %when we do not know optimal parameters
        %fitnessSurface(population_size,lambda) = fopt;
        
        muLambdaSimulations(i, :) = [population_size lambda];
        minimumFitnessSimulations(i) = fopt;
        if fopt < minFopt
            minFopt = fopt;
            minFoptPlotData = fitnessEvolution;
            minFoptMuLambdaSimulation = [population_size lambda];
        end
        t
    end
    
    %when we do not know optimal parameters
    %{
    fitnessSurface(fitnessSurface==1)=-1
    maximumValueFitnessSurface = max(fitnessSurface(:))
    fitnessSurface(fitnessSurface==-1)=maximumValueFitnessSurface
    minimumValueFitnessSurface = min(fitnessSurface(:))
    
    fitnessSurfaceScaled = rescale(fitnessSurface,minimumValueFitnessSurface,maximumValueFitnessSurface) %( fitnessSurface - median(fitnessSurface(:)) ) / var(fitnessSurface(:)) %rescale(fitnessSurface)
            
    s = surf(fitnessSurfaceScaled,'FaceAlpha',0.5)
    s.EdgeColor = 'none';
    xlabel('Offsprings') % x-axis label
    ylabel('Parents') % y-axis label
    zlabel('Fitness')
    %}
    
    % Find the best simulation.
    [minFopt, minFoptPos] = min(minimumFitnessSimulations);
    %plot(minFoptPlotData)
    minFoptMuLambdaSimulation    %combination to best fitness in all simulation
    minFopt                      %best fitness in all simulations
        
    %when we know optimal parameters use this part below..
    averageMinimumFitnessSimulations = mean(minimumFitnessSimulations)   %best solution error
    stdMinimumFitnessSimulations = std(minimumFitnessSimulations)        %best solution std
    averageFitnessEvolutionSimulations = mean(averageFitnessParentsSimulationsEvolution,2);  %average fitness parent population during evolution all simulations

    plot(averageFitnessEvolutionSimulations);
    xlabel('Generations'); % x-axis label
    ylabel('Fitness'); % y-axis label

    
   
    
end