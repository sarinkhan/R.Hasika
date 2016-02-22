include<lipoBattHolder.scad>;

//Constraints
//distance between the centers of the motor bracket screw holes
motorBracketHolesDist=18;
//distance between the center of the motor bracket hole and the edge of the robot (right and left)
motorBracketHoleDistFromEdge=8.5/2;
//motor bracket screw holes radius 
motorBracketHoleRadius=2.5/2; //2.18mm, but let's make it slightly larger

//robot wheel radius
wheelRadius=35/2;


trackY=15;



bumperCurveRadius=5;
sideWallsHeight=25;



//distance between the front and back wheels axises
distanceFrontBackWheels=85;

//how long is the plate
plateX = distanceFrontBackWheels + wheelRadius*2;

//how large is the plate
plateY=105;
//plateY=65;
//how thick is the plate
plateZ=1.5;

padding=0.2;



//top plate dimensions
topPlateX=plateX+30;
topPlateY=plateY+2*trackY;
topPlateZ=plateZ;




battX=50;
battY=70;
battZ=20;

chargerX=35;
chargerY=35;
chargerZ=15;

sensorX=15;
sensorY=22;
sensorZ=20;

idleSprocketBlockX=10;
idleSprocketBlockY=motorBracketHoleDistFromEdge*2;
idleSprocketBlockZ=10;


idleSprocketFootThickness=3;
idleSprocketFootX=motorBracketHolesDist-idleSprocketBlockX;

idleSprocketAxisZShift=5;


module charger() 
{
	translate([1*(plateX-chargerX), motorBracketHoleDistFromEdge+motorBracketHoleRadius+3,plateZ]) 
	{
		color([0, 0.5, 1 ])
		{
			cube([chargerX, chargerY, chargerZ ], center = false);
		}
	}
}

module maxbotixLVEZ() 
{
	translate([0,(plateY-sensorY)/2,plateZ]) 
	{
		color([0, 0.5, 0 ])
		{
			cube([sensorX, sensorY, sensorZ ], center = false);
		}
	}
}

module genericScrewHole() 
{
	translate([0,0,-padding/2]) 
	{
    	cylinder(r=genericHoleRadius, plateZ+padding, center = false,$fn=16);
	}
}

//radius of generic screw holes
genericHoleRadius=3/2;



//motor bracket holes
module motorBracketHole() 
{
	translate([0,0,-padding/2]) 
	{
    	cylinder(r=motorBracketHoleRadius, plateZ*3+padding, center = false,$fn=16);
	}
}





module idleSprocketBlock()
{

	difference()
	{
		translate([ plateX -wheelRadius-idleSprocketBlockX/2 , 0 ,-idleSprocketBlockZ]) 
		{
			cube([idleSprocketBlockX, idleSprocketBlockY, idleSprocketBlockZ], center = false);
		}
		translate([ plateX -wheelRadius-0 , idleSprocketBlockY+padding/2 ,-idleSprocketAxisZShift]) 
		{
			rotate([90,0,0])
			{
				cylinder(r=genericHoleRadius, idleSprocketBlockY+padding, center = false,$fn=16);
			}
			
		}
	}
}




//distance from other holes
distFromHoles=3;






module bumper()
{
translate([bumperCurveRadius,0,bumperCurveRadius])
rotate([-90,0,0])
 {
difference()
{
cylinder(r=bumperCurveRadius,h=plateY,$fn=128);
    translate([plateZ,-plateZ,plateZ])
    {
    cylinder(r=bumperCurveRadius,h=plateY-plateZ*2,$fn=128);
    }
    translate([0,-bumperCurveRadius,-1])
    cube([bumperCurveRadius*2,bumperCurveRadius*2,plateY+2]);
    
    translate([-bumperCurveRadius,-bumperCurveRadius*2,-1])
    cube([bumperCurveRadius*2,bumperCurveRadius*2,plateY+2]);
}
}
}






