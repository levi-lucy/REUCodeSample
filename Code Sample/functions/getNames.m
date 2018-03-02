%%
%Function to get a location's name based on the csr code. csrList is the
%list of csr codes, csrCode is the csr code to lookup, namesList is the
%list of location names. the i-th index of csrList corresponds to the i-th
%index of namesList. 
function name = getNames(csrList, csrCode, namesList)
            ind = findPlace(csrList,csrCode);
            name = namesList(ind,1);
end
