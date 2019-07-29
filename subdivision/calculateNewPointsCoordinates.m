function [newPlanePoints] = calculateNewPointsCoordinates(originalShape,newPlanePoints)
%Recalculates point coordinates after division. Specialized on
%quadrilaterals.

% newPlanePoints - [n,m,p] 
%n - number of points after division (original quad->9)
%m = 3 - x,y,z
%p - original number of planes (cube - 6)

%Let's consider cube for better imaginations
% newPlanePoints are in this order
% 7 8 9
% 4 5 6
% 1 2 3
% 
%where 1 3 7 9 are VertexPoints.
%each point have different weight for recalculation, depending if it is
%edge point ( 2 4 6 8), vertex (1 3 7 9) or point in the middle of plane
%(5)

% Points 1 3 7 9 are original, and are recalculated from sides, which share
% this point

% Points 2 4 6 8 are in the middle of original edges, and are recalculated 
%from sides, which share this edge

% Point 5 is int he middle of original side, is recalculated without need
% of another side 

nPlanes = size(newPlanePoints,3);                

for plane=1:nPlanes
    nPoints = size(newPlanePoints,1);
    for pointIndex=1:nPoints
        if(pointIndex == 5)
            % i pass only the original side
            newPlanePoints(pointIndex,:,plane)= calculateFacePoint(originalShape(:,:,plane));
        else if (pointIndex == 2 || pointIndex == 4 || pointIndex==6 || pointIndex==8)
                % recalculate points with 2 sides
                newPlanePoints(pointIndex,:,plane) = calculateEdgePoint(originalShape,plane,pointIndex);
            else
                %recalculate points with n sides, which share the point (cube - max 3)
                newPlanePoints(pointIndex,:,plane) = calculateVertex(originalShape,plane,pointIndex);
            end
        end
        
    end
       
    
end


end

