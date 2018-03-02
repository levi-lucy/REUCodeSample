%%
%createBirdNames takes a bird species code from givenSpecies, and finds the
%matching code in lTable. The index of that code in lTable is the index
%for that bird's names in birdNames. 

function names = createBirdNames(givenSpecies,lTable,birdNames)
    names = repmat("",size(givenSpecies,1),1);
    for i = 1:size(givenSpecies,1)
        ind = findPlace(lTable(:,1),givenSpecies(i,1));
        names(i,1) = birdNames(ind,1);
    end
end