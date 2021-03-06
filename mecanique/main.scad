$fn = 30;

path = "/home/jordan/"; // chemin vers le dossier robotronik

// utilisation de modules définis dans d'autres fichiers

use <moteur.scad>;
use <nano.scad>;
use <roue_omni.scad>;
use <capteurUS_HCSR04.scad>;
use <capteur_CNY70.scad>;
//use <driver_L293D.scad>;
use <breadboard.scad>;
use <Support_capteurCNY70.scad>
use <support_capteur_US_v2.scad>
use <support_moteur_v2.scad>
use <PCB_hole_footprint.scad>
use <support_capteur_CNY70_v2.scad>
use <wheel_spacer.scad>
use <support_batterie.scad>
use <support_PCB.scad>
use <pololu_3-8inch_ball_caster.scad>
use <support_pololu_3-8inch_ball_caster.scad>

//translate([63,47.5,-5])mirror([0,1,0])import ("freecad_model/robot_sumo_base.stl");

// utilisation de fichier STL pour optimiser les performances

/*module moteur(){
  color("lightgrey")import(str(path,"robotronik/mecanique/Init_2016/STL/Moteur.stl"));
  color("grey")import(str(path,"robotronik/mecanique/Init_2016/STL/Axe_moteur.stl"));
  color("white")import(str(path,"robotronik/mecanique/Init_2016/STL/Coque_moteur_et_axe_reducteur.stl"));
  import(str(path,"robotronik/mecanique/Init_2016/STL/Reducteur_moteur.stl"));
  }

  module roue(){
  color("grey")import(str(path,"robotronik/mecanique/Init_2016/STL/Pneu.stl"));
  import(str(path,"robotronik/mecanique/Init_2016/STL/Jante.stl"));
  }

  module bille_jockey(){

  color("gold")import(str(path,"robotronik/mecanique/Init_2016/STL/Roue_omni_1.stl"));
  color("lightgrey")import(str(path,"/robotronik/mecanique/Init_2016/STL/Roue_omni_2.stl"));
  }

  module breadboard(){
  color("green")import(str(path,"robotronik/mecanique/Init_2016/STL/Breadboard_1.stl"));
  color("khaki")import(str(path,"robotronik/mecanique/Init_2016/STL/Breadboard_contacts.stl"));
  }*/

// Déclaration des modules utilisés pour modéliser le robot

module power_train(fn){

     translate([39, 0, 0]) union(){
	  translate([-30.5, 0, 0]) rotate([0, -90, 0]) roue(fn);

	  rotate([180,0,0])moteur(fn);
	  translate([-9, 0, 0])wheel_spacer();
     }

     translate([70, 0, 0]) mirror([1, 0, 0]) union(){
	   translate([-30.5, 0, 0]) rotate([0, -90, 0]) roue(fn);

	  rotate([180,0,0])moteur(fn);
	  translate([-9, 0, 0])wheel_spacer();
     }
}

module equerre_fixation(lc1,lc2,L,e,diam_vis){
     // e = epaisseur / lc1 = hauteur équerre / lc2 = longueur base équerre / L = largeur équerre
     difference(){
	  cube([lc1,L,e]);
	  translate([5+1.7/2,L/2,-2])rotate([0,0,0])cylinder(d=diam_vis,h=7);	
	  translate([5+(20-1.7/2),L/2,-2])rotate([0,0,0])cylinder(d=diam_vis,h=7); 
     }
     difference() {
	  rotate([0,90,0])cube([lc2,L,e]);
	  translate([-6,L/2,-6])rotate([0,90,0])cylinder(d=diam_vis,h=10);

     }
     translate([0,L,0]) rotate([90,0,0])linear_extrude(height = L)polygon(
	  points=[ [0,0],[3,0],[0,-3] ],
	  paths=[ [0,1,2] ]
	  );	
}

module fixations_capteurUS(){
     difference(){
	  union(){
	       translate([-2.85,1.5,-5])rotate([0,-90,-90])equerre_fixation(26,8,4,2,1.5);
	       translate([-46.15,1.5,-5])rotate([0,-90,-90])equerre_fixation(26,8,4,2,1.5);
	       translate([-2.85,-6.5,-5])cube([6,10,2]);
	       translate([1.15,-6.5,-5])cube([2,10,26]);
	  }
	  union(){
	       translate([-9.5,4,10])rotate([90,0,0])cylinder(d=17,h=3,$fn=100);
	       translate([-35.5,4,10])rotate([90,0,0])cylinder(d=17,h=3,$fn=100);
	  }
     }
}

