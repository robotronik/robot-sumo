$fn=100;
use <capteurUS_HCSR04.scad>;

//new fix 2017

diam_vis=1.5;

module backplate(L,H,e){

     difference(){
	  union(){
	       translate([-2,-(H-21),0])cube([L,H,e]);
	       translate([0.85,0.85,0])cylinder(d=diam_vis+2,h=e+2);
	       translate([45-0.85,0.85,0])cylinder(d=diam_vis+2,h=e+2);
	       translate([0.85,20-0.85,0])cylinder(d=diam_vis+2,h=e+2);
	       translate([45-0.85,20-0.85,0])cylinder(d=diam_vis+2,h=e+2);
	  }
	  minkowski(){
	       translate([(45-17)/2,-3.5+0.1+21,-0.1])cube([17,3.5,e+0.2]); // not interference with header
	       cylinder(d=3,h=e+0.2);
	  }
	  // screw hole
	  translate([0.85,0.85,-0.1])cylinder(d=diam_vis,h=e+2.2);
	  translate([45-0.85,0.85,-0.1])cylinder(d=diam_vis,h=e+2.2);
	  translate([0.85,20-0.85,-0.1])cylinder(d=diam_vis,h=e+2.2);
	  translate([45-0.85,20-0.85,-0.1])cylinder(d=diam_vis,h=e+2.2);
	  minkowski(){
	  translate([(45-30)/2,21-10-H/2+3,-0.1])cube([30,10,e+0.2]); // less PLA used
	  cylinder(d=2,h=e+0.2);
	  }
     }

     // fixation backplate

     translate([-2,-(H-18),0])cube([L,3,e]);
     difference(){
	  union(){
	       translate([-2,-(H-18),-10.5])cube([5,e,10.5]);
	       translate([-7+L,-(H-18),-10.5])cube([5,e,10.5]);
	  }
	  translate([0.35,0,-7.5])rotate([90,0,0])cylinder(d=2.5,h=10);
	  translate([-4.35+L,0,-7.5])rotate([90,0,0])cylinder(d=2.5,h=10);
	  
     }
}


//capteurUS_HCSR04(100);
translate([0,0,-4])backplate();
