function [newPoint] = calculateFacePoint(originalPlane)
% Calculates the middle point of the plane.

% index is 5 
% 7 8 9
% 4 5 6
% 1 2 3

%weights
%w4 = [1/4];             %this is for quadrilaterals
% in general - we divide by nPoints

% point in the middle of plane - coords are average of the original plane
% points
nPoints = size(originalPlane,1);
newPoint = [0 0 0];
for point=1:nPoints
   newPoint = newPoint + originalPlane(point,:);
end
newPoint = newPoint/nPoints;
end

