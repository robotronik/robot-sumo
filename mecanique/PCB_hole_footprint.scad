$fn=100;

screw_diam=3;

module pcb_hole_footprint(e){
     difference(){
	  cube([70,90,3]);
	  translate([screw_diam/2+1.67,screw_diam/2+1.5,-0.1])cylinder(d=screw_diam, h=e+0.2);
	  translate([70-(screw_diam/2+1.67),screw_diam/2+1.5,-0.1])cylinder(d=screw_diam, h=e+0.2);

	  translate([screw_diam/2+1.5,90-(screw_diam/2+1.5),-0.1])cylinder(d=screw_diam, h=e+0.2);
     }
}

pcb_hole_footprint(3);
