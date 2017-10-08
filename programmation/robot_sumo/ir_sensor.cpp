#include <Arduino.h>
#include "./ir_sensor.h"
#include "./halt.h"

void init_ir(IR_Sensor *s, unsigned int sensor_pin, unsigned int treshold, unsigned int hysteresis){
  if(s == NULL) halt();

  s->sensor_pin = sensor_pin;
  s->treshold = constrain(treshold, 0, 1023);
  s->hysteresis = constrain(hysteresis, 0, 1023);
  
  //Configuration des pins
  pinMode(sensor_pin, INPUT);
  s->last_color = BLACK;
}

Color get_color(IR_Sensor *s){
  if(s == NULL) halt();
  
  int value = analogRead(s->sensor_pin);
  if((s->last_color == COLOR_DOWN) && (value > (s->treshold + s->hysteresis/2))){
    s->last_color = COLOR_UP;
    return COLOR_UP;
  }
  else if((s->last_color == COLOR_UP) && (value < (s->treshold - s->hysteresis/2))){
    s->last_color = COLOR_DOWN;
    return COLOR_DOWN;
  }
}