module sideWall(wallHeight=14)
{
difference()
{
cube([plateX-bumperCurveRadius*2,plateZ,wallHeight]);
    
    
    translate([ plateX -wheelRadius-bumperCurveRadius , idleSprocketBlockY+padding/2 ,plateZ+idleSprocketAxisZShift]) 
		{
			rotate([90,0,0])
			{
				cylinder(r=genericHoleRadius*2, idleSprocketBlockY+padding, center = false,$fn=16);
			}
			
		}
        
    translate([ wheelRadius-bumperCurveRadius , idleSprocketBlockY+padding/2 ,plateZ+idleSprocketAxisZShift]) 
		{
			rotate([90,0,0])
			{
				cylinder(r=genericHoleRadius, idleSprocketBlockY+padding, center = false,$fn=16);
			}
		}
    }
}

module frontBumperTop()
{
translate([0,0,bumperCurveRadius])
cube([bumperCurveRadius,plateZ,sideWallsHeight-bumperCurveRadius]);

translate([0,plateY-plateZ,bumperCurveRadius])
cube([bumperCurveRadius,plateZ,sideWallsHeight-bumperCurveRadius]);

translate([0,0,bumperCurveRadius])
cube([plateZ,plateY,sideWallsHeight-bumperCurveRadius]);
}


piAX=65;
piBX=85;
piBY=56;
piBZ=10;

piHolesRadius=2.75/2;
piHoleCenterDistFromEdge=3.5;
piDistFrontBackHoles=58;


module rpiPlusHoles()
{
	translate([piHoleCenterDistFromEdge,piHoleCenterDistFromEdge,-padding/2]) 
		{
			cylinder(r=piHolesRadius, h=piBZ+padding,$fn=16);
		}

		translate([piHoleCenterDistFromEdge,piBY-piHoleCenterDistFromEdge,-padding/2]) 
		{
			cylinder(r=piHolesRadius, h=piBZ+padding,$fn=16);
		}

		translate([piHoleCenterDistFromEdge+piDistFrontBackHoles,piHoleCenterDistFromEdge,-padding/2]) 
		{
			cylinder(r=piHolesRadius, h=piBZ+padding,$fn=16);
		}

		translate([piHoleCenterDistFromEdge+piDistFrontBackHoles,piBY-piHoleCenterDistFromEdge,-padding/2]) 
		{
			cylinder(r=piHolesRadius, h=piBZ+padding,$fn=16);
		}
}

//<<<<<<<<<<<<<<<<<<<<<PAYLOAD >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
module rpiBplus() 
{
	translate([0,0,plate1DistToPlate2+plateZ+topPlateZ]) 
	{
		difference()
		{
    		cube([piBX, piBY, piBZ], center = false);
			rpiPlusHoles();
		}
	
	}
}


module rpiAplus() 
{
	translate([0,0,plate1DistToPlate2+plateZ+topPlateZ]) 
	{
		difference()
		{
    		cube([piAX, piBY, piBZ], center = false);
			rpiPlusHoles();
		}
	
	}
}


unoR3X=65;
unoR3Y=53;
unoR3Z=10;

module unoR3() 
{
	translate([0,0,plate1DistToPlate2+plateZ+topPlateZ]) 
	{
    	cube([unoR3X, unoR3Y, unoR3Z], center = false);
	}
}




module payLoad()
{
//translate([topPlateX-piBX -(topPlateX-plateX)/2, -(topPlateY-plateY)/2+3,0]) 
	{
		//rpiBplus();
   }

translate([topPlateX-piBX -(topPlateX-plateX)/2, -(topPlateY-plateY)/2+3,0]) 
	{
		rpiAplus();
   }

translate([topPlateX-unoR3X -(topPlateX-plateX)/2,topPlateY-unoR3Y-(topPlateY-plateY)/2-3,0]) 
	{
unoR3();
   }
}


//<<<<<<<<<<<<<<<<<<<<<PAYLOAD END>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



module bottomPlate()
{
difference()
{
//the base plate 
    translate([bumperCurveRadius,0,0])
cube([plateX-bumperCurveRadius*2, plateY, plateZ ], center = false);

//-----------------FRONT--------------------------




//-----------------BACK--------------------------
//====LEFT====
//motor bracket left top hole
translate([plateX-wheelRadius-motorBracketHolesDist/2,motorBracketHoleDistFromEdge+plateZ+0.25,0]) 
	{motorBracketHole();}
//motor bracket left bottom hole
translate([plateX-wheelRadius+motorBracketHolesDist/2,motorBracketHoleDistFromEdge+plateZ+0.25,0]) 
	{motorBracketHole();}

//====RIGHT====
//motor bracket right top hole
translate([plateX-wheelRadius-motorBracketHolesDist/2,plateY-motorBracketHoleDistFromEdge-plateZ-0.25,0]) 
	{motorBracketHole();}
//motor bracket right bottom hole
translate([plateX-wheelRadius+motorBracketHolesDist/2,plateY-motorBracketHoleDistFromEdge-plateZ-0.25,0]) 
	{motorBracketHole();}

}
}

