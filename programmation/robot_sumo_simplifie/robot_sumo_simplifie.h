#ifndef HEADER
#define HEADER

#include <Arduino.h>
#include <avr/sleep.h>

#define TEST 0 //Effectue les tests au démarrage si TEST_MODE == 1

/* Pins */

//LED système
#define LED 13 //LED_BUILTIN

//Ultrasons
#define TRIG 12
#define ECHO 11

//Infrarouge
#define IR_1 A0
#define IR_2 A1
#define IR_3 A2
#define IR_4 A3

//Moteurs
#define PWM_1 3
#define DIR_1 2
#define PWM_2 5
#define DIR_2 4

/* Valeurs */

//Ultrasons
#define SOUND_VELOCITY 0.034f //cm/µs

//Infrarouge
#define LEFT_FRONT 0b1000
#define RIGHT_FRONT 0b0100
#define LEFT_REAR 0b0010
#define RIGHT_REAR 0b0001

//Moteurs
#define MEDIUM_SPEED 50

/* Prototypes */

//Ultrasons
void init_us();

int get_dist();
/*
 * Renvoie la distance d'un objet éventuellement détecté, -1 sinon.
 */

//Infrarouge
void init_ir(unsigned int sensor_pin);

bool get_color(unsigned int sensor_pin);
/*
 * Renvoie vrai si la ligne est détectée, faux sinon.
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

//Moteurs
void halt();

void init_motor(byte pwm_pin, byte dir_pin, unsigned int speed, bool dir, bool inverted);
/*
 * Initialise les variables du moteur et configure les pins de
 * l'arduino correspondants.
 */

void drive_motor(byte pwm_pin, byte dir_pin, unsigned int speed, bool dir, bool inverted);
/*
 * Pilote le moteur afin de faire correspondre son état réel à l'état
 * de ses variables.
 */

void set_state(byte pwm_pin, byte dir_pin, unsigned int speed, bool dir, bool inverted);
/*
 * Configure les paramètres du moteur puis appelle drive_motor.
 */

void stop_motor(byte pwm_pin, byte dir_pin);
/*
 * Stoppe le moteur.
 */

void set_speed(unsigned int speed1, unsigned int speed2);
/*
 * Configure la vitesse du moteur mais ne l'applique pas.
 */

void set_direction(bool dir1, bool dir2);
/*
 * Configure la direction du moteur mais ne l'applique pas.
 */

void blow_this_fucker_down();
/*
 * Cette fonction agit comme son nom l'indique, c'est à dire qu'on
 * l'utilise lorsqu'il est nécessaire de niquer des mères.
 */

//Tests
void test_motor(byte pwm_pin, byte dir_pin, unsigned int speed, bool dir, bool inverted);
void test_ir_sensor(unsigned int sensor_pin);
void test_us_sensor();

#endif
