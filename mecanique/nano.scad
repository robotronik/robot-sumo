use <pinoche.scad>
 
module nano(fn){
	$fn=fn;
	difference(){
		translate([0,0,0]) color("blue") cube(size = [43.4,17.54,1.63], center = false);
		translate([1.28,1.28,-0.1]) cylinder(h=2,r1=1.94/2,r2=1.94/2,center = false);
		translate([43.4-1.28,1.28,-0.1]) cylinder(h=2,r1=1.94/2,r2=1.94/2,center = false);
		translate([43.4-1.28,17.54-1.28,-0.1]) cylinder(h=2,r1=1.94/2,r2=1.94/2,center = false);
		translate([1.28,17.54-1.28,-0.1]) cylinder(h=2,r1=1.94/2,r2=1.94/2,center = false);

    		for(i=[0:14]){
			translate([3.79+i*2.56,1.06,-0.1])
            		cylinder(h=2,r1=1.3/2,r2=1.3/2,center = false);
			translate([3.79+i*2.56,17.54-1.06,-0.1])
            		cylinder(h=2,r1=1.3/2,r2=1.3/2,center = false);
    		}
	}

	translate([43.4-7.56,5.38,1.63])
		color("grey") cube (size = [9.2,7.63,3.74], center = false);
	translate([3.79,1.06,-8.52])pinoche(fn);
	translate([39.63,17.54-1.06,-8.52])rotate([0,0,180])pinoche(fn);
}

nano(50);
