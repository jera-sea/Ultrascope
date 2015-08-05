open_beam = 15; //open beam dimensions (square)
perspex_width = 5;
bearing_od = 22;
bearing_id = 8;
hole_space = 65.673;//hole spacing on perspex round plate
hole_to_front_edge = 13;
r_corners = 3;
plate_thickness = 4;
extrusion=0.3;

//variables for thingiverse obtained cylinder rounding tool
pad = 0.1;	// Padding to maintain manifold
ch = 15;
cr = 25;
ct = 1;
r = 10;
smooth = 180;	// Number of facets of rounding cylinder

//variables for edge fillet
b = 13;
h = 20;
w = 90*0.5888888+r_corners;

//===========================================================================================
//===========================================================================================

module plate_fixture(length, thickness){
	difference(){
		hull(){
			translate([length/2, (length*0.5888)/2, 0])cylinder(r=r_corners, h=thickness, $fn=15);
			translate([-length/2, (length*0.5888)/2, 0])cylinder(r=r_corners, h=thickness, $fn=15);
			translate([-(length*0.722)/2, -(length*0.5888)/2, 0])cylinder(r=r_corners, h=thickness, $fn=15);
			translate([(length*0.722)/2, -(length*0.5888)/2, 0])cylinder(r=r_corners, h=thickness, $fn=15);

		}
		union(){
			translate([(hole_space)/2-1.6, (length*0.5888)/2-13+r_corners, -1])cylinder(r=1.6+extrusion, h=thickness+2, $fn=15);
			translate([(-hole_space)/2+1.6, (length*0.5888)/2-13+r_corners, -1])cylinder(r=1.6+extrusion, h=thickness+2, $fn=15);
			translate([(hole_space)/2-1.6, -(length*0.5888)/2+13-r_corners, -1])cylinder(r=1.6+extrusion, h=thickness+2, $fn=15);
			translate([(-hole_space)/2+1.6, -(length*0.5888)/2+13-r_corners, -1])cylinder(r=1.6+extrusion, h=thickness+2, $fn=15);
		}
	}
}
//===========================================================================================
//===========================================================================================
module bearing_slot(od, id, width, length){
	rotate([90,0,0])
	translate([0, -plate_thickness/2, -(length*0.5888)/2-r_corners])
	//difference(){
		cylinder(d=od+extrusion, h=width*2+1);
		//cylinder(d=id, h=width);
	//}
}
//===========================================================================================
//===========================================================================================
module reinforcement(length){
	rotate([90,0,0])
	translate([0, -plate_thickness/2, -(length*0.5888)/2-r_corners])
	cylinder(r=23.5, h=(length*0.5888)+2*r_corners);
	}
	//===========================================================================================
//===========================================================================================
module top_half(){
translate([0, 0, -100])
cube(size=[200, 200, 200], center=true);

}
//===========================================================================================
//===========================================================================================
module bot_half(){
translate([0, 0, 100])
cube(size=[200, 200, 200], center=true);

}
//===========================================================================================
//===========================================================================================
module cylinder_fillet(){
// Inside Fillet
translate([0, -90*0.65/2, 0])
rotate([-90, 0, 0])
difference() {
	rotate_extrude(convexity=10,  $fn = smooth)
		translate([cr-ct-r+pad,ct-pad,0])
			square(r+pad,r+pad);
	rotate_extrude(convexity=10,  $fn = smooth)
		translate([cr-ct-r,ct+r,0])
			circle(r=r,$fn=smooth);
}


}
//===========================================================================================
//===========================================================================================
module edge_fillet(){
	//Start with an extruded triangle

	rotate(a=[90,-90,0])
		difference(){
			linear_extrude(height = w, center = true, convexity = 10, twist = 0)
				polygon(points=[[0,0],[h,0],[0,b]], paths=[[0,1,2]]);
			translate([h-1, b-1, -w/2])cylinder(r=15, h=w, $fn=30);
		}

}
//===========================================================================================
//===========================================================================================
	
difference(){	
difference(){
	union(){
		translate([0, 0, -5-plate_thickness])plate_fixture(90-2*r_corners);
		plate_fixture(90-2*r_corners, plate_thickness);
		//difference(){
			reinforcement(90-2*r_corners);
			//cylinder_fillet();
		//}
	}
	bearing_slot(bearing_od, bearing_id, 7, 90-2*r_corners);

}
top_half();
}

intersection(){
plate_fixture(90-2*r_corners, 20);
translate([-20, 0, -0.2])
edge_fillet();
}
intersection(){
plate_fixture(90-2*r_corners, 20);
rotate([0, 0, 180])
translate([-20, 0, -0.2])
edge_fillet();
}





