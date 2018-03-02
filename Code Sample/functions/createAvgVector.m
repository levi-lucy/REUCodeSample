%%
%vectorGiven is vector with bird data from one location, table is species lookup
%table for vector entry, vectorGiven has year observed in 1st entry,
%bird type in 3rd entry, abundance in 4th entry. 


function [vec, numYears] = createAvgVector(vectorGiven, table) 
    vec = zeros(1,size(table,1)); %create n-dimensional vectors with all zeros, dimension based on number of species
    numYears = 1;                 %start number of years data is taken from  
    thisYear = vectorGiven(1,2);  %current year
   for i = 1:size(vectorGiven,1)  
        ind = findPlace(table, vectorGiven(i,3)); %find species place
        vec(1,ind) = vec(1,ind) + vectorGiven(i,4); %add abundance for that year    
        if vectorGiven(i,2) ~= thisYear  %if year has increased
            numYears = numYears + 1;     %add one to year count
            thisYear = vectorGiven(i,2); %get that year   
        end
   end
    vec = vec/numYears;  %get average
end