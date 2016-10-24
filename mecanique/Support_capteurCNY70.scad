$fn =100;
use <capteur_CNY70.scad>;

module support_CNY70(L,H){
	difference(){
		translate([0,0,3.8])cube([L,L,6.2]);
		union(){
			translate([(L-(L-1.9))/2,(L-(L-1.9))/2,3])cube([L-1.9,L-1.9,6.5]);
			translate([(L-(L-4))/2,(L-(L-4))/2,10-0.6])cube([L-4,L-4,0.7]);
		}
	}
	difference(){
		union(){
			translate([-5,(L-5)/2,-H+10])cube([5,5,H]);
			translate([L,(L-5)/2,-H+10])cube([5,5,H]);
		}
		translate([-1.5-1,(L-3)/2+1.5,-H+9.5])cylinder(d=3,h=H+1);
		translate([+1.5+1+L,(L-3)/2+1.5,-H+9.5])cylinder(d=3,h=H+1);
		
	}
	translate([(L-0.5)/2,0.95,4])cube([0.5,0.5,6]);
	translate([(L-0.5)/2,L-0.95-0.5,4])cube([0.5,0.5,6]);	
}

module fix_CNY70(L){
	difference(){
		#cube([L,L,0.5]);
		translate([(L-5)/2,(L-5)/2,-.1])cube([5,5,0.7]);
	}
}
mirror([0,0,1])support_CNY70(9.5,10);
//mirror([0,0,1])translate([1.25,1.25,3])CNY70();
//translate([0,0,-2.8])fix_CNY70(8.7);
// hauteur base : 19.5mm avant et 22mm à l'arrière(
