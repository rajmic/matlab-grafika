function [indices] = findPlanesWithPoint(point, originalShape)
% Returns indices of planes that contain a given point

nPlanes = size(originalShape,3);                

indices= zeros(nPlanes,1);
if(size(point,1)>size(point,2))
    point = point';
end

for plane =1:nPlanes
    idxs = findIndicies(originalShape(:,:,plane),point,'rows');
    if ~isempty(idxs)
        indices(plane) = plane;
    end   
end

indices(indices==0) = [];
end

