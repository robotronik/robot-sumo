#ifndef ROBOT_SUMO_HEADER
#define ROBOT_SUMO_HEADER

#include "./pins.h"
#include "./motor.h"
#include "./us_sensor.h"
#include "./ir_sensor.h"
#include "./halt.h"

#define TEST 0 //Effectue les tests au démarrage si TEST_MODE == 1
#define MEDIUM_SPEED 50

//Constantes pour la détection infrarouge
#define LEFT_FRONT 0b1000
#define RIGHT_FRONT 0b0100
#define LEFT_REAR 0b0010
#define RIGHT_REAR 0b0001

void blow_this_fucker_down();
/*
 * Cette fonction agit comme son nom l'indique, c'est à dire qu'on
 * l'utilise lorsqu'il est nécessaire de niquer des mères.
 */

byte get_edges();
/*
 * Vérifie la présence d'un bord de piste (sol noir) à l'aide de
 * chacun des capteurs et renvoie un octet dont les 4 premiers bits
 * codent la présence ou non d'un bord selon les constantes définies
 * ci-dessus. Par exemple, si un bord est détecté sur le capteur avant
 * droit (constante RIGHT_FRONT : 0b0100), alors le 3 ème bit de poids
 * faible de l'octet renvoyé sera à 1.
 */

void test_motor(Motor *m);
void test_ir_sensor(IR_Sensor *s);
void test_us_sensor(US_Sensor *s);


#endif
