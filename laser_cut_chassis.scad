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



//distance between the front and back wheels axises
distanceFrontBackWheels=85;

//how long is the plate
plateX = distanceFrontBackWheels + wheelRadius*2;

//how large is the plate
plateY=100;

//how thick is the plate
plateZ=5;

padding=0.2;



//top plate dimensions
topPlateX=plateX+30;
topPlateY=plateY+2*trackY;
topPlateZ=plateZ;

//cut to pass the motor Wire
motorWireCutX=4;
motorWireCutY=15;


battX=50;
battY=70;
battZ=20;

chargerX=35;
chargerY=35;
chargerZ=15;

sensorX=15;
sensorY=22;
sensorZ=20;

module battery() 
{
	translate([sensorX+1,(plateY-battY)/2,plateZ]) 
	{
		color([0, 0, 1 ])
		{
			cube([battX, battY, battZ ], center = false);
		}
	}
}

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

module beamScrewHole() 
{
	translate([0,0,-padding/2]) 
	{
    	cylinder(r=genericHoleRadius, beamledgeThickness+padding, center = false,$fn=16);
	}
}



//radius of generic screw holes
genericHoleRadius=3/2;
//this defines how far from the border the holes for the screws holding the second layer support beams must be
layer2BeamScrewHolesDistFromBorder=5;






//motor bracket holes
module motorBracketHole() 
{
	translate([0,0,-padding/2]) 
	{
    	cylinder(r=motorBracketHoleRadius, plateZ+padding, center = false,$fn=16);
	}
}

//motor bracket holes
module wirePassTrough1() 
{
	translate([0,0,-padding/2]) 
	{
    	cube([motorWireCutX, motorWireCutY, plateZ+padding], center = false);
	}
}

module wirePassTrough2() 
{
	translate([0,0,-padding/2]) 
	{
    	cube([motorWireCutY, motorWireCutX, plateZ+padding], center = false);
	}
}





//Support beams





module beamFoot()
{
	difference()
		{
			translate([ -beamScrewLedgeLength, 0 ,0]) 
			{
				cube([beamScrewLedgeLength, motorWireCutX+2*beamWallsThickness, beamledgeThickness], center = false);
			}

			//slope for easy printing
			translate([ -2*beamScrewLedgeLength, -padding/2 ,4.5]) 
			{
				rotate([ 0, 45 ,0]) 
				{
					cube([beamScrewLedgeLength, motorWireCutX+2*beamWallsThickness+padding, beamledgeThickness*1.5], center = false);
				}
			}

			translate([ (-beamScrewLedgeLength)/2,( motorWireCutX+2*beamWallsThickness)/2 ,0]) 
			{
				beamScrewHole();
			}
		}
}



plate1DistToPlate2=30;

beamWallsThickness=2;
beamScrewLedgeLength=6;
beamledgeThickness=8;


totalBeamX=beamWallsThickness*2+motorWireCutY+2*beamScrewLedgeLength;
totalBeamY=beamWallsThickness*2+motorWireCutX;

beamWireCutRadius=2/3*(beamWallsThickness+motorWireCutY)/2;


module supportBeam()
{
	translate([ beamScrewLedgeLength, 0 ,plateZ]) 
	{
		difference()
		{
			cube([motorWireCutY+2*beamWallsThickness, motorWireCutX+2*beamWallsThickness, plate1DistToPlate2], center = false);

			translate([ (beamWallsThickness), beamWallsThickness ,-padding/2]) 
			{
				cube([motorWireCutY, motorWireCutX, plate1DistToPlate2+padding], center = false);
			}

			
			
			translate([(beamWallsThickness*2+motorWireCutY)/2, totalBeamY+padding/2 ,beamledgeThickness]) 
			{
				rotate([90,0,0])
				{
					cylinder(r=beamWireCutRadius, totalBeamY+padding, center = false,$fn=32);
				}
			}

			translate([(beamWallsThickness*2+motorWireCutY)/2, totalBeamY+padding/2 ,plate1DistToPlate2-beamledgeThickness]) 
			{
				rotate([90,0,0])
				{
					cylinder(r=beamWireCutRadius, totalBeamY+padding, center = false,$fn=32);
				}
			}

		}


		beamFoot();
		translate([ (motorWireCutY+2*beamWallsThickness), 0 ,0]) 
			{
				mirror([1,0,0])
				{
					beamFoot();
				}
			}

		translate([ 0, 0 ,plate1DistToPlate2]) 
			{
				
				mirror([0,0,1])
				{
					beamFoot();
				}
			}


		translate([ (motorWireCutY+2*beamWallsThickness), 0 ,plate1DistToPlate2]) 
			{
				mirror([0,0,1])
				{
					mirror([1,0,0])
					{
						beamFoot();
					}
				}
			}

	}
}



idleSprocketBlockX=10;
idleSprocketBlockY=motorBracketHoleDistFromEdge*2;
idleSprocketBlockZ=10;


