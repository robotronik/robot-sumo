#include <Arduino.h>
#include "./us_sensor.h"
#include "./halt.h"

void init_us(US_Sensor *s, byte trig_pin, byte echo_pin, int max_dist){
  if(s == NULL) halt();

  //Pins
  s->trig_pin = trig_pin;
  s->echo_pin = echo_pin;

  //Configuration
  s->timeout_us = (int) ((float) (2*max_dist) / SOUND_VELOCITY);

  //Configuration des pins
  pinMode(trig_pin, OUTPUT);
  pinMode(echo_pin, INPUT);

  digitalWrite(trig_pin, LOW);
}

int get_dist(const US_Sensor *s){
  if(s == NULL) halt();

  //Envoi d'un train d'ondes
  digitalWrite(s->trig_pin, HIGH);
  delayMicroseconds(10);
  digitalWrite(s->trig_pin, LOW);

  //Attente et réception de l'écho
  unsigned long dt = pulseIn(s->echo_pin, HIGH, s->timeout_us);
  if(dt == 0){
    return -1;
  }
  return (int) ((float) dt/2. * SOUND_VELOCITY);
}
