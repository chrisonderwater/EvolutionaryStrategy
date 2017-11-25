function allOffsprings = recombine(population,lambda)
    minimumParents = 2   %atleast 2 needed for recombination
    maximumParents = 5%size(population,1) %maximum all parents used for recombination 
    sizeParent = 30 %length(population(1,:))
    
    allOffsprings = zeros(lambda,sizeParent)
    
    %generate lambda offsprings
    for i=1:lambda
        
        %choose amount of X random parents that will be used for recombination
        X = randi(maximumParents,1)
        
        Xindexes = zeros(X,1)  %init list
        
        %choose the indexes of the X random parents that will be used from
        %population for recombination
        Xindexes = randsample(maximumParents,X)
        
        %recombine -> for each parameter take the average out of the X parents
        newOffspring = zeros(sizeParent,1)
        for j=1:sizeParent   %amount of parameters
            som = 0
            for k=1:X       %amount of parents selected
                currentParent = population(Xindexes(k),:) 
                som = som + currentParent(j)  
            end
            X
            average = som/X   %average for this parameters
            
            newOffspring(j) = average
        end    
        %size(newOffspring)
        %size(
        allOffsprings(i,:) = newOffspring  %add new offspring to all offspring (listoflists)
        size(allOffsprings,1)
    end
end