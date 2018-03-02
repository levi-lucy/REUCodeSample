%%
%retrieves the lat long coordinates of a csr code
function latLong = getLatLong(locTable, csrCode) 
    ind = findPlace(locTable(:,1), csrCode);
    latLong = locTable(ind,[2 3 4]);
end