/*module fixation_moteur_1(){
  difference(){
  union(){
  rotate([90,0,90])cube([10,25.5,2]);
  translate([-19.5,-15,25.5-3])cube([19.5,25,3]);
  translate([-22.5,-25,0])cube([3,35,25.5]);
  translate([-29.5,-25,0])cube([10,15,3]);
  }
  translate([-22.7,4.5,2])rotate([0,90,0])cylinder(d=3,h=25);
  translate([-22.7,4.5,20.4])rotate([0,90,0])cylinder(d=3,h=25);

  translate([-29.5+3.5,-26.5+3+2,-10])cylinder(d=3,h=25);
  translate([-29.5+3.5,-26.5+3+13.5,-10])cylinder(d=3,h=25);
  }

  }

  module fixation_moteur_2(){
  mirror([1,0,0]){
  difference(){
  union(){
  rotate([90,0,90])cube([10,25.5,2]);
  translate([-19.5,-15,25.5-3])cube([19.5,25,3]);
  translate([-22.5,-25,0])cube([3,35,25.5]);
  translate([-29.5,-10,0])cube([10,15,3]);
  }
  translate([-22.7,4.5,2])rotate([0,90,0])cylinder(d=3,h=25);
  translate([-22.7,4.5,20.4])rotate([0,90,0])cylinder(d=3,h=25);

  translate([-29.5+3.5,-26.5+3+2+11.5,-10])cylinder(d=3,h=25);
  translate([-29.5+3.5,-26.5+3+10+15,-10])cylinder(d=3,h=25);
  }
  }

  }

  module fixation_moteurs_V1(){
  translate([75.4,35.8,5])fixation_moteur_1();
  translate([23.4,35.8,5])fixation_moteur_2();
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
  translate([30,8.8,5])union(){
  translate([8,-5,0])rotate([0,-90,0])equerre_fixation_moteur(15,7,5,2,3);
  rotate([0,-90,180])equerre_fixation_moteur(15,7,5,2,3);
  }
  translate([61,8.8,5])union(){
  translate([8,-5,0])rotate([0,-90,0])equerre_fixation_moteur(15,7,5,2,3);
  rotate([0,-90,180])equerre_fixation_moteur(15,7,5,2,3);
  }
  translate([75.4,35.8,5])fixation_moteur_1_V2();
  }

  module fixation_moteur_1_V2(){
  difference(){
  union(){
  translate([-22.5,-25,0])cube([2,35,25]);
  translate([-29.5,-25,0])cube([9,35,3]);
  translate([-31.5,-25,0])cube([2,35,25]);
  }
  translate([-22.6,-25.1,12.1])minkowski(){
  cube([1.1,20,17]);
  rotate([0,90,0])cylinder(d=4,h=1.1);
  }
  translate([-31.6,-25.1,12.1])minkowski(){
  cube([1.1,20,17]);
  rotate([0,90,0])cylinder(d=4,h=1.1);
  }
  translate([-35.7,4.5,20.4])rotate([0,90,0])cylinder(d=3,h=25);

  translate([-29.5+3.5,-26.5+3+2,-10])cylinder(d=3,h=25);
  translate([-29.5+3.5,-26.5+3+13.5,-10])cylinder(d=3,h=25);
  translate([-29.5+3.5,-26.5+3+13.5+11.5,-10])cylinder(d=3,h=25);
  }

  }*/

module fixation_breadboard_1(){
     translate([0,0,5])cube([2,8,50]);
     difference(){
	  translate([0,0,53])cube([60,8,2]);
	  translate([12.2,2.5,37.5])rotate([0,0,0])cylinder(d=3,h=3);
	  translate([47.8,2.5,37.5])rotate([0,0,0])cylinder(d=3,h=3);
	  translate([47.8,3.5,52.5])rotate([0,0,0])cylinder(d=3,h=10);
	  translate([12.1,3.5,52.5])rotate([0,0,0])#cylinder(d=3,h=10);
     }
     translate([58,0,5])cube([2,8,50]);
     translate([2,0,5+1.5])rotate([180,0,180])equerre_fixation(9,10,8,2,3);
     translate([58,5+3,5+1.5])rotate([180,0,0])equerre_fixation(9,10,8,2,3);
}