module fixationPillar(pillarWidth=5,pillarHeight=20,pillarScrewRadius=3/2)
{
    difference()
    {
    cube([pillarWidth,pillarWidth,pillarHeight]);
        translate([pillarWidth/2,pillarWidth/2,1])
        cylinder(r=pillarScrewRadius,h=pillarHeight,$fn=12);
    }
    
}

fixationPillarWidth1=5;
fixationPillarHeight1=sideWallsHeight;

module chassisBase1()
{
bottomPlate();
translate([plateX , 0 ,plateZ]) 
rotate([0,180,0])
idleSprocketBlock();

translate([plateX , plateY-idleSprocketBlockY ,plateZ]) 
{
    rotate([0,180,0])
	idleSprocketBlock();
}

translate([10,12.5,0])
basicBattHolder();
translate([10,13.5+battRadius*2+1 ,0])
basicBattHolder();
translate([10,14.5+battRadius*4+2 ,0])
basicBattHolder();
translate([10,15.5+battRadius*6+2 ,0])
basicBattHolder();

//front bumper
bumper();


//back bumper
rotate([0,0,180])
translate([-plateX,-plateY,0])
bumper();


translate([bumperCurveRadius,0,0])
    sideWall(sideWallsHeight);

translate([bumperCurveRadius,plateY-plateZ,0])
    sideWall(sideWallsHeight);





translate([plateZ,plateZ,bumperCurveRadius])
fixationPillar(fixationPillarWidth1,fixationPillarHeight1-bumperCurveRadius,genericHoleRadius);

translate([plateZ,plateY-plateZ-fixationPillarWidth1,bumperCurveRadius])
fixationPillar(fixationPillarWidth1,fixationPillarHeight1-bumperCurveRadius,genericHoleRadius);

translate([plateX-1-fixationPillarWidth1,plateZ,bumperCurveRadius])
fixationPillar(fixationPillarWidth1,fixationPillarHeight1-bumperCurveRadius,genericHoleRadius);

translate([plateX-1-fixationPillarWidth1,plateY-plateZ-fixationPillarWidth1,bumperCurveRadius])
fixationPillar(fixationPillarWidth1,fixationPillarHeight1-bumperCurveRadius,genericHoleRadius);

translate([plateX/2,plateZ,0])
fixationPillar(fixationPillarWidth1,fixationPillarHeight1,genericHoleRadius);

translate([plateX/2,plateY-plateZ-fixationPillarWidth1,0])
fixationPillar(fixationPillarWidth1,fixationPillarHeight1,genericHoleRadius);


frontBumperTop();

rotate([0,0,180])
translate([-plateX,-plateY,0])
frontBumperTop();

}

/*difference()
{
chassisBase1();
  translate([-1,-1,-1])  
cube([90,plateY+2,sideWallsHeight+5]);
}*/


stage2BeamsThickness=6;

module stage2LongBeamWithFixations()
{
translate([0,plateZ,sideWallsHeight])
{
    difference()
    {
        cube([plateX,stage2BeamsThickness,stage2BeamsThickness]);
        translate([plateZ+fixationPillarWidth1/2,fixationPillarWidth1/2,-padding/2])
        cylinder(r=genericHoleRadius,h=stage2BeamsThickness+padding,$fn=12);
        
        translate([plateX/2+fixationPillarWidth1/2,fixationPillarWidth1/2,-padding/2])
        cylinder(r=genericHoleRadius,h=stage2BeamsThickness+padding,$fn=12);
        
        translate([plateX-plateZ-fixationPillarWidth1/2,fixationPillarWidth1/2,-padding/2])
        cylinder(r=genericHoleRadius,h=stage2BeamsThickness+padding,$fn=12);
    }
    
}
}

piUsbKeyDecal=12;
stage2TracksOverhangWidth=15;
piBeamY=60;

