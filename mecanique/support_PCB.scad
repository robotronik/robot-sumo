$fn=100;

use <support_moteur_v2.scad>
use <PCB_hole_footprint.scad>

clerance=0;
screw_diam=3;
module PCB_support_pillar(h,e_mot_fix,e_pillar){

     difference(){
	  union(){
	       translate([0,-2,e_mot_fix+clerance])cube([19.9,9,e_pillar]);
	       translate([0,-2-e_pillar,0])cube([19.9,e_pillar,e_mot_fix+e_pillar]);
	       
	       translate([(19.9-10)/2,-2-e_pillar,0])cube([10,e_pillar,h]);
	       translate([0,-2-e_pillar,clerance+h])cube([19.9,5.2,e_pillar]);
	       translate([0,0,clerance+h])cube([19.9/2-2,3.2,e_pillar]);
	       translate([19.9/2+2.5,0,clerance+h])cube([19.9/2-6,3.2,e_pillar]);
	  }
	  translate([2.5,3.5,-5])cylinder(d=3,h=15);
	  translate([19.9-2.4,3.5,-5])cylinder(d=3,h=15);
	  }
     
}


module equerre_fixation(lc1,lc2,L,e,diam_vis){
     // e = epaisseur / lc1 = hauteur équerre / lc2 = longueur base équerre / L = largeur équerre
     difference(){
	  cube([lc1,L,e]);
	  translate([5+1.7/2+8,L/2,-2])rotate([0,0,0])cylinder(d=diam_vis,h=7);	
	  translate([5+(20-1.7/2),L/2,-2])rotate([0,0,0])cylinder(d=diam_vis,h=7); 
     }
     difference() {
	  rotate([0,90,0])cube([lc2,L,e]);
	  translate([-6,L/2,-6])rotate([0,90,0])cylinder(d=diam_vis,h=10);

     }
     translate([5,L,0]) rotate([90,0,0])linear_extrude(height = L)polygon(
	  points=[ [0,0],[3,0],[0,-3] ],
	  paths=[ [0,1,2] ]
	  );	
}

module pcb_support(h){
     difference(){
     union(){

	  cube([6,6,h]);
	  translate([64,0,0])cube([6,6,h]);
	  translate([6,0,h-3])rotate([0,0,90])equerre_fixation(18,10,6,3,3);
	  translate([70,0,h-3])rotate([0,0,90])equerre_fixation(18,10,6,3,3);
     }
     translate([1.5+1.67,3,-0.1])cylinder(d=screw_diam,h=20.1);
     translate([70-(1.5+1.67),3,-0.1])cylinder(d=screw_diam,h=20.1);
     }
}


/*translate([39.5,2.8,0])PCB_support_pillar(60,5,3);
fixation_moteur_V2();*/
translate([0,0,5])pcb_support(20);

translate([0,0,0])pcb_hole_footprint(3);
