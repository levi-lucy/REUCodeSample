%%
%birdsToCoords turns the list of birds and their abundancies, found in
%birdInfo, to a n-dim vector, where n is the number of unique species. 
%species is the species list,
%routes is the list of routes, and routeNames holds the list of geographical 
%names of locations. routeList gives the lat/long
%coordinates, and birdCoord is the n-dim vector with bird abundancies as
%entries, names is the names of the geographical locations corresponding to
%a vector.
function [routeList, birdCoord, names] = birdsToCoord10(birdInfo, species, routes, routeNames)
routeList = zeros(1,3); %Start the routeList
names = [{}]; %Start the names list
birdCoord = zeros(1,size(species,1)); %Start the bird vectors matrix
j = 1; %index for lists
i = 1; %index for creating vectors
sz = size(birdInfo,1); %Number of rows in bird info table

while i <= sz %While we still have bird information
    locI = zeros(1,size(birdInfo,2)); %Start matrix to hold bird, year, and location information from one location
    locI(1,:) = birdInfo(i,:); % 1st entry is the first entry of the new location
    i=i+1; %Go to next entry to not get caught in infinite loop
    index = 2; %Index for entries from an individual location
    while (i <= sz && birdInfo(i,1) == birdInfo(i-1,1)) %While the location doesn't change
        locI(index,:) = birdInfo(i,:); %Enter bird, year, and location information
        i = i+1; 
        index = index+1;
    end
    [vector, test] = createAvgVector(locI,species); %To get number of years 
    if test >= 10 %Only create vector for locations with 10+ years of data
     birdCoord(j,:) = vector; %Create vector of abundancies
     routeList(j,:) = getLatLong(routes, locI(1,1)); %Enter lat/long coordinates for vector
     names(j,1) = getNames(routes(:,1),locI(1,1),routeNames); %Enter name of location for vector
     j = j+1;
    end
end
end