function [newPoint] = calculateVertex(originalShape, originalPlaneIndex, index)
% 

%Having given index, I determine the original points
% 7 8 9
% 4 5 6
% 1 2 3

% original
% 4   3
% 
% 1   2

switch index
    case 3
        index = 2;
    case 7
        index = 4;
    case 9
        index = 3;
    otherwise
end


originalPoint = originalShape(index,:,originalPlaneIndex);
planesWithPoint = findPlanesWithPoint(originalPoint,originalShape);

allPointsOfCommonPlanes=[];
for i = 1:size(planesWithPoint)
    allPointsOfCommonPlanes = cat(1,allPointsOfCommonPlanes, originalShape(:,:,planesWithPoint(i)));
end

uniquePointsOfCommonPlanes = allPointsOfCommonPlanes;
uniquePointsOfCommonPlanes = unique(uniquePointsOfCommonPlanes,'rows');
counts = zeros(size(uniquePointsOfCommonPlanes,1),1);
for i=1:size(counts)
    counts(i) = size(findIndicies(allPointsOfCommonPlanes,uniquePointsOfCommonPlanes(i,:)),1);
end


maxCounts = max(counts);    %also valence of vertex

weights = [1/(4*maxCounts^2), 3/(2*maxCounts^2), (1- 3/(2*maxCounts) -1/(4*maxCounts)) ];
%  [point with no connecting side, point connected with side, center point]

% https://www.cl.cam.ac.uk/teaching/2000/AGraphHCI/SMEG/node6.html


% counts - how many times points from uniquePoints repeat in allPoints
% values possible higher than 3 but only 3 weights
newPoint = [0 0 0];

for point=1:size(counts,1)
    if(counts(point) >2)
        w = weights(3);
    else
    w =weights(counts(point));
    end
    newPoint = newPoint + w*uniquePointsOfCommonPlanes(point,:);
end

end

