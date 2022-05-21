@version 2.2
@warnings
@script modeler

main
{

mesh = Mesh() || error("No Object Loaded!");
VolumeOfMesh(mesh);

}


VolumeOfMesh:mesh
{

	selmode(User);

	editbegin(); 

	Vols = nil;

	foreach(polygon,polygons)
	{
	
		PolygonPointArray = nil;
		
		if(polygon.pointCount==3){
		
			PolygonData = polyinfo(polygon);

			for(n=2;n<=size(PolygonData);n++)
			{
				PointId = PolygonData[n];
				PolygonPointArray += pointinfo(PointId);
			}
			
			Vols += SignedVolumeOfTriangle(PolygonPointArray);
		
		}
		 
	}

	TheVolume = 0.0;
	
	foreach(Value,Vols){
	
		TheVolume = TheVolume + Value;
	
	}
	
	info("The Volume Is " + TheVolume + " Litres.");
	
	editend();

}



SignedVolumeOfTriangle:PolygonPointArray
{

	p1 = PolygonPointArray[1];
	p2 = PolygonPointArray[2];
	p3 = PolygonPointArray[3];
	
	convertToMeters = 10;

    v321 = (p3.x*convertToMeters)*(p2.y*convertToMeters)*(p1.z*convertToMeters);
    v231 = (p2.x*convertToMeters)*(p3.y*convertToMeters)*(p1.z*convertToMeters);
    v312 = (p3.x*convertToMeters)*(p1.y*convertToMeters)*(p2.z*convertToMeters);
    v132 = (p1.x*convertToMeters)*(p3.y*convertToMeters)*(p2.z*convertToMeters);
    v213 = (p2.x*convertToMeters)*(p1.y*convertToMeters)*(p3.z*convertToMeters);
    v123 = (p1.x*convertToMeters)*(p2.y*convertToMeters)*(p3.z*convertToMeters);

	weirdCalc = 1.0 / 6.0;
	
	valueStuff = -v321 + v231 + v312 - v132 - v213 + v123;
	
	result = weirdCalc * valueStuff;

    return result;

}