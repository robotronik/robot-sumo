#include <Arduino.h>
#include "./motor.h"
#include "./halt.h"

void init_motor(Motor *m, byte pwm_pin, byte dir_pin, byte min_pwm, bool inverted){
  if(m == NULL) halt();
  
  //Pins
  m->pwm_pin = pwm_pin;
  m->dir_pin = dir_pin;

  //Propriétés
  m->min_pwm = min_pwm;
  m->inverted = inverted;

  //Etat
  m->running = false;
  m->speed = 0;
  m->dir = FORWARD;

  //Configuration des pins
  pinMode(pwm_pin, OUTPUT);
  pinMode(dir_pin, OUTPUT);

  //Arrêt du moteur
  drive_motor(m);
}

void drive_motor(const Motor *m){
  if(m == NULL) halt();

  if(!m->running){
    digitalWrite(m->pwm_pin, LOW);
    digitalWrite(m->dir_pin, LOW);
    return;
  }

  byte pwm = map(m->speed, 0, 255, m->min_pwm, 255);
  if((m->dir == FORWARD && !m->inverted) || (m->dir == BACKWARD && m->inverted)){
    analogWrite(m->pwm_pin, pwm);
    digitalWrite(m->dir_pin, LOW);
  }
  else{
    analogWrite(m->pwm_pin, 255-pwm);
    digitalWrite(m->dir_pin, HIGH);
  }
}

void set_state(Motor *m, bool run, byte speed, Direction dir){
  if(m == NULL) halt();

  m->running = run;
  m->speed = speed;
  m->dir = dir;
  drive_motor(m);
}

void start_motor(Motor *m){
  if(m == NULL) halt();
  
  m->running = (m->speed != 0);
  drive_motor(m);
}

void stop_motor(Motor *m){
  if(m == NULL) halt();
  
  m->running = false;
  drive_motor(m);
}

void set_speed(Motor *m, byte speed){
  if(m == NULL) halt();

  m->speed = speed;
}

void set_direction(Motor *m, Direction dir){
  if(m == NULL) halt();
  
  m->dir = dir;
}
