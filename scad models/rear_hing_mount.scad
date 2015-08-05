hinge_outer = 60;
hinge_axle = 15;
hinge_width = 82;
inner_width = 42;
extrusion=0.3;
$fn = 30;
//================================================================================
//================================================================================
module hinge_fixed(){
	difference(){
		cylinder(r=hinge_outer/2, h = hinge_width, center = true);
		cylinder(r=hinge_axle/2+extrusion, h=hinge_width, center = true);
	}


}
//================================================================================
//================================================================================
module hinge_mobile(){
	difference(){
		difference(){
			cylinder(r=hinge_outer/2, h = inner_width, center = true);
			cylinder(r=hinge_axle/2+extrusion, h=inner_width, center = true);
		}
		translate([0, -(hinge_outer/2)+(18/2), 0])
		rotate([90, 0, 0])
		cylinder(r=11+extrusion, h=18, center = true);
		
	}
}
//================================================================================
//================================================================================
module base(){
difference(){
	linear_extrude(height = hinge_width, center = true, convexity = 10){
		polygon([[0,0],[60,60],[-60,60]], convexity = 10);
	}
	union(){
		translate([50, 0, 0])
		cube(size=[20, hinge_width*2, hinge_width*2], center =true);
		translate([-50, 0, 0])
		cube(size=[20, hinge_width*2, hinge_width*2], center =true);
	
	}	
	}
	translate([0, 45+5, 0])
	cube(size=[hinge_width*2, 20, hinge_width], center = true);
}
//================================================================================
//================================================================================
module subtractions(){
	difference(){
		difference(){
			base();
			cylinder(r=hinge_axle/2+extrusion, h=hinge_width, center = true);
		}
		cylinder(r=hinge_outer/2+extrusion*2, h = inner_width, center = true);
	}
}
//================================================================================
//================================================================================
/*subtractions();
difference(){
hinge_fixed();
hinge_mobile();

}*/

hinge_mobile();
