$fn=100;

module battery(){
     cube([66,26.5,13.5]);
}

module support_batterie(){

     difference(){
	  union(){
	       cube([56,85.5,10]);
	       minkowski(){
	       translate([(56-30)/2,85,0])cube([30,7,2]);
	       cylinder(d=2,h=0.01);
	       }
	       translate([0,-2,0])cube([17,2,10]);
	       translate([27,-2,0])cube([29,2,10]);
	  }
	  translate([2,-0.1,2])cube([52,85.7,8.1]);
     }

}

//battery();

support_batterie();