module fixation_breadboard_2(){
     cube([5,5,35]);
     translate([-20,0,38])cube([40,15,2]);
}

module equerre_fixationUS(lc1,lc2,L,e,diam_vis,pos_hole){
     // e = epaisseur / lc1 = hauteur équerre / lc2 = longueur base équerre / L = largeur équerre
     difference(){
	  cube([lc1,L,e]);
	  translate([5+1.7/2,L/2,-2])rotate([0,0,0])cylinder(d=diam_vis,h=7);	
	  translate([5+(20-1.7/2),L/2,-2])rotate([0,0,0])cylinder(d=diam_vis,h=7); 
     }
     difference() {
	  rotate([0,90,0])cube([lc2,L,e]);
	  translate([-6,L/2,pos_hole])rotate([0,90,0])cylinder(d=diam_vis,h=10);

     }
     translate([0,L,0]) rotate([90,0,0])linear_extrude(height = L)polygon(
	  points=[ [0,0],[3,0],[0,-3] ],
	  paths=[ [0,1,2] ]
	  );	
}

module fixations_capteurUS_V2(){
     difference(){
	  union(){
	       translate([-2.85,1.5,-5])rotate([0,-90,-90])equerre_fixationUS(27,16,5,2,2.5,-13);
	       //translate([-46.15,1.5,-5])rotate([0,-90,-90])equerre_fixation(26,8,4,2,1.5);
	       translate([2.1,-6.5,-5])cube([2,10,2]);
	       translate([2.1,-14.5,-5])cube([2,18,27]);
	       translate([-2.85,-6,-5])cube([4.95,1.5,27]);
	  }
	  union(){
	       translate([-9.5,4,10])rotate([90,0,0])cylinder(d=18,h=3,$fn=100);
	       translate([-35.5,4,10])rotate([90,0,0])cylinder(d=17,h=3,$fn=100);
	  }
     }
}

module robot_sumo(){	
     translate([-4.5,25,21.2])power_train(50);
     translate([0.5,5,5]){
	  color("red")fixation_moteur_V2();
	  /*translate([26,6.3,-10])cylinder(d=3,h=20);
	  translate([42,6.3,-10])cylinder(d=3,h=20);
	  translate([57,6.3,-10])cylinder(d=3,h=20);
	  translate([73,6.3,-10])cylinder(d=3,h=20);
	  translate([49.4,14.3,-10])cylinder(d=3,h=20);
	  translate([49.4,25.8,-10])cylinder(d=3,h=20);
	  translate([49.4,37.3,-10])cylinder(d=3,h=20);*/
     }
     //translate([40,70,60])rotate([0,0,-90])nano(20);
     //translate([0,0,0])rotate([180,0,0])CNY70();
     translate([0,10,0]){
	  //translate([30,11,55])breadboard(10);
	  translate([20,80.3,0.5]){
	       //fixation_breadboard_1();
	       /*translate([-3.8,2.5,-1])cylinder(d=3,h=10);
	       translate([63.86,2.5,-1])cylinder(d=3,h=10);*/
	  }
     }
     translate([50,87,-1])rotate([0,0,180]){
	  //rotate([0,0,-30])bille_jockey(50);
	  translate([-9.5,-6.1,-2])mirror([0,0,1])pololu_951_ball_caster();
	  translate([0,0,6+2.5])mirror([0,0,1])support_pololu_951_ball_caster(2.5,3);
	  //translate([0,0,0])rotate([0,0,0])cylinder(d=20,h=20);
	  //for(i=[0:2]){translate([12.6*cos(i*120-30),12.6*sin(i*120-30),-3])cylinder(d=3,h=10);}
     }
     translate([(100-45)/2,-7,10]){
	  //rotate([0,0,180])fixations_capteurUS();
	  //rotate([0,0,180])fixations_capteurUS_V2();
	  //translate([0,4,0])rotate([90,0,0])backplate(49,23,2);
	  translate([0,-1,0])rotate([90,0,0])frontplate(49,23,2);
	  translate([0,4,0])rotate([90,0,0])capteurUS_HCSR04(30);
     }
     /*translate([27.8,4.6,-1])cylinder(d=2.5,h=10);
     translate([72.15,4.6,-3])cylinder(d=2.5,h=10);*/
     //color("red")fixation_moteurs_V1();
     //translate([47.5,2.5,5])fixation_breadboard_2();

