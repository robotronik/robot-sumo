$fn=100;

module pololu_951_ball_caster_dim(){

     difference(){
	  union(){
	  translate([(19.05-12.25)/2,0,0])cube([12.25,12.25,10.16]);
	  translate([0,12.25/4,0])cube([19.05,6.125,10.16]);
	  }
	  translate([1.65+2.3/2,12.25/2,-0.01])cylinder(d=2.3,h=10.16+0.02);
	  translate([19.05-(1.65+2.3/2),12.25/2,-0.01])cylinder(d=2.3,h=10.16+0.02);
	  }
     
}


module pololu_951_ball_caster(){

     difference(){
	  union(){
	       difference(){
		    translate([19.05/2,12.25/2,0])cylinder(d=12.25,h=7.5);
		    translate([0,12.25/4+1.5,1.5])cube([19.05,3,10.16]);
		    translate([19.05/2,12.25/2,-0.01])cylinder(d=5,h=1.5);
		    translate([19.05/2,12.25/2,13.25])sphere(d=9.525+6);
	  }
	       translate([1.65+2.3/2,12.25/2,0])cylinder(d=5.6,h=1.5);
	  
	       translate([19.05-(1.65+2.3/2),12.25/2,0])cylinder(d=5.6,h=1.5);
	       translate([19.05/2,12.25/2,9.525/2+0.475])sphere(d=9.525);
	  }
	  translate([1.65+2.3/2,12.25/2,-0.01])cylinder(d=2.3,h=10.16+0.02);
	  translate([19.05-(1.65+2.3/2),12.25/2,-0.01])cylinder(d=2.3,h=10.16+0.02);
	  }
     
}

pololu_951_ball_caster();
