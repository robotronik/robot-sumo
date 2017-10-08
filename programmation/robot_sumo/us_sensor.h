#ifndef ULTRASONIC_SENSOR_HEADER
#define ULTRASONIC_SENSOR_HEADER

#define SOUND_VELOCITY 0.034f //cm/µs

typedef struct US_Sensor_S{
  byte trig_pin;
  byte echo_pin;
  int timeout_us;//µs
}US_Sensor;

void init_us(US_Sensor *s, byte trig_pin, byte echo_pin, int max_dist);
/*
 * max_dist : cm
 */

int get_dist(const US_Sensor *s);
/*
 * Renvoie la distance d'un objet éventuellement détecté, -1 sinon.
 */
  

#endif
