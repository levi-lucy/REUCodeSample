%%
%This program compiles 20 years of Breeding Bird Survey bird data from given Excel sheets and 
%converts the bird information from each location to a corresponding vector based on
%population data. For each vector, its closest vector in Euclidean space is
%determined, this closest vector representing the most similar location
%with respect to bird population. Each location is plotted using its
%lat/long information, and two locations are connected by a red line if
%they lie in different Bird Conservation Regions. Results indicated that
%some improvements could be made. Add "functions" file to path before running.


%%
clc; clear; close all;

%Run this first section if Excel tables have not been created
%{
%Compile list of species
speciesList = xlsread('CleanedDataAnalysis\SpeciesList.xlsx');

%Compile list of route and route names
[routes, routeNames] = xlsread('ExcelFiles\RoutesCorrected.xlsx',1,'A2:E5628');

%Reads in list of bird names and their corresponding BBS numbers
[birds, names] = xlsread('BirdNumbers', 1,'A1:B748');

%Created blank array, to be filled with the bird information
birdsInfo = [];
files = dir('20YearAnalysis\1997_2016Data');


for i = 3:size(files,1) %Get all the bird information from each state/province into one table
    tic
    fileName = strcat('20YearAnalysis\1997_2016Data\',files(i).name);
    birdsInfo = [birdsInfo;xlsread(fileName)];
    toc
end

birdNames = createBirdNames(speciesList, birds, names); %Create the bird names table

%Create the bird abundancies vectors, and the lat\long and location names
%tables
[latLongs, birdVector, locNames] = birdsToCoord10(birdsInfo,speciesList,routes,routeNames);

%Write tables to use later
xlswrite('20YearAnalysis\latLongs.xlsx',latLongs);
xlswrite('20YearAnalysis\vectors.xlsx', birdVector);
xlswrite('20YearAnalysis\LocationNames.xlsx',locNames);
%}


%%
%Skip to here if tables are created
birdvectors = xlsread('20YearAnalysis\ExcelFiles\vectorsErrorsRemoved.xlsx');
nPoints = normalize(birdvectors); %Normalize vectors to contains values between 0 and 1

latLongs = xlsread('20YearAnalysis\ExcelFiles\latLongs.xlsx');
nearList = getKNearestNeighbor(nPoints,1); %Most similar points

%Create Scatter plot using lat/long coordinates
scatter(latLongs(:,1),latLongs(:,2),'.')
xlabel('longitude')
ylabel('latitude')

nearBCR = [zeros(size(nearList,1),3)]; %Create empty BCR code list


for k = 1:size(nearList,1) %To plot lines and fill nearBCR and names2
   ind1 = nearList(k,1); %Index of original point
   ind2 = nearList(k,2); %Index of point most similar
   xpts1 = [latLongs(ind1,1);latLongs(ind2,1)]; %longitudes
   ypts1 = [latLongs(ind1,2);latLongs(ind2,2)]; %latitutdes
   nearBCR(k,1) = latLongs(ind1,3); %BCR code of original point
   nearBCR(k,2) = latLongs(ind2,3); %BCR code of nearest point
   
   if nearBCR(k,1) ~= nearBCR(k,2) 
       pl = line(xpts1, ypts1);
       pl.Color = 'red';
   end
end