module stage2BaseFrame()
{


stage2LongBeamWithFixations();
translate([0,plateY-stage2BeamsThickness-plateZ*2,0])
stage2LongBeamWithFixations();

translate([0,plateZ+stage2BeamsThickness,sideWallsHeight])
    cube([stage2BeamsThickness,plateY-stage2BeamsThickness*2-plateZ*2,stage2BeamsThickness]);

translate([plateX-stage2BeamsThickness,plateZ+stage2BeamsThickness,sideWallsHeight])
    cube([stage2BeamsThickness,plateY-stage2BeamsThickness*2-plateZ*2,stage2BeamsThickness]);

translate([plateX/2,plateZ+stage2BeamsThickness,sideWallsHeight])
    cube([stage2BeamsThickness,plateY-stage2BeamsThickness*2-plateZ*2,stage2BeamsThickness]);

}

module raspiBeamsWithHoles()
{
    difference()
{
union()
{
translate([piUsbKeyDecal+0.5,plateZ+stage2BeamsThickness,sideWallsHeight])
    cube([stage2BeamsThickness,piBeamY,stage2BeamsThickness]);

translate([piUsbKeyDecal+piDistFrontBackHoles+0.5,plateZ+stage2BeamsThickness,sideWallsHeight])
    cube([stage2BeamsThickness,piBeamY,stage2BeamsThickness]);
}

translate([piUsbKeyDecal,stage2BeamsThickness,sideWallsHeight])
 rpiPlusHoles();
}
}

contactSwitchScrew1DecalY=24.5;
contactSwitchScrew2DecalX=12.8;
contactSwitchScrewDecal2=2.7;
contactSwitchScrewsRadius=3/2;


lipoChargerHolesDistFromBorder=2.5;
lipoChargerHolesRadius=2/2;
lipoChargerX=35;
lipoChargerY=35;
lipoChargerDecalX=1;

module stage2Frame2()
{
    stage2BaseFrame();
    raspiBeamsWithHoles();
    
    translate([lipoChargerX-stage2BeamsThickness/2-lipoChargerDecalX,plateY-plateZ- stage2BeamsThickness-lipoChargerX,sideWallsHeight])
    cube([stage2BeamsThickness,lipoChargerX,stage2BeamsThickness]);
    
    translate([0,plateY-plateZ-stage2BeamsThickness-lipoChargerX-lipoChargerDecalX,sideWallsHeight])
    cube([plateX/2+stage2BeamsThickness+piUsbKeyDecal-2,stage2BeamsThickness,stage2BeamsThickness]);
    
}


sensorsPlateFixationDecal1Y=40;
sensorsPlateFixationDecal2X=35;

batteryHolderFixationHolesDecalY=27;

middleBeamHolesDist=10;

beamHolesYDecal=0.5;
lateralCoverFixationHolesXDecal1=2;


