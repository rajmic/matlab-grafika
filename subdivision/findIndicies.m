function [indicies] = findIndicies(source,searched,direction)
if nargin<3
    direction = 'rows';
end
    [~,counts] = ismember(source,searched,direction);
    idxs = (1:size(source))';
    indicies = counts.*idxs;
    indicies(indicies==0) = [];
end