idleSprocketFootThickness=3;
idleSprocketFootX=motorBracketHolesDist-idleSprocketBlockX;


module idleSprocketBlock()
{

	difference()
	{
		translate([ plateX -wheelRadius-idleSprocketBlockX/2 , 0 ,-idleSprocketBlockZ]) 
		{
			cube([idleSprocketBlockX, idleSprocketBlockY, idleSprocketBlockZ], center = false);
		}
		translate([ plateX -wheelRadius-0 , idleSprocketBlockY+padding/2 ,-plateZ]) 
		{
			rotate([90,0,0])
			{
				cylinder(r=genericHoleRadius, idleSprocketBlockY+padding, center = false,$fn=16);
			}
			
		}
	}

	difference()
	{
		translate([ plateX -wheelRadius-idleSprocketBlockX/2-idleSprocketFootX , 0 ,-idleSprocketFootThickness]) 
		{
			cube([idleSprocketFootX, idleSprocketBlockY, idleSprocketFootThickness], center = false);
		}
		translate([ plateX -wheelRadius-idleSprocketBlockX/2-idleSprocketFootX/2 , idleSprocketBlockY/2 ,-idleSprocketFootThickness]) 
		{
			motorBracketHole();
		}
	}

	difference()
	{
		translate([ plateX -wheelRadius+idleSprocketBlockX/2 , 0 ,-idleSprocketFootThickness]) 
		{
			cube([idleSprocketFootX, idleSprocketBlockY, idleSprocketFootThickness], center = false);
		}


		translate([ plateX -wheelRadius+idleSprocketBlockX/2+idleSprocketFootX/2 , idleSprocketBlockY/2 ,-idleSprocketFootThickness]) 
		{
			motorBracketHole();
		}
	}
}

idleSprocketBlock();

translate([0 , plateY-idleSprocketBlockY ,0]) 
{
	idleSprocketBlock();
}

//distance from other holes
distFromHoles=3;



//real values :
//servoX=22.8;
//servoY=12.6;

servoY=23;
servoX=13;

//<<<<<<<<<<<<<<<<<<<<<TOP PLATE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
module topPlate()
{
difference()
{
	translate([ -(topPlateX - plateX)/2 , -(topPlateY - plateY)/2, plate1DistToPlate2+plateZ]) 
	{
		color([0,1,0])
		{
			cube([topPlateX, topPlateY, topPlateZ ], center = false);
		}
	}

	translate([ 0, 0, plate1DistToPlate2+plateZ]) 
	{
		beamsCuts();
	}

	translate([ -(topPlateX-plateX)/2+5, plateY/2-servoY/2, plate1DistToPlate2+plateZ-padding/2]) 
	{
		cube([servoX, servoY, topPlateZ+padding ], center = false);
	}


	//holes for a raspi B+
	translate([topPlateX-piBX -(topPlateX-plateX)/2, -(topPlateY-plateY)/2+3,0]) 
	{
		translate([0,0,plate1DistToPlate2+plateZ]) 
		{
			rpiPlusHoles();
		}
   }

	//holes for a raspi A+
	translate([topPlateX-piBX -(topPlateX-plateX)/2, -(topPlateY-plateY)/2+3,0]) 
	{
		translate([15,0,plate1DistToPlate2+plateZ]) 
		{
			rpiPlusHoles();
		}
   }

}
}
//<<<<<<<<<<<<<<<<<<<<<TOP PLATE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


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

module beamsCuts()
{
//LEFT BEAM HOLES
//left front beam: top screw hole
translate([ (wheelRadius+motorBracketHolesDist/2+motorBracketHoleRadius+distFromHoles+beamScrewLedgeLength/2), totalBeamY/2 ,0]) 
	{
		genericScrewHole();
	}
//left front beam: bottom screw hole
translate([ (wheelRadius + motorBracketHolesDist/2 + motorBracketHoleRadius + distFromHoles + totalBeamX-beamScrewLedgeLength/2), totalBeamY/2 ,0]) 
	{
		genericScrewHole();
	}
//RIGH BEAM HOLES
//right front beam: top screw hole
translate([ (wheelRadius+motorBracketHolesDist/2+motorBracketHoleRadius+distFromHoles+beamScrewLedgeLength/2), plateY-totalBeamY/2 ,0]) 
	{
		genericScrewHole();
	}
//right front beam: bottom screw hole
translate([ (wheelRadius + motorBracketHolesDist/2 + motorBracketHoleRadius + distFromHoles + totalBeamX-beamScrewLedgeLength/2), plateY-totalBeamY/2 ,0]) 
	{
		genericScrewHole();
	}
//BACK BEAM HOLES
//back beam: top screw hole
translate([ (plateX-totalBeamX+beamScrewLedgeLength/2), plateY/2 ,0]) 
	{
		genericScrewHole();
	}
//back beam: bottom screw hole
translate([ (plateX-beamScrewLedgeLength/2), plateY/2 ,0]) 
	{
		genericScrewHole();
	}

//beam cuts to pass wires
//top left
translate([wheelRadius+motorBracketHolesDist/2+motorBracketHoleRadius+distFromHoles+beamScrewLedgeLength+beamWallsThickness,  beamWallsThickness,0]) 
	{
		wirePassTrough2();
	}
//top right
translate([wheelRadius+motorBracketHolesDist/2+motorBracketHoleRadius+distFromHoles+beamScrewLedgeLength+beamWallsThickness,  plateY-beamWallsThickness-motorWireCutX,0]) 
	{
		wirePassTrough2();
	}
//bottom
translate([plateX-totalBeamX + beamWallsThickness + beamScrewLedgeLength, plateY/2-totalBeamY/2 + beamWallsThickness,0]) 
	{
		wirePassTrough2();
	}

}