module stage2StructureWithHoles()
{
difference()
{
stage2Frame2();
    
    translate([plateX-contactSwitchScrew2DecalX,contactSwitchScrewDecal2+plateZ,sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    
    translate([plateX-contactSwitchScrewDecal2,contactSwitchScrew1DecalY+plateZ,sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    
    translate([plateX-contactSwitchScrew2DecalX,plateY-contactSwitchScrewDecal2-plateZ,sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    
    translate([plateX-contactSwitchScrewDecal2, plateY-contactSwitchScrew1DecalY-plateZ, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    
    //lipo charger holes
    translate([lipoChargerHolesDistFromBorder+lipoChargerDecalX,plateY-plateZ-stage2BeamsThickness-lipoChargerHolesDistFromBorder,sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=lipoChargerHolesRadius,h=stage2BeamsThickness*2,$fn=16);
    
    
    translate([lipoChargerHolesDistFromBorder+lipoChargerDecalX,plateY-plateZ-stage2BeamsThickness-lipoChargerY+lipoChargerHolesDistFromBorder,sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=lipoChargerHolesRadius,h=stage2BeamsThickness*2,$fn=16);
    
     translate([lipoChargerX+lipoChargerDecalX-lipoChargerHolesDistFromBorder,plateY-plateZ-stage2BeamsThickness-lipoChargerHolesDistFromBorder,sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=lipoChargerHolesRadius,h=stage2BeamsThickness*2,$fn=16);
    
    
    translate([lipoChargerX+lipoChargerDecalX-lipoChargerHolesDistFromBorder,plateY-plateZ-stage2BeamsThickness-lipoChargerY+lipoChargerHolesDistFromBorder,sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=lipoChargerHolesRadius,h=stage2BeamsThickness*2,$fn=16);
    //end lipo charger holes
    
    //sensorsPlateFixationHoles
    translate([plateX-stage2BeamsThickness/2, plateY-sensorsPlateFixationDecal1Y-plateZ, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    
    translate([plateX-stage2BeamsThickness/2, sensorsPlateFixationDecal1Y+plateZ, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    
    
    translate([plateX-stage2BeamsThickness/2-sensorsPlateFixationDecal2X, plateZ+stage2BeamsThickness/2-beamHolesYDecal, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    
    translate([plateX-stage2BeamsThickness/2-sensorsPlateFixationDecal2X, plateY-plateZ-stage2BeamsThickness/2-beamHolesYDecal, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    //end sensorsPlateFixationHoles
    
    
    //batteryHolderHoles
    translate([plateX/2+stage2BeamsThickness/2, plateY-plateZ-stage2BeamsThickness/2-batteryHolderFixationHolesDecalY, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    
    translate([plateX/2+stage2BeamsThickness/2, plateZ+stage2BeamsThickness/2+batteryHolderFixationHolesDecalY, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    //end batteryHolderHoles
    
    
    
    //batteryCharger2SupportFixationHoles
     translate([lipoChargerX-1, plateY-plateZ-stage2BeamsThickness/2-beamHolesYDecal, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    
     translate([lipoChargerX-1+5, plateY-plateZ-stage2BeamsThickness/2-lipoChargerY-1, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    
     translate([stage2BeamsThickness/2, plateY-plateZ-stage2BeamsThickness/2-lipoChargerY-1-6, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    //end batteryCharger2SupportFixationHoles
    
    
    
    //extraStageFixations
    translate([plateX/2+stage2BeamsThickness/2, plateY-plateZ-stage2BeamsThickness/2-lipoChargerX-1, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    
    translate([plateX/2+stage2BeamsThickness/2-middleBeamHolesDist, plateY-plateZ-stage2BeamsThickness/2-lipoChargerX-1, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    
     translate([lipoChargerX-1, plateZ+stage2BeamsThickness/2-beamHolesYDecal, sideWallsHeight-stage2BeamsThickness/2])
    cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    //end extraStageFixations
    
    
    
    
    
    //top cover lateral fixation holes LEFT
    translate([stage2BeamsThickness+lateralCoverFixationHolesXDecal1, plateZ-stage2BeamsThickness/2-beamHolesYDecal, sideWallsHeight+stage2BeamsThickness/2])
    rotate([-90,0,0])
    {cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    }
    
    translate([plateX/2-lateralCoverFixationHolesXDecal1, plateZ-stage2BeamsThickness/2-beamHolesYDecal, sideWallsHeight+stage2BeamsThickness/2])
    rotate([-90,0,0])
    {cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    }
    
    translate([plateX-stage2BeamsThickness-lateralCoverFixationHolesXDecal1, plateZ-stage2BeamsThickness/2-beamHolesYDecal, sideWallsHeight+stage2BeamsThickness/2])
    rotate([-90,0,0])
    {cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    }
    //end top cover lateral fixation holes LEFT
    
    
        //top cover lateral fixation holes RIGHT
    translate([stage2BeamsThickness+lateralCoverFixationHolesXDecal1,plateY-stage2BeamsThickness*2, sideWallsHeight+stage2BeamsThickness/2])
    rotate([-90,0,0])
    {cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    }
    
    translate([plateX/2-lateralCoverFixationHolesXDecal1, plateY-stage2BeamsThickness*2, sideWallsHeight+stage2BeamsThickness/2])
    rotate([-90,0,0])
    {cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    }
    
    translate([plateX-stage2BeamsThickness-lateralCoverFixationHolesXDecal1, plateY-stage2BeamsThickness*2, sideWallsHeight+stage2BeamsThickness/2])
    rotate([-90,0,0])
    {cylinder(r=contactSwitchScrewsRadius,h=stage2BeamsThickness*2,$fn=16);
    }
    //end top cover lateral fixation holes RIGHT
}
}


//chassisBase1();
stage2StructureWithHoles();






