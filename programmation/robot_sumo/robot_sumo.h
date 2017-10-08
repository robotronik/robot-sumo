#ifndef ROBOT_SUMO_HEADER
#define ROBOT_SUMO_HEADER

#include "./pins.h"
#include "./motor.h"
#include "./us_sensor.h"
#include "./ir_sensor.h"
#include "./halt.h"

#define LEFT_FRONT 0b1000
#define RIGHT_FRONT 0b0100
#define LEFT_REAR 0b0010
#define RIGHT_REAR 0b0001

void blow_this_fucker_down();
byte get_edges();
void test_motor(Motor *m);
void test_ir_sensor(IR_Sensor *s);
void test_us_sensor(US_Sensor *s);


#endif
