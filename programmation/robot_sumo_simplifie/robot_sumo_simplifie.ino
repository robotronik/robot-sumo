#include "robot_sumo_simplifie.h"

/* Variables */

//Ultrasons
int timeout_us = 0;
int max_dist = 50; //en cm

//Infrarouge
unsigned int threshold = 550; //doit etre compris entre 0 et 1023
bool left_front_ir = false; //ligne non detectee
bool right_front_ir = false;
bool left_rear_ir = false;
bool right_rear_ir = false;

//Moteurs
byte min_pwm = 20;
bool inverted_1 = false; //normal
bool inverted_2 = false;
bool dir_1 = true; //forward
bool dir_2 = true;
unsigned int speed_1 = 0;
unsigned int speed_2 = 0;

/* Fonctions */

//Ultrasons
void init_us() {
  //Configuration
  timeout_us = (int) ((float) (2*max_dist) / SOUND_VELOCITY);

  //Configuration des pins
  pinMode(TRIG, OUTPUT);
  pinMode(ECHO, INPUT);

  digitalWrite(TRIG, LOW);
}

int get_dist() {
  //Envoi d'un train d'ondes
  digitalWrite(TRIG, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG, LOW);

  //Attente et réception de l'écho
  unsigned long dt = pulseIn(ECHO, HIGH, timeout_us);
  if (dt == 0) {
    return -1;
  }
  return (int) ((float) dt/2. * SOUND_VELOCITY);
}

//Infrarouge
void init_ir(unsigned int sensor_pin) {
  //Configuration des pins
  pinMode(sensor_pin, INPUT);
}

bool get_color(unsigned int sensor_pin) {
  int value = analogRead(sensor_pin);
  if (value < threshold) {
    return true;
  } else {
    return false;
  }
}

byte get_edges() {
  byte edges = 0;
  edges |= (get_color(IR_2) == false)?LEFT_FRONT:0;
  edges |= (get_color(IR_1) == false)?RIGHT_FRONT:0;
  edges |= (get_color(IR_3) == false)?LEFT_REAR:0;
  edges |= (get_color(IR_4) == false)?RIGHT_REAR:0;
  return edges;
}

//Moteurs
void halt() {
  digitalWrite(LED, HIGH);
  cli();
  sleep_enable();
  sleep_cpu();
}

void init_motor(byte pwm_pin, byte dir_pin, unsigned int speed, bool dir, bool inverted) {
  //Configuration des pins
  pinMode(pwm_pin, OUTPUT);
  pinMode(dir_pin, OUTPUT);

  //Arrêt du moteur
  drive_motor(pwm_pin, dir_pin, speed, dir, inverted);
}

void drive_motor(byte pwm_pin, byte dir_pin, unsigned int speed, bool dir, bool inverted) {
  byte pwm = map(speed, 0, 255, min_pwm, 255);
  if(dir){
    analogWrite(pwm_pin, pwm);
    digitalWrite(dir_pin, LOW);
  } else {
    analogWrite(pwm_pin, 255-pwm);
    digitalWrite(dir_pin, HIGH);
  }
}

void stop_motor(byte pwm_pin, byte dir_pin) {
  digitalWrite(pwm_pin, LOW);
  digitalWrite(dir_pin, LOW);
}

/*void blow_this_fucker_down(){
  set_state(PWM_2, DIR_2, 255, true, inverted_2);
  set_state(PWM_1, DIR_1, 255, true, inverted_1);
}*/

//Tests
void test_motor(byte pwm_pin, byte dir_pin, unsigned int speed, bool dir, bool inverted) {
  Serial.println("Avance");
  int i;
  for (i = 0; i < 255; i += 5) {
    Serial.println(i, DEC);
    drive_motor(pwm_pin, dir_pin, i, true, inverted);
    delay(100);
  }
  Serial.println("Stop");
  stop_motor(pwm_pin, dir_pin);
  delay(1000);
  Serial.println("Recule");
  for (i = 255; i > 0; i -= 5) {
    Serial.println(i, DEC);
    drive_motor(pwm_pin, dir_pin, i, false, inverted);
    delay(100);
  }
  stop_motor(pwm_pin, dir_pin);
}

void test_motor2(byte pwm_pin, byte dir_pin, unsigned int speed, bool dir, bool inverted) {
  Serial.println("Avance");
  drive_motor(pwm_pin, dir_pin, 255, true, inverted);
  delay(5000);
  Serial.println("Stop");
  stop_motor(pwm_pin, dir_pin);
  delay(1000);
  Serial.println("Recule");
  drive_motor(pwm_pin, dir_pin, 255, false, inverted);
  delay(5000);
  stop_motor(pwm_pin, dir_pin);
}

