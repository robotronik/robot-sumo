$fn=100;
use <moteur.scad>;


module power_train(fn){

translate([39, 0, 0]) union(){
    translate([-27.5, 0, 0]) rotate([0, -90, 0]) roue(fn);

    rotate([180,0,0])moteur(fn);
}

translate([70, 0, 0]) mirror([1, 0, 0]) union(){
    translate([-27.5, 0, 0]) rotate([0, -90, 0]) roue(fn);

    rotate([180,0,0])moteur(fn);
}
}



module equerre_fixation_moteur(lc1,lc2,L,e,diam_vis){
	 // e = epaisseur
	difference(){
		cube([lc1,L,e]);
		translate([11.2,L/2,-2])cylinder(d=diam_vis,h=7);	
	}
	difference() {
		rotate([0,90,0])cube([lc2,L,e]);
		translate([-6,L/2,-4])rotate([0,90,0])cylinder(d=diam_vis,h=10);
		//translate([-6,L/2,-8.5])rotate([0,90,0])cylinder(d=diam_vis,h=10);
	}
	translate([0,L,0]) rotate([90,0,0])linear_extrude(height = L)polygon(
		points=[ [0,0],[3.5,0],[0,-2.5] ],
		paths=[ [0,1,2] ]
	);	
}



module fixation_moteur_V2(){
	translate([30,8.8,3])union(){
		translate([8,-5,0])rotate([0,-90,0])equerre_fixation_moteur(15,7,5,2,3);
		rotate([0,-90,180])equerre_fixation_moteur(15,7,5,2,3);
	}
	translate([61,8.8,3])union(){
		translate([8,-5,0])rotate([0,-90,0])equerre_fixation_moteur(15,7,5,2,3);
		rotate([0,-90,180])equerre_fixation_moteur(15,7,5,2,3);
	}
	translate([75.4,35.8,5])fixation_moteur_1_V2(5);
}


module fixation_moteur_1_V2(e){
	difference(){
		union(){
			translate([-22.5,-25,0])cube([2,35,25]);
			translate([-52.5,-33,-e])cube([53.2,44,e]);
			translate([-31.5,-25,0])cube([2,35,25]);
			translate([-52.5,-25,0])cube([1.5,35,25]);
			translate([-0.8,-25,0])cube([1.5,35,25]);
		}
		translate([-22.6,-25.1,12.1])minkowski(){
			cube([1.1,20,17]);
			rotate([0,90,0])cylinder(d=4,h=1.1);
		}
		translate([-31.6,-25.1,12.1])minkowski(){
			cube([1.1,20,17]);
			rotate([0,90,0])cylinder(d=4,h=1.1);
		}
		translate([-52.6,-24.5,6.1])minkowski(){
		     cube([1.1,21.5,19]);
		     rotate([0,90,0])cylinder(d=4,h=1.1);
		}
		translate([-1,-24.5,6.1])minkowski(){
		     cube([1.1,21.5,19]);
		     rotate([0,90,0])cylinder(d=4,h=1.1);
		}
	translate([-55.7,4.5,20.4])rotate([0,90,0])cylinder(d=3,h=60);

	translate([-29.5+3.5,-26.5+3+2,-10])cylinder(d=3,h=25);
	translate([-29.5+3.5,-26.5+3+13.5,-10])cylinder(d=3,h=25);
	translate([-29.5+3.5,-26.5+3+13.5+11.5,-10])cylinder(d=3,h=25);
	
	translate([-49.4,-29.5,-7.5])cylinder(d=3,h=10);
	translate([-33.4,-29.5,-7.5])cylinder(d=3,h=10);
	translate([-18.4,-29.5,-7.5])cylinder(d=3,h=10);
	translate([-2.4,-29.5,-7.5])cylinder(d=3,h=10);
	
	}

}

	//translate([-4.5,25,16.2])power_train(50);


//fixation_moteur_1_V2();

translate([0.5,5,0])fixation_moteur_V2();
