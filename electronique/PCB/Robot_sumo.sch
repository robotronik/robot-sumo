EESchema Schematic File Version 2
LIBS:Robot_sumo-rescue
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:arduino-nano
LIBS:l293
LIBS:Robot_sumo-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 7
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 5400 2450 1750 2500
U 5942F2F4
F0 "uC-part" 60
F1 "uC-part.sch" 60
F2 "PWM1" I L 5400 2850 60 
F3 "PWM2" I L 5400 3250 60 
F4 "O2" I L 5400 3400 60 
F5 "O1" I L 5400 3000 60 
F6 "Echo" I R 7150 4650 60 
F7 "Trig" I R 7150 4850 60 
F8 "C1" I R 7150 3000 60 
F9 "C2" I R 7150 2900 60 
F10 "C3" I R 7150 2800 60 
F11 "C4" I R 7150 2700 60 
$EndSheet
$Sheet
S 5450 1400 1700 500 
U 5942F43B
F0 "power-part" 60
F1 "power-part.sch" 60
$EndSheet
$Sheet
S 7850 2450 2100 850 
U 5942F43E
F0 "R-IR" 60
F1 "R-IR.sch" 60
F2 "Signal-e" I L 7850 3150 60 
F3 "C1" I L 7850 3000 60 
F4 "C2" I L 7850 2900 60 
F5 "C3" I L 7850 2800 60 
F6 "C4" I L 7850 2700 60 
$EndSheet
$Sheet
S 7850 3550 2100 500 
U 5942F443
F0 "T-IR" 60
F1 "T-IR.sch" 60
F2 "Signal-e" I L 7850 3700 60 
$EndSheet
$Sheet
S 3050 2600 1700 1200
U 5942F446
F0 "motor-part" 60
F1 "motor-part.sch" 60
F2 "O1" I R 4750 3000 60 
F3 "PWM1" I R 4750 2850 60 
F4 "PWM2" I R 4750 3250 60 
F5 "O2" I R 4750 3400 60 
$EndSheet
Wire Wire Line
	4750 2850 5400 2850
Wire Wire Line
	4750 3000 5400 3000
Wire Wire Line
	4750 3250 5400 3250
Wire Wire Line
	4750 3400 5400 3400
Wire Wire Line
	7850 3700 7700 3700
Wire Wire Line
	7700 3700 7700 3150
Wire Wire Line
	7700 3150 7850 3150
$Sheet
S 7900 4800 2050 1150
U 5944680D
F0 "distance_sensor" 60
F1 "distance_sensor.sch" 60
F2 "Echo" I L 7900 5000 60 
F3 "Trig" I L 7900 5250 60 
$EndSheet
Wire Wire Line
	7150 4650 7650 4650
Wire Wire Line
	7650 4650 7650 5000
Wire Wire Line
	7650 5000 7900 5000
Wire Wire Line
	7150 4850 7450 4850
Wire Wire Line
	7450 4850 7450 5250
Wire Wire Line
	7450 5250 7900 5250
Wire Wire Line
	7150 2700 7850 2700
Wire Wire Line
	7150 2800 7850 2800
Wire Wire Line
	7150 2900 7850 2900
Wire Wire Line
	7150 3000 7850 3000
$EndSCHEMATC
