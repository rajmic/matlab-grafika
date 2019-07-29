function [newPoint] = calculateEdgePoint(originalShape, originalPlaneIndex, index)
%Calculates coordinates of points that were created in the middle of sides
%of the original shapel

% new 
% 7 8 9
% 4 5 6
% 1 2 3

% original
% 4   3
% 
% 1   2

%i need original points
originalPoint1 = [];
originalPoint2 = [];

w6 = [1/16,3/8];        %4,2


switch index
    case 2
        originalPoint1 = originalShape(1,:,originalPlaneIndex);
        originalPoint2 = originalShape(2,:,originalPlaneIndex);
    case 4
        originalPoint1 = originalShape(1,:,originalPlaneIndex);
        originalPoint2 = originalShape(4,:,originalPlaneIndex);
    case 6
        originalPoint1 = originalShape(2,:,originalPlaneIndex);
        originalPoint2 = originalShape(3,:,originalPlaneIndex);
    case 8
        originalPoint1 = originalShape(3,:,originalPlaneIndex);
        originalPoint2 = originalShape(4,:,originalPlaneIndex);

end

planesWithPoint1 = findPlanesWithPoint(originalPoint1,originalShape);
planesWithPoint2 = findPlanesWithPoint(originalPoint2,originalShape);

commonPlanes = intersect(planesWithPoint1,planesWithPoint2);

% join all points of the common planes into one array and remove repeating
allPointsOfCommonPlanes=[];
for i = 1:size(commonPlanes)
    allPointsOfCommonPlanes = cat(1,allPointsOfCommonPlanes, originalShape(:,:,commonPlanes(i)));
end

uniquePointsOfCommonPlanes = allPointsOfCommonPlanes;
uniquePointsOfCommonPlanes = unique(uniquePointsOfCommonPlanes,'rows');
counts = zeros(size(uniquePointsOfCommonPlanes,1),1);
for i=1:size(counts)
    counts(i) = size(findIndicies(allPointsOfCommonPlanes,uniquePointsOfCommonPlanes(i,:)),1);
end

% counts - how many times points from uniquePoints repeat in allPoints
% only 1 or 2 in quadrilaterals
newPoint = [0 0 0];

for point=1:size(counts,1)
        w =w6(counts(point));
    newPoint = newPoint + w*uniquePointsOfCommonPlanes(point,:);
end


end

