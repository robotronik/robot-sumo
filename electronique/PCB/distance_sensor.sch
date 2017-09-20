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
Sheet 7 7
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_01X04 J8
U 1 1 594470F2
P 6950 3600
F 0 "J8" H 6950 3850 50  0000 C CNN
F 1 "CONN_distance" V 7050 3600 50  0000 C CNN
F 2 "Connectors_Molex:Molex_KK-6410-04_04x2.54mm_Straight" H 6950 3600 50  0001 C CNN
F 3 "" H 6950 3600 50  0001 C CNN
	1    6950 3600
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR053
U 1 1 5944737A
P 6250 3400
F 0 "#PWR053" H 6250 3250 50  0001 C CNN
F 1 "+5V" H 6250 3540 50  0000 C CNN
F 2 "" H 6250 3400 50  0001 C CNN
F 3 "" H 6250 3400 50  0001 C CNN
	1    6250 3400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR054
U 1 1 59447390
P 6250 3900
F 0 "#PWR054" H 6250 3650 50  0001 C CNN
F 1 "GND" H 6250 3750 50  0000 C CNN
F 2 "" H 6250 3900 50  0001 C CNN
F 3 "" H 6250 3900 50  0001 C CNN
	1    6250 3900
	1    0    0    -1  
$EndComp
Text HLabel 5900 3650 0    60   Input ~ 0
Echo
Text HLabel 5900 3550 0    60   Input ~ 0
Trig
Wire Wire Line
	6250 3400 6250 3450
Wire Wire Line
	6250 3450 6750 3450
Wire Wire Line
	5900 3550 6750 3550
Wire Wire Line
	5900 3650 6750 3650
Wire Wire Line
	6250 3900 6250 3750
Wire Wire Line
	6250 3750 6750 3750
$EndSCHEMATC