//<<<<<<<<<<<<<<<<<<<<<PAYLOAD END>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
module bottomPlate()
{
difference()
{
//the base plate 
cube([plateX, plateY, plateZ ], center = false);


translate([3*sensorX/4,plateY/2-sensorY/2-5,0]) 
{
    	genericScrewHole();
}
translate([3*sensorX/4,plateY/2+sensorY/2+5,0]) 
{
    	genericScrewHole();
}


//-----------------FRONT--------------------------
//====LEFT====
//motor bracket left top hole
translate([wheelRadius-motorBracketHolesDist/2,motorBracketHoleDistFromEdge,0]) 
	{motorBracketHole();}
//motor bracket left bottom hole
translate([wheelRadius+motorBracketHolesDist/2,motorBracketHoleDistFromEdge,0]) 
	{motorBracketHole();}

//====RIGHT====
//motor bracket right top hole
translate([wheelRadius-motorBracketHolesDist/2,plateY-motorBracketHoleDistFromEdge,0]) 
	{motorBracketHole();}
//motor bracket right bottom hole
translate([wheelRadius+motorBracketHolesDist/2,plateY-motorBracketHoleDistFromEdge,0]) 
	{motorBracketHole();}


//-----------------BACK--------------------------
//====LEFT====
//motor bracket left top hole
translate([plateX-wheelRadius-motorBracketHolesDist/2,motorBracketHoleDistFromEdge,0]) 
	{motorBracketHole();}
//motor bracket left bottom hole
translate([plateX-wheelRadius+motorBracketHolesDist/2,motorBracketHoleDistFromEdge,0]) 
	{motorBracketHole();}

//====RIGHT====
//motor bracket right top hole
translate([plateX-wheelRadius-motorBracketHolesDist/2,plateY-motorBracketHoleDistFromEdge,0]) 
	{motorBracketHole();}
//motor bracket right bottom hole
translate([plateX-wheelRadius+motorBracketHolesDist/2,plateY-motorBracketHoleDistFromEdge,0]) 
	{motorBracketHole();}



//======================MOTOR WIRES PASS-TROUGH HOLES===========================

/*
translate([wheelRadius+motorBracketHolesDist,motorBracketHoleDistFromEdge*2,0]) 
	{wirePassTrough1();}

translate([wheelRadius+motorBracketHolesDist,plateY-motorBracketHoleDistFromEdge*2 -motorWireCutY,0]) 
	{wirePassTrough1();}
*/
translate([wheelRadius-motorBracketHolesDist/2-motorWireCutX -2*motorBracketHoleRadius,motorBracketHoleDistFromEdge*2,0]) 
	{wirePassTrough1();}

translate([wheelRadius-motorBracketHolesDist/2-motorWireCutX -2*motorBracketHoleRadius, plateY-motorBracketHoleDistFromEdge*2 -motorWireCutY,0]) 
	{wirePassTrough1();}

	





translate([plateX-max (wheelRadius-motorBracketHolesDist/2-motorWireCutX-2*motorBracketHoleRadius,chargerX+5),motorBracketHoleDistFromEdge*2,0]) 
	{wirePassTrough1();}

translate([plateX-max (wheelRadius-motorBracketHolesDist/2-motorWireCutX-2*motorBracketHoleRadius,chargerX+5), (plateY-motorBracketHoleDistFromEdge*2-motorWireCutY), 0]) 
	{wirePassTrough1();}


beamsCuts();

}
}


bottomPlate();

topPlate();

payLoad();



maxbotixLVEZ();
battery();
charger();


//left front beam
translate([ (wheelRadius+motorBracketHolesDist/2+motorBracketHoleRadius+distFromHoles), 0 ,0]) 
	{
		supportBeam(center = true);
	}
//right front beam
translate([ (wheelRadius+motorBracketHolesDist/2+motorBracketHoleRadius+distFromHoles), plateY-totalBeamY ,0]) 
	{
		supportBeam(center = true);
	}
//back center beam
translate([ plateX-totalBeamX, plateY/2-totalBeamY/2 ,0]) 
	{
		supportBeam(center = true);
	}




