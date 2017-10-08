#include "./halt.h"
#include "./pins.h"
#include <Arduino.h>
#include <avr/sleep.h>

void halt(){
  digitalWrite(LED, HIGH);
  cli();
  sleep_enable();
  sleep_cpu();
}
