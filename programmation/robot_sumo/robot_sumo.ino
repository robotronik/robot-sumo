#include <Arduino.h>
#include "./robot_sumo.h"

//Moteurs
Motor left_motor;
Motor right_motor;

//Capteur ultrasons
US_Sensor dist_sensor;

//Capteurs infrarouges
IR_Sensor left_front_ir;
IR_Sensor right_front_ir;
IR_Sensor left_rear_ir;
IR_Sensor right_rear_ir;

/*
 * Initialise le robot. Cette fonction est exécutée une seule fois
 * lorsque le programme démarre.
 */
void setup(){
  //LED système
  pinMode(LED, OUTPUT);
  digitalWrite(LED, LOW);
  
  //Initialisations moteurs
  init_motor(&left_motor, PWM_2, DIR_2, 20, true);
  init_motor(&right_motor, PWM_1, DIR_1, 20, true);

  //Initialisation ultrasons
  init_us(&dist_sensor, TRIG, ECHO, 50);

  //Initialisations infrarouge
  init_ir(&left_front_ir, IR_2, 550, 10);
  init_ir(&right_front_ir, IR_1, 550, 10);
  init_ir(&left_rear_ir, IR_3, 550, 10);
  init_ir(&right_rear_ir, IR_4, 550, 10);

  //Initalisation du générateur de nombres pseudo-aléatoires
  randomSeed(analogRead(0));
  delayMicroseconds(100);

  #if TEST == 1
  //Tests
  Serial.begin(9600);
  Serial.println("Test moteur gauche");
  test_motor(&left_motor);
  Serial.println("Test moteur droit");
  test_motor(&right_motor);
  Serial.println("Test capteur ultrasons");
  test_us_sensor(&dist_sensor);
  Serial.println("Test IR avant gauche");
  test_ir_sensor(&left_rear_ir);
  Serial.println("Test IR avant droit");
  test_ir_sensor(&right_front_ir);
  Serial.println("Test IR arrière gauche");
  test_ir_sensor(&left_rear_ir);
  Serial.println("Test IR arrière droit");
  test_ir_sensor(&right_rear_ir);
  halt();
  #endif
}

void loop(){
  //Exemple de stratégie (naïve)
  byte edges = 0;
  int dist = 0;
  while(true){
    //Récupération d'infos
    edges = get_edges();
    dist = get_dist(&dist_sensor);

    //Doit-on défoncer un truc?
    if((dist != -1) &&
       (
	(dist < 5)
	|| ((dist < 50) && ((edges & (LEFT_FRONT | RIGHT_FRONT)) == 0))
	)
       ){
      blow_this_fucker_down();
    }
    else{
      if(edges == 0x0F){
	stop_motor(&left_motor);
	stop_motor(&right_motor);
      }
      else if((edges & LEFT_FRONT) && (edges & RIGHT_FRONT)){
	set_state(&right_motor, true, MEDIUM_SPEED, BACKWARD);
	set_state(&left_motor, true, MEDIUM_SPEED, BACKWARD);
	delay(1000);
      }
      else if((edges & LEFT_REAR) && (edges & RIGHT_REAR)){
	blow_this_fucker_down();
      }
      else if(edges & LEFT_FRONT){
	stop_motor(&right_motor);
	set_state(&left_motor, true, MEDIUM_SPEED, FORWARD);
	delay(500);
      }
      else if(edges & RIGHT_FRONT){
	stop_motor(&left_motor);
	set_state(&right_motor, true, MEDIUM_SPEED, FORWARD);
	delay(500);
      }
      else if(edges & LEFT_REAR){
	set_state(&right_motor, true, MEDIUM_SPEED/2, FORWARD);
	set_state(&left_motor, true, MEDIUM_SPEED, BACKWARD);
      }
      else if(edges & RIGHT_REAR){
	set_state(&right_motor, true, MEDIUM_SPEED, BACKWARD);
	set_state(&left_motor, true, MEDIUM_SPEED/2, FORWARD);
      }
      else{
	byte speed = constrain((int) right_motor.speed + (random(0,10) - 5), 0, MEDIUM_SPEED);
	set_state(&right_motor, true, speed, FORWARD);
	set_state(&left_motor, true, MEDIUM_SPEED-speed, FORWARD);
      }
    }
    delay(10);
  }
}

void blow_this_fucker_down(){
  set_state(&left_motor, true, 255, FORWARD);
  set_state(&right_motor, true, 255, FORWARD);
}

byte get_edges(){
  byte edges = 0;
  edges |= (get_color(&left_front_ir) == WHITE)?LEFT_FRONT:0;
  edges |= (get_color(&right_front_ir) == WHITE)?RIGHT_FRONT:0;
  edges |= (get_color(&left_rear_ir) == WHITE)?LEFT_REAR:0;
  edges |= (get_color(&right_rear_ir) == WHITE)?RIGHT_REAR:0;  
  return edges;
}

void test_motor(Motor *m){
  if(m == NULL) halt();

  set_direction(m, FORWARD);
  Serial.println("Avance");
  int i;
  for(i = 0; i < 255; i += 5){
    Serial.println(i, DEC);
    set_speed(m, i);
    start_motor(m);
    delay(100);
  }
  Serial.println("Stop");
  stop_motor(m);
  delay(1000);
  Serial.println("Recule");
  set_direction(m, BACKWARD);
  start_motor(m);
  for(i = 255; i > 0; i -= 5){
    Serial.println(i, DEC);
    set_speed(m, i);
    start_motor(m);
    delay(100);
  }
  stop_motor(m);
}

void test_ir_sensor(IR_Sensor *s){
  if(s == NULL) halt();
  
  int i;
  for(i = 100; i > 0; i--){
    Color c = get_color(s);
    Serial.println(analogRead(s->sensor_pin), DEC);
    if(c == WHITE){
      digitalWrite(LED, HIGH);
    }
    else{
      digitalWrite(LED, LOW);
    }
    delay(250);
  }
}

void test_us_sensor(US_Sensor *s){
  if(s == NULL) halt();
  
  int i;
  for(i = 100; i > 0; i--){
    int dist = get_dist(s);
    Serial.println(dist, DEC);
    delay(250);
  }
}
