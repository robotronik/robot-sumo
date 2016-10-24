$fn=100;

module wheel_spacer(){
     difference(){
	 translate([-3,0,0])rotate([0,90,0])cylinder(d=10,h=2);
	 axe();
     }
}

module axe(){
 color("white") union(){
            intersection(){
                cube([8.9, 6.15, 4.5], center = true);
                rotate([0, 90, 0]) cylinder(h=8.9, d=6.15, center = true);
            }
            
            translate([(8.9-0.5)/2, 0, 0]) rotate([0, 90, 0]) cylinder(h=0.5, d=5.35, center = true);
        }
}

wheel_spacer();	  