void test_ir_sensor(unsigned int sensor_pin) {
  int i;
  for (i = 100; i > 0; i--) {
    bool c = get_color(sensor_pin);
    Serial.println(analogRead(sensor_pin), DEC);
    if (c == false) { //blanc (limites?)
      digitalWrite(LED, HIGH);
    } else {
      digitalWrite(LED, LOW);
    }
    delay(250);
  }
}

void test_us_sensor(){
  int i;
  for (i = 100; i > 0; i--) {
    int dist = get_dist();
    Serial.println(dist, DEC);
    delay(250);
  }
}

/*
 * Initialise le robot. Cette fonction est exécutée une seule fois
 * lorsque le programme démarre.
 */
void setup(){
  //LED système
  pinMode(LED, OUTPUT);
  digitalWrite(LED, LOW);

  //Initialisations moteurs
  init_motor(PWM_2, DIR_2, speed_2, dir_2, inverted_2);
  init_motor(PWM_1, DIR_1, speed_1, dir_1, inverted_1);

  //Initialisation ultrasons
  init_us();

  //Initialisations infrarouge
  init_ir(IR_2);
  init_ir(IR_1);
  init_ir(IR_3);
  init_ir(IR_4);

  //Initalisation du générateur de nombres pseudo-aléatoires
  randomSeed(analogRead(0));
  delayMicroseconds(100);

  #if TEST == 1
  //Tests
  Serial.begin(9600);
  Serial.println("Test2 moteur gauche");
  test_motor2(PWM_1, DIR_1, speed_1, dir_1, inverted_1);
  Serial.println("Test2 moteur droit");
  test_motor2(PWM_2, DIR_2, speed_2, dir_2, inverted_2);
  Serial.println("Test moteur gauche");
  test_motor(PWM_1, DIR_1, speed_1, dir_1, inverted_1);
  Serial.println("Test moteur droit");
  test_motor(PWM_2, DIR_2, speed_2, dir_2, inverted_2);
  Serial.println("Test capteur ultrasons");
  test_us_sensor();
  Serial.println("Test IR avant gauche");
  test_ir_sensor(IR_2);
  Serial.println("Test IR avant droit");
  test_ir_sensor(IR_1);
  Serial.println("Test IR arrière gauche");
  test_ir_sensor(IR_3);
  Serial.println("Test IR arrière droit");
  test_ir_sensor(IR_4);
  halt();
  #endif
}

void loop(){
/*  //Exemple de stratégie (naïve)
  byte edges = 0;
  int dist = 0;
  while(true) {
    //Récupération d'infos
    edges = get_edges();
    dist = get_dist();

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
  stop_motor(PWM_2, DIR_2); //gauche
  stop_motor(PWM_1, DIR_1); //droit
      }
      else if((edges & LEFT_FRONT) && (edges & RIGHT_FRONT)){
  set_state(PWM_2, DIR_2, MEDIUM_SPEED, false, inverted_2); //gauche
  set_state(PWM_1, DIR_1, MEDIUM_SPEED, false, inverted_1); //droit
  delay(1000);
      }
      else if((edges & LEFT_REAR) && (edges & RIGHT_REAR)){
  blow_this_fucker_down();
      }
      else if(edges & LEFT_FRONT){
  stop_motor(PWM_1, DIR_1); //droit
  set_state(PWM_2, DIR_2, MEDIUM_SPEED, true, inverted_2); //gauche
  delay(500);
      }
      else if(edges & RIGHT_FRONT){
  stop_motor(PWM_2, DIR_2); //gauche
  set_state(PWM_1, DIR_1, MEDIUM_SPEED, true, inverted_1); //droit
  delay(500);
      }
      else if(edges & LEFT_REAR){
  set_state(PWM_1, DIR_1, MEDIUM_SPEED/2, true, inverted_1); //droit
  set_state(PWM_2, DIR_2, MEDIUM_SPEED, false, inverted_2); //gauche
      }
      else if(edges & RIGHT_REAR){
  set_state(PWM_1, DIR_1, MEDIUM_SPEED, false, inverted_1); //droit
  set_state(PWM_2, DIR_2, MEDIUM_SPEED/2, true, inverted_2); //gauche
      }
      else{
  byte speed = constrain((int) speed_1 + (random(0,10) - 5), 0, MEDIUM_SPEED);
  set_state(PWM_1, DIR_1, speed, true, inverted_1); //droit
  set_state(PWM_2, DIR_2, MEDIUM_SPEED-speed, true, inverted_2);  //gauche
      }
    }
    delay(10);
  }*/
}
