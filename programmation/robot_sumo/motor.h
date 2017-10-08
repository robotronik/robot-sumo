#ifndef MOTOR_HEADER
#define MOTOR_HEADER

typedef enum Direction_E{FORWARD, BACKWARD} Direction;

typedef struct Motor_S{
  //Pins
  byte pwm_pin;
  byte dir_pin;

  //Propriétés
  byte min_pwm;
  bool inverted;

  //Etat
  bool running;
  byte speed;
  Direction dir;
}Motor;

void init_motor(Motor *m, byte pwm_pin, byte dir_pin, byte min_pwm, bool inverted);
/*
 * Initialise les variables du moteur et configure les pins de
 * l'arduino correspondantes.
 */

void drive_motor(const Motor *m);
/*
 * Pilote le moteur afin de faire correspondre son état réel à l'état
 * de ses variables.
 */

void set_state(Motor *m, bool run, byte speed, Direction dir);
/*
 * Configure les paramètres du moteur puis appelle drive_motor.
 */

void start_motor(Motor *m);
/*
 * Démarre le moteur.
 */

void stop_motor(Motor *m);
/*
 * Stoppe le moteur.
 */

void set_speed(Motor *m, byte speed);
/*
 * Configure la vitesse du moteur mais ne l'applique pas.
 */

void set_direction(Motor *m, Direction dir);
/*
 * Configure la direction du moteur mais ne l'applique pas.
 */

#endif
