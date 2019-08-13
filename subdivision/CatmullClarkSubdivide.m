function [newShape] = CatmullClarkSubdivide(originalShape,plot)

if nargin<2
    plot = true;
end

%% 1) subdivide sides - calculate new points
newPlanePoints = divideSides(originalShape);

%% 2) recalculate points with weights
newPlanePoints = calculateNewPointsCoordinates(originalShape,newPlanePoints);

%% 3) create new sides - counting with original input cube - square side -> 4 new from original 
nPlanesOriginal = size(originalShape,3);

newShape = zeros(4,3,4*nPlanesOriginal);

for originalPlane=0:(nPlanesOriginal-1)
newShape(:,:,originalPlane*4+1) = [newPlanePoints(1,:,originalPlane+1); newPlanePoints(2,:,originalPlane+1); 
    newPlanePoints(5,:,originalPlane+1) ;newPlanePoints(4,:,originalPlane+1)];
newShape(:,:,originalPlane*4+2) = [newPlanePoints(2,:,originalPlane+1); newPlanePoints(3,:,originalPlane+1); 
    newPlanePoints(6,:,originalPlane+1); newPlanePoints(5,:,originalPlane+1)];
newShape(:,:,originalPlane*4+3) = [newPlanePoints(4,:,originalPlane+1); newPlanePoints(5,:,originalPlane+1); 
    newPlanePoints(8,:,originalPlane+1); newPlanePoints(7,:,originalPlane+1)];
newShape(:,:,originalPlane*4+4) = [newPlanePoints(5,:,originalPlane+1); newPlanePoints(6,:,originalPlane+1); 
    newPlanePoints(9,:,originalPlane+1); newPlanePoints(8,:,originalPlane+1)];
end

if(plot == false)
    return;
end

%% 4) Plot new object
nNewPlanes = size(newShape,3);

figure()
for i=1:nNewPlanes
   patch(newShape(:,1,i),newShape(:,2,i),newShape(:,3,i),'red');    
end

end

