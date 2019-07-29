function [newPlanePoints] = divideSides(originalShape)
% Divides given side but now specialized only on quadrilaterals

planePoints = size(originalShape(:,:,1),1);     %how many points per side original
nPlanes = size(originalShape,3);                %how many sides
newPlanePoints = [];                            %final array

for plane=1:nPlanes
currentPlane = originalShape(:,:,plane);
tempPlanePoints = zeros(planePoints*planePoints,3);
   
%divide sides first and then the middle point is average of the middle sides

k = 1;
for planePoint= 1:planePoints
    for otherPlanePoint= 1:planePoints
        tempPlanePoints(k,1)=  (currentPlane(planePoint,1) + currentPlane(otherPlanePoint,1))/2;   %x
        tempPlanePoints(k,2)= (currentPlane(planePoint,2) + currentPlane(otherPlanePoint,2))/2;    %y
        tempPlanePoints(k,3)= (currentPlane(planePoint,3) + currentPlane(otherPlanePoint,3))/2;    %z
        k = k+1;
    end
end
%  if sides are parallel, points 8 and 9 are equal,(also 3=8=9=14). In general, these
%  points are not equal - these are the diagonal divisions. So to find
%  the "middle" point, we take average of 8 and 9. For dividing square, no
%  change.

%this only aplies for quadrilaterals
newMiddle = (tempPlanePoints(8,:) + tempPlanePoints(9,:))/2;
tempPlanePoints(8,:) = newMiddle(:);   
tempPlanePoints(9,:) = newMiddle(:);  
tempPlanePoints(3,:) = newMiddle(:);   
tempPlanePoints(14,:) = newMiddle(:);  

newPlanePoints = cat(3,newPlanePoints,unique(tempPlanePoints,'rows')); %remove redundant

end

end