     // color sensors
     // front
     translate([25,-18,-5])rotate([0,0,-6])sensor_and_support();
     translate([100-25,-18,-5])mirror([1,0,0])rotate([0,0,-6])sensor_and_support();

     // back
     translate([20,105,-5])rotate([0,0,180+8.5])sensor_and_support();
     translate([80,105,-5])mirror([1,0,0])rotate([0,0,180+8.5])sensor_and_support();
    

     translate([15,95,60])rotate([0,180,-180])pcb_hole_footprint(3);
     translate([15,95,57])rotate([180,0,0])pcb_support(52);
     translate([50-19.9/2,7.8,5])PCB_support_pillar(49,5,3);

     color("white")translate([(100+26.5)/2,20,39])rotate([0,0,90])battery();
     color("green")translate([(100-56)/2,31.5-25.5,37])rotate([0,0,0])support_batterie();
     
}


module base(){
     difference(){
	  union(){
	       translate([0,-10,-1])cube([100,110,6]);
	       translate([50,-10,-1])resize(newsize=[0,20,0])cylinder(d=100,h=6, $fn=100);
	       translate([50,100,-1])resize(newsize=[0,15,0])cylinder(d=100,h=6,$fn=100);
	  }
	  translate([-0.1,-10,-1.1])cube([23,73,6.2]);
	  translate([-0.1+77.2,-10,-1.1])cube([23,73,6.2]);
	  //translate([0,0,0.1])robot_sumo();

	  /* motor fixation holes */
	  translate([0.5,5,5]){
	       	  translate([26,6.3,-10])cylinder(d=3,h=20);
	  translate([42,6.3,-10])cylinder(d=3,h=20);
	  translate([57,6.3,-10])cylinder(d=3,h=20);
	  translate([73,6.3,-10])cylinder(d=3,h=20);
	  translate([49.4,14.3,-10])cylinder(d=3,h=20);
	  translate([49.4,25.8,-10])cylinder(d=3,h=20);
	  translate([49.4,37.3,-10])cylinder(d=3,h=20);
	  }

	  /* PCB fixation holes */
	  translate([0,10,0]){
	       translate([20,71.15,0.5]){
		    translate([-2,0,-1])cylinder(d=3,h=10);
		    translate([62,0,-1])cylinder(d=3,h=10);
	       }
	  }

	  /* ball caster fixation holes */
	  translate([50,87,-1])rotate([0,0,180]){
	       translate([0,0,-1])rotate([0,0,0])cylinder(d=20,h=20, $fn=50);
	       for(i=[0:2]){translate([12.6*cos(i*120-30),12.6*sin(i*120-30),-3])cylinder(d=3,h=10);
	       }
	       
	  }

	  /* US sensor fixation holes */
	       translate([27.8,4.6,-3])cylinder(d=2.5,h=10);
     translate([72.15,4.6,-3])cylinder(d=2.5,h=10);

     /* color sensors fixation holes */
     // front
     translate([23,-13,-2])cylinder(d=3,h=10);
     translate([37.5,-14.5,-2])cylinder(d=3,h=10);
	  
     translate([100-23,-13,-2])cylinder(d=3,h=10);
     translate([100-37.5,-14.5,-2])cylinder(d=3,h=10);
     // wire
     translate([30.25,-14,-2])cylinder(d=6,h=10);
translate([100-30.25,-14,-2])cylinder(d=6,h=10);

     // back
     translate([23.2,100.65,-2])cylinder(d=3,h=10);
     translate([8.8,98.55,-2])cylinder(d=3,h=10);
     
     translate([100-23.2,100.65,-2])cylinder(d=3,h=10);
     translate([100-8.8,98.55,-2])cylinder(d=3,h=10);
     //wire
     translate([16,99.6,-2])cylinder(d=6,h=10);
     translate([100-16,99.6,-2])cylinder(d=6,h=10);
     
	  
     }
	
}

module base_2(){
     translate([0,20,0])base();
}

//-->
rotate([0,0,0])translate([0,20,0])robot_sumo();
/*projection(cut = false)*//*rotate([-1,0,0])*/base_2();

%translate([-20,0,-14])cube([150,150,1]);
