#ifndef IR_SENSOR_HEADER
#define IR_SENSOR_HEADER

#define IR_INVERTED 0
#if IR_INVERTED == 0
#define COLOR_UP WHITE
#define COLOR_DOWN BLACK
#else
#define COLOR_UP BLACK
#define COLOR_DOWN WHITE
#endif

typedef enum Color_E{WHITE, BLACK}Color;

typedef struct IR_Sensor_S{
  byte sensor_pin;
  unsigned int treshold;
  unsigned int hysteresis;
  Color last_color;
}IR_Sensor;

void init_ir(IR_Sensor *s, unsigned int sensor_pin, unsigned int treshold, unsigned int hysteresis);
Color get_color(IR_Sensor *s);

#endif
