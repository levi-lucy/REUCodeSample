%%
%Finds index of a given item in a sorted list
function index = findPlace(list, value)
    start = round(size(list,1)/2);
    thisValue = list(start,1);
    if value == thisValue %if the values match
        index = start;
    elseif value < thisValue % if the value is less than the selected value
        list = list(1:start-1,1);  % cut list in half
        index = findPlace(list,value);
    else                             %else
        list = list(start+1:size(list,1),1); %take upper half of list
        index = start + findPlace(list,value);
    end
end