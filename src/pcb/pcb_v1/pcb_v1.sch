EESchema Schematic File Version 4
LIBS:pcb_v1-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
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
L Device:R R1
U 1 1 5C23230B
P 2900 2850
F 0 "R1" V 2693 2850 50  0000 C CNN
F 1 "10k" V 2784 2850 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 2830 2850 50  0001 C CNN
F 3 "~" H 2900 2850 50  0001 C CNN
	1    2900 2850
	0    -1   -1   0   
$EndComp
$Comp
L Device:C C1
U 1 1 5C2323CC
P 3800 1800
F 0 "C1" V 3548 1800 50  0000 C CNN
F 1 "20pF" V 3639 1800 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 3838 1650 50  0001 C CNN
F 3 "~" H 3800 1800 50  0001 C CNN
	1    3800 1800
	0    1    1    0   
$EndComp
$Comp
L Device:C C2
U 1 1 5C2324F2
P 4000 2200
F 0 "C2" V 4252 2200 50  0000 C CNN
F 1 "20pF" V 4161 2200 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 4038 2050 50  0001 C CNN
F 3 "~" H 4000 2200 50  0001 C CNN
	1    4000 2200
	0    -1   -1   0   
$EndComp
$Comp
L Device:Crystal Y1
U 1 1 5C23257B
P 3450 2000
F 0 "Y1" V 3404 2131 50  0000 L CNN
F 1 "16MHz" V 3495 2131 50  0000 L CNN
F 2 "Crystal:Crystal_HC49-4H_Vertical" H 3450 2000 50  0001 C CNN
F 3 "~" H 3450 2000 50  0001 C CNN
	1    3450 2000
	0    1    1    0   
$EndComp
$Comp
L MCU_Microchip_ATmega:ATmega328P-PU U1
U 1 1 5C23274C
P 1900 2550
F 0 "U1" H 1259 2596 50  0000 R CNN
F 1 "ATmega328P-PU" H 1259 2505 50  0000 R CNN
F 2 "Package_DIP:DIP-28_W7.62mm" H 1900 2550 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 1900 2550 50  0001 C CNN
	1    1900 2550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5C232C0D
P 4250 2250
F 0 "#PWR05" H 4250 2000 50  0001 C CNN
F 1 "GND" H 4255 2077 50  0000 C CNN
F 2 "" H 4250 2250 50  0001 C CNN
F 3 "" H 4250 2250 50  0001 C CNN
	1    4250 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 1850 3450 1800
Wire Wire Line
	3950 1800 4250 1800
$Comp
L power:+5V #PWR07
U 1 1 5C2334C4
P 3350 2850
F 0 "#PWR07" H 3350 2700 50  0001 C CNN
F 1 "+5V" H 3365 3023 50  0000 C CNN
F 2 "" H 3350 2850 50  0001 C CNN
F 3 "" H 3350 2850 50  0001 C CNN
	1    3350 2850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR010
U 1 1 5C23EA27
P 1900 4150
F 0 "#PWR010" H 1900 3900 50  0001 C CNN
F 1 "GND" H 1905 3977 50  0000 C CNN
F 2 "" H 1900 4150 50  0001 C CNN
F 3 "" H 1900 4150 50  0001 C CNN
	1    1900 4150
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR01
U 1 1 5C23ECED
P 1900 900
F 0 "#PWR01" H 1900 750 50  0001 C CNN
F 1 "+5V" H 1915 1073 50  0000 C CNN
F 2 "" H 1900 900 50  0001 C CNN
F 3 "" H 1900 900 50  0001 C CNN
	1    1900 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 900  1900 1000
Wire Wire Line
	2000 1050 2000 1000
Wire Wire Line
	2000 1000 1900 1000
Connection ~ 1900 1000
Wire Wire Line
	1900 1000 1900 1050
$Comp
L power:+5V #PWR02
U 1 1 5C23F244
P 1200 1300
F 0 "#PWR02" H 1200 1150 50  0001 C CNN
F 1 "+5V" H 1215 1473 50  0000 C CNN
F 2 "" H 1200 1300 50  0001 C CNN
F 3 "" H 1200 1300 50  0001 C CNN
	1    1200 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 1350 1200 1350
Wire Wire Line
	1200 1350 1200 1300
Text GLabel 7150 2000 2    50   Input ~ 0
CCS
Wire Wire Line
	7050 2000 7150 2000
Text GLabel 7150 2600 2    50   Input ~ 0
LAT
Text GLabel 7150 2700 2    50   Input ~ 0
DI
Text GLabel 7150 2800 2    50   Input ~ 0
CLK
Text GLabel 7150 2900 2    50   Input ~ 0
LCS
Wire Wire Line
	7050 2800 7150 2800
Wire Wire Line
	7050 2700 7150 2700
Wire Wire Line
	7050 2600 7150 2600
Wire Wire Line
	7050 2900 7150 2900
Text GLabel 2650 3550 2    50   Input ~ 0
LAT
Text GLabel 2650 3450 2    50   Input ~ 0
DI
Text GLabel 2650 3350 2    50   Input ~ 0
CLK
Text GLabel 2650 3250 2    50   Input ~ 0
LCS
Text GLabel 2600 1550 2    50   Input ~ 0
CCS
Text Label 3050 3300 0    50   ~ 0
D2
Text Label 3050 3400 0    50   ~ 0
D3
Text Label 3050 3500 0    50   ~ 0
D4
Text Label 3050 3600 0    50   ~ 0
D5
Text Label 3050 1600 0    50   ~ 0
D10
Wire Wire Line
	2500 3250 2650 3250
Wire Wire Line
	2500 3350 2650 3350
Wire Wire Line
	2650 3450 2500 3450
Wire Wire Line
	2500 3550 2650 3550
Wire Wire Line
	2500 1550 2600 1550
$Comp
L power:+5V #PWR04
U 1 1 5C247AEE
P 4750 1950
F 0 "#PWR04" H 4750 1800 50  0001 C CNN
F 1 "+5V" H 4765 2123 50  0000 C CNN
F 2 "" H 4750 1950 50  0001 C CNN
F 3 "" H 4750 1950 50  0001 C CNN
	1    4750 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 2100 4750 2100
Wire Wire Line
	4750 2100 4750 1950
Wire Wire Line
	1900 4050 1900 4150
$Comp
L power:GND #PWR06
U 1 1 5C24A1CA
P 4750 2350
F 0 "#PWR06" H 4750 2100 50  0001 C CNN
F 1 "GND" H 4755 2177 50  0000 C CNN
F 2 "" H 4750 2350 50  0001 C CNN
F 3 "" H 4750 2350 50  0001 C CNN
	1    4750 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 2200 4750 2200
Wire Wire Line
	4750 2200 4750 2300
Wire Wire Line
	5150 2300 4750 2300
Connection ~ 4750 2300
Wire Wire Line
	4750 2300 4750 2350
$Comp
L power:GND #PWR03
U 1 1 5C24B48D
P 7200 1600
F 0 "#PWR03" H 7200 1350 50  0001 C CNN
F 1 "GND" H 7205 1427 50  0000 C CNN
F 2 "" H 7200 1600 50  0001 C CNN
F 3 "" H 7200 1600 50  0001 C CNN
	1    7200 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7200 1600 7050 1600
$Comp
L arduino_shieldsNCL:HT16K33_breakout U2
U 1 1 5C24F0C2
P 3950 5100
F 0 "U2" H 3950 5965 50  0000 C CNN
F 1 "HT16K33_breakout" H 3950 5874 50  0000 C CNN
F 2 "project_custom:HT16K33_breakout" H 4000 4550 50  0001 C CNN
F 3 "" H 4000 4550 50  0001 C CNN
	1    3950 5100
	1    0    0    -1  
$EndComp
$Comp
L arduino_shieldsNCL:KW4-12041CUGA U3
U 1 1 5C24F654
P 7200 5100
F 0 "U3" H 7200 5715 50  0000 C CNN
F 1 "KW4-12041CUGA" H 7200 5624 50  0000 C CNN
F 2 "project_custom:KW4-12041CUGA" H 7350 5000 50  0001 C CNN
F 3 "" H 7350 5000 50  0001 C CNN
	1    7200 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3250 2050 3250 2200
Wire Wire Line
	4150 2200 4250 2200
Wire Wire Line
	4250 2200 4250 2250
Wire Wire Line
	4250 1800 4250 2200
Connection ~ 4250 2200
Text GLabel 7950 4850 2    50   Input ~ 0
SEG_F
Text GLabel 7950 4950 2    50   Input ~ 0
SEG_G
Text GLabel 7950 5050 2    50   Input ~ 0
SEG_A
Text GLabel 4650 5000 2    50   Input ~ 0
SEG_B_DP3-4
Text GLabel 4650 5100 2    50   Input ~ 0
SEG_C_DP1
Text GLabel 4650 5200 2    50   Input ~ 0
SEG_D_DP2
Text GLabel 4650 5300 2    50   Input ~ 0
SEG_E_DP5
Wire Wire Line
	7800 5450 7950 5450
Wire Wire Line
	7800 5350 7950 5350
Wire Wire Line
	7800 5250 7950 5250
Wire Wire Line
	7950 5150 7800 5150
Wire Wire Line
	7800 5050 7950 5050
Wire Wire Line
	7950 4950 7800 4950
Wire Wire Line
	7800 4850 7950 4850
Text GLabel 4650 4900 2    50   Input ~ 0
SEG_A
Text GLabel 4650 5400 2    50   Input ~ 0
SEG_F
Text GLabel 4650 5500 2    50   Input ~ 0
SEG_G
Text GLabel 7950 5150 2    50   Input ~ 0
SEG_B_DP3-4
Text GLabel 7950 5250 2    50   Input ~ 0
SEG_C_DP1
Text GLabel 7950 5350 2    50   Input ~ 0
SEG_D_DP2
Text GLabel 7950 5450 2    50   Input ~ 0
SEG_E_DP5
Text GLabel 7950 4750 2    50   Input ~ 0
SEG_E_DP5
Wire Wire Line
	7950 4750 7800 4750
Text GLabel 6500 5450 0    50   Input ~ 0
SEG_D_DP2
Text GLabel 6500 5350 0    50   Input ~ 0
SEG_C_DP1
Text GLabel 6500 5250 0    50   Input ~ 0
SEG_B_DP3-4
Text GLabel 6500 4750 0    50   Input ~ 0
COM1
Text GLabel 6500 4850 0    50   Input ~ 0
COM2
Text GLabel 6500 4950 0    50   Input ~ 0
COM3
Text GLabel 6500 5050 0    50   Input ~ 0
COM4
Text GLabel 6500 5150 0    50   Input ~ 0
COM5
Wire Wire Line
	6500 5050 6600 5050
Wire Wire Line
	6500 4950 6600 4950
Wire Wire Line
	6500 4850 6600 4850
Wire Wire Line
	6600 4750 6500 4750
Wire Wire Line
	6600 5150 6500 5150
Wire Wire Line
	6500 5250 6600 5250
Wire Wire Line
	6600 5350 6500 5350
Wire Wire Line
	6500 5450 6600 5450
Text GLabel 3250 5100 0    50   Input ~ 0
COM1
Text GLabel 3250 4700 0    50   Input ~ 0
COM2
Text GLabel 3250 4800 0    50   Input ~ 0
COM3
Text GLabel 3250 4900 0    50   Input ~ 0
COM4
Text GLabel 3250 5000 0    50   Input ~ 0
COM5
$Comp
L power:GND #PWR012
U 1 1 5C26A928
P 2850 4650
F 0 "#PWR012" H 2850 4400 50  0001 C CNN
F 1 "GND" H 2855 4477 50  0000 C CNN
F 2 "" H 2850 4650 50  0001 C CNN
F 3 "" H 2850 4650 50  0001 C CNN
	1    2850 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 4650 2850 4600
Wire Wire Line
	2850 4600 3350 4600
$Comp
L power:+5V #PWR011
U 1 1 5C26BFD2
P 4700 4550
F 0 "#PWR011" H 4700 4400 50  0001 C CNN
F 1 "+5V" H 4715 4723 50  0000 C CNN
F 2 "" H 4700 4550 50  0001 C CNN
F 3 "" H 4700 4550 50  0001 C CNN
	1    4700 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 4600 4700 4600
Wire Wire Line
	4700 4600 4700 4550
Text GLabel 4650 4700 2    50   Input ~ 0
SDA
Text GLabel 4650 4800 2    50   Input ~ 0
SCL
Wire Wire Line
	3250 4700 3350 4700
Wire Wire Line
	3250 4800 3350 4800
Wire Wire Line
	3350 4900 3250 4900
Wire Wire Line
	3250 5000 3350 5000
Wire Wire Line
	3350 5100 3250 5100
Wire Wire Line
	4650 4700 4550 4700
Wire Wire Line
	4650 4800 4550 4800
Wire Wire Line
	4550 4900 4650 4900
Wire Wire Line
	4650 5000 4550 5000
Wire Wire Line
	4550 5100 4650 5100
Wire Wire Line
	4650 5200 4550 5200
Wire Wire Line
	4550 5300 4650 5300
Wire Wire Line
	4650 5400 4550 5400
Wire Wire Line
	4550 5500 4650 5500
$Comp
L arduino_shieldsNCL:DS3231_breakout U4
U 1 1 5C246195
P 9600 5200
F 0 "U4" H 9806 5915 50  0000 C CNN
F 1 "DS3231_breakout" H 9806 5824 50  0000 C CNN
F 2 "project_custom:DS3231_breakout" H 9700 5850 50  0001 C CNN
F 3 "" H 9700 5850 50  0001 C CNN
	1    9600 5200
	1    0    0    -1  
$EndComp
Text GLabel 10350 5050 2    50   Input ~ 0
SCL
Text GLabel 10350 5150 2    50   Input ~ 0
SDA
Wire Wire Line
	10250 5050 10350 5050
Wire Wire Line
	10350 5150 10250 5150
$Comp
L power:+5V #PWR014
U 1 1 5C2552DD
P 10350 4800
F 0 "#PWR014" H 10350 4650 50  0001 C CNN
F 1 "+5V" H 10365 4973 50  0000 C CNN
F 2 "" H 10350 4800 50  0001 C CNN
F 3 "" H 10350 4800 50  0001 C CNN
	1    10350 4800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR015
U 1 1 5C255435
P 10700 5000
F 0 "#PWR015" H 10700 4750 50  0001 C CNN
F 1 "GND" H 10705 4827 50  0000 C CNN
F 2 "" H 10700 5000 50  0001 C CNN
F 3 "" H 10700 5000 50  0001 C CNN
	1    10700 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	10250 4850 10350 4850
Wire Wire Line
	10350 4850 10350 4800
Wire Wire Line
	10250 4950 10700 4950
Wire Wire Line
	10700 4950 10700 5000
$Comp
L power:GND #PWR09
U 1 1 5C270394
P 10100 3150
F 0 "#PWR09" H 10100 2900 50  0001 C CNN
F 1 "GND" H 10105 2977 50  0000 C CNN
F 2 "" H 10100 3150 50  0001 C CNN
F 3 "" H 10100 3150 50  0001 C CNN
	1    10100 3150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 5C2703C1
P 8900 3150
F 0 "#PWR08" H 8900 2900 50  0001 C CNN
F 1 "GND" H 8905 2977 50  0000 C CNN
F 2 "" H 8900 3150 50  0001 C CNN
F 3 "" H 8900 3150 50  0001 C CNN
	1    8900 3150
	1    0    0    -1  
$EndComp
Text Label 7400 7500 0    50   ~ 0
Noise Clock
Text Label 8150 7650 0    50   ~ 0
December 2018
Text Label 10600 7650 0    50   ~ 0
1.0
Text GLabel 9500 1250 0    50   Input ~ 0
SONG+
Text GLabel 9500 1800 0    50   Input ~ 0
BR+
Text GLabel 9500 2350 0    50   Input ~ 0
MIN+
Text GLabel 9500 2900 0    50   Input ~ 0
HR+
Text GLabel 8250 1250 0    50   Input ~ 0
SONG-
Text GLabel 8250 1800 0    50   Input ~ 0
BR-
Text GLabel 8250 2350 0    50   Input ~ 0
MIN-
Text GLabel 8250 2900 0    50   Input ~ 0
HR-
Text GLabel 2600 1650 2    50   Input ~ 0
SONG+
Text GLabel 2600 1450 2    50   Input ~ 0
SONG-
Text Label 3050 3700 0    50   ~ 0
D6
Text Label 3050 3800 0    50   ~ 0
D7
Text GLabel 2600 2250 2    50   Input ~ 0
BR+
Text GLabel 2600 1750 2    50   Input ~ 0
BR-
Text GLabel 2600 2350 2    50   Input ~ 0
MIN-
Text GLabel 2650 3750 2    50   Input ~ 0
HR-
Text Label 3050 1700 0    50   ~ 0
D11
Text Label 3050 1800 0    50   ~ 0
D12
Text Label 3050 1500 0    50   ~ 0
D9
Text Label 3050 1400 0    50   ~ 0
D8
Text Label 3050 1300 0    50   ~ 0
ArduinoUno
Text GLabel 2600 2650 2    50   Input ~ 0
SDA
Text GLabel 2600 2750 2    50   Input ~ 0
SCL
Text GLabel 2600 1350 2    50   Input ~ 0
MIN+
Connection ~ 3450 1800
Wire Wire Line
	3450 1800 3650 1800
Wire Wire Line
	3450 1800 3250 1800
Wire Wire Line
	3450 2200 3850 2200
Wire Wire Line
	3450 2200 3250 2200
Connection ~ 3450 2200
Wire Wire Line
	3450 2150 3450 2200
Wire Wire Line
	3250 1800 3250 1950
Text GLabel 2650 3650 2    50   Input ~ 0
HR+
Wire Wire Line
	2500 1950 3250 1950
Wire Wire Line
	2500 2050 3250 2050
Wire Wire Line
	2500 2250 2600 2250
Wire Wire Line
	2600 2350 2500 2350
Wire Wire Line
	2600 2650 2500 2650
Wire Wire Line
	2500 2750 2600 2750
Wire Wire Line
	2500 1750 2600 1750
Wire Wire Line
	2600 1650 2500 1650
Wire Wire Line
	2500 1450 2600 1450
Wire Wire Line
	2500 3650 2650 3650
Wire Wire Line
	2650 3750 2500 3750
Text Label 3050 2300 0    50   ~ 0
A0
Text Label 3050 2400 0    50   ~ 0
A1
Text Label 3050 2700 0    50   ~ 0
A4
Text Label 3050 2800 0    50   ~ 0
A5
Wire Wire Line
	2500 2850 2750 2850
Wire Wire Line
	3050 2850 3350 2850
Wire Wire Line
	2500 1350 2600 1350
$Comp
L power:+5V #PWR013
U 1 1 5C366A96
P 1750 4800
F 0 "#PWR013" H 1750 4650 50  0001 C CNN
F 1 "+5V" H 1765 4973 50  0000 C CNN
F 2 "" H 1750 4800 50  0001 C CNN
F 3 "" H 1750 4800 50  0001 C CNN
	1    1750 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 4850 1750 4800
$Comp
L dk_Tactile-Switches:1825910-6 S2
U 1 1 5C3933AD
P 9800 1350
F 0 "S2" H 9800 1697 60  0000 C CNN
F 1 "SONG+" H 9800 1591 60  0000 C CNN
F 2 "digikey-footprints:Switch_Tactile_THT_6x6mm" H 10000 1550 60  0001 L CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 10000 1650 60  0001 L CNN
F 4 "450-1650-ND" H 10000 1750 60  0001 L CNN "Digi-Key_PN"
F 5 "1825910-6" H 10000 1850 60  0001 L CNN "MPN"
F 6 "Switches" H 10000 1950 60  0001 L CNN "Category"
F 7 "Tactile Switches" H 10000 2050 60  0001 L CNN "Family"
F 8 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 10000 2150 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/te-connectivity-alcoswitch-switches/1825910-6/450-1650-ND/1632536" H 10000 2250 60  0001 L CNN "DK_Detail_Page"
F 10 "SWITCH TACTILE SPST-NO 0.05A 24V" H 10000 2350 60  0001 L CNN "Description"
F 11 "TE Connectivity ALCOSWITCH Switches" H 10000 2450 60  0001 L CNN "Manufacturer"
F 12 "Active" H 10000 2550 60  0001 L CNN "Status"
	1    9800 1350
	1    0    0    -1  
$EndComp
$Comp
L dk_Tactile-Switches:1825910-6 S4
U 1 1 5C3B0B08
P 9800 1900
F 0 "S4" H 9800 2247 60  0000 C CNN
F 1 "BR+" H 9800 2141 60  0000 C CNN
F 2 "digikey-footprints:Switch_Tactile_THT_6x6mm" H 10000 2100 60  0001 L CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 10000 2200 60  0001 L CNN
F 4 "450-1650-ND" H 10000 2300 60  0001 L CNN "Digi-Key_PN"
F 5 "1825910-6" H 10000 2400 60  0001 L CNN "MPN"
F 6 "Switches" H 10000 2500 60  0001 L CNN "Category"
F 7 "Tactile Switches" H 10000 2600 60  0001 L CNN "Family"
F 8 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 10000 2700 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/te-connectivity-alcoswitch-switches/1825910-6/450-1650-ND/1632536" H 10000 2800 60  0001 L CNN "DK_Detail_Page"
F 10 "SWITCH TACTILE SPST-NO 0.05A 24V" H 10000 2900 60  0001 L CNN "Description"
F 11 "TE Connectivity ALCOSWITCH Switches" H 10000 3000 60  0001 L CNN "Manufacturer"
F 12 "Active" H 10000 3100 60  0001 L CNN "Status"
	1    9800 1900
	1    0    0    -1  
$EndComp
$Comp
L dk_Tactile-Switches:1825910-6 S6
U 1 1 5C3B0B6C
P 9800 2450
F 0 "S6" H 9800 2797 60  0000 C CNN
F 1 "MIN+" H 9800 2691 60  0000 C CNN
F 2 "digikey-footprints:Switch_Tactile_THT_6x6mm" H 10000 2650 60  0001 L CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 10000 2750 60  0001 L CNN
F 4 "450-1650-ND" H 10000 2850 60  0001 L CNN "Digi-Key_PN"
F 5 "1825910-6" H 10000 2950 60  0001 L CNN "MPN"
F 6 "Switches" H 10000 3050 60  0001 L CNN "Category"
F 7 "Tactile Switches" H 10000 3150 60  0001 L CNN "Family"
F 8 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 10000 3250 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/te-connectivity-alcoswitch-switches/1825910-6/450-1650-ND/1632536" H 10000 3350 60  0001 L CNN "DK_Detail_Page"
F 10 "SWITCH TACTILE SPST-NO 0.05A 24V" H 10000 3450 60  0001 L CNN "Description"
F 11 "TE Connectivity ALCOSWITCH Switches" H 10000 3550 60  0001 L CNN "Manufacturer"
F 12 "Active" H 10000 3650 60  0001 L CNN "Status"
	1    9800 2450
	1    0    0    -1  
$EndComp
$Comp
L dk_Tactile-Switches:1825910-6 S8
U 1 1 5C3B0BCA
P 9800 3000
F 0 "S8" H 9800 3347 60  0000 C CNN
F 1 "HR+" H 9800 3241 60  0000 C CNN
F 2 "digikey-footprints:Switch_Tactile_THT_6x6mm" H 10000 3200 60  0001 L CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 10000 3300 60  0001 L CNN
F 4 "450-1650-ND" H 10000 3400 60  0001 L CNN "Digi-Key_PN"
F 5 "1825910-6" H 10000 3500 60  0001 L CNN "MPN"
F 6 "Switches" H 10000 3600 60  0001 L CNN "Category"
F 7 "Tactile Switches" H 10000 3700 60  0001 L CNN "Family"
F 8 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 10000 3800 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/te-connectivity-alcoswitch-switches/1825910-6/450-1650-ND/1632536" H 10000 3900 60  0001 L CNN "DK_Detail_Page"
F 10 "SWITCH TACTILE SPST-NO 0.05A 24V" H 10000 4000 60  0001 L CNN "Description"
F 11 "TE Connectivity ALCOSWITCH Switches" H 10000 4100 60  0001 L CNN "Manufacturer"
F 12 "Active" H 10000 4200 60  0001 L CNN "Status"
	1    9800 3000
	1    0    0    -1  
$EndComp
$Comp
L dk_Tactile-Switches:1825910-6 S7
U 1 1 5C3B0E50
P 8550 3000
F 0 "S7" H 8550 3347 60  0000 C CNN
F 1 "HR-" H 8550 3241 60  0000 C CNN
F 2 "digikey-footprints:Switch_Tactile_THT_6x6mm" H 8750 3200 60  0001 L CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 8750 3300 60  0001 L CNN
F 4 "450-1650-ND" H 8750 3400 60  0001 L CNN "Digi-Key_PN"
F 5 "1825910-6" H 8750 3500 60  0001 L CNN "MPN"
F 6 "Switches" H 8750 3600 60  0001 L CNN "Category"
F 7 "Tactile Switches" H 8750 3700 60  0001 L CNN "Family"
F 8 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 8750 3800 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/te-connectivity-alcoswitch-switches/1825910-6/450-1650-ND/1632536" H 8750 3900 60  0001 L CNN "DK_Detail_Page"
F 10 "SWITCH TACTILE SPST-NO 0.05A 24V" H 8750 4000 60  0001 L CNN "Description"
F 11 "TE Connectivity ALCOSWITCH Switches" H 8750 4100 60  0001 L CNN "Manufacturer"
F 12 "Active" H 8750 4200 60  0001 L CNN "Status"
	1    8550 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	10100 1250 10000 1250
Wire Wire Line
	10000 1450 10100 1450
Connection ~ 10100 1450
Wire Wire Line
	10100 1450 10100 1250
Wire Wire Line
	10000 1800 10100 1800
Connection ~ 10100 1800
Wire Wire Line
	10100 1800 10100 1450
Wire Wire Line
	10000 2000 10100 2000
Wire Wire Line
	10100 1800 10100 2000
Connection ~ 10100 2000
Wire Wire Line
	10100 2000 10100 2350
Wire Wire Line
	10000 2350 10100 2350
Connection ~ 10100 2350
Wire Wire Line
	10100 2350 10100 2550
Wire Wire Line
	10000 2550 10100 2550
Connection ~ 10100 2550
Wire Wire Line
	10100 2550 10100 2900
Wire Wire Line
	10000 2900 10100 2900
Connection ~ 10100 2900
Wire Wire Line
	10100 2900 10100 3100
Wire Wire Line
	10000 3100 10100 3100
Connection ~ 10100 3100
Wire Wire Line
	10100 3100 10100 3150
Wire Wire Line
	9600 3100 9600 2900
Wire Wire Line
	9500 2900 9600 2900
Connection ~ 9600 2900
Wire Wire Line
	9600 2550 9600 2350
Wire Wire Line
	9600 2350 9500 2350
Connection ~ 9600 2350
Wire Wire Line
	9600 2000 9600 1800
Wire Wire Line
	9500 1800 9600 1800
Connection ~ 9600 1800
Wire Wire Line
	9600 1450 9600 1250
Wire Wire Line
	9500 1250 9600 1250
Connection ~ 9600 1250
$Comp
L dk_Tactile-Switches:1825910-6 S5
U 1 1 5C431514
P 8550 2450
F 0 "S5" H 8550 2797 60  0000 C CNN
F 1 "MIN-" H 8550 2691 60  0000 C CNN
F 2 "digikey-footprints:Switch_Tactile_THT_6x6mm" H 8750 2650 60  0001 L CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 8750 2750 60  0001 L CNN
F 4 "450-1650-ND" H 8750 2850 60  0001 L CNN "Digi-Key_PN"
F 5 "1825910-6" H 8750 2950 60  0001 L CNN "MPN"
F 6 "Switches" H 8750 3050 60  0001 L CNN "Category"
F 7 "Tactile Switches" H 8750 3150 60  0001 L CNN "Family"
F 8 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 8750 3250 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/te-connectivity-alcoswitch-switches/1825910-6/450-1650-ND/1632536" H 8750 3350 60  0001 L CNN "DK_Detail_Page"
F 10 "SWITCH TACTILE SPST-NO 0.05A 24V" H 8750 3450 60  0001 L CNN "Description"
F 11 "TE Connectivity ALCOSWITCH Switches" H 8750 3550 60  0001 L CNN "Manufacturer"
F 12 "Active" H 8750 3650 60  0001 L CNN "Status"
	1    8550 2450
	1    0    0    -1  
$EndComp
$Comp
L dk_Tactile-Switches:1825910-6 S3
U 1 1 5C431570
P 8550 1900
F 0 "S3" H 8550 2247 60  0000 C CNN
F 1 "BR-" H 8550 2141 60  0000 C CNN
F 2 "digikey-footprints:Switch_Tactile_THT_6x6mm" H 8750 2100 60  0001 L CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 8750 2200 60  0001 L CNN
F 4 "450-1650-ND" H 8750 2300 60  0001 L CNN "Digi-Key_PN"
F 5 "1825910-6" H 8750 2400 60  0001 L CNN "MPN"
F 6 "Switches" H 8750 2500 60  0001 L CNN "Category"
F 7 "Tactile Switches" H 8750 2600 60  0001 L CNN "Family"
F 8 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 8750 2700 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/te-connectivity-alcoswitch-switches/1825910-6/450-1650-ND/1632536" H 8750 2800 60  0001 L CNN "DK_Detail_Page"
F 10 "SWITCH TACTILE SPST-NO 0.05A 24V" H 8750 2900 60  0001 L CNN "Description"
F 11 "TE Connectivity ALCOSWITCH Switches" H 8750 3000 60  0001 L CNN "Manufacturer"
F 12 "Active" H 8750 3100 60  0001 L CNN "Status"
	1    8550 1900
	1    0    0    -1  
$EndComp
$Comp
L dk_Tactile-Switches:1825910-6 S1
U 1 1 5C4315D2
P 8550 1350
F 0 "S1" H 8550 1697 60  0000 C CNN
F 1 "SONG-" H 8550 1591 60  0000 C CNN
F 2 "digikey-footprints:Switch_Tactile_THT_6x6mm" H 8750 1550 60  0001 L CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 8750 1650 60  0001 L CNN
F 4 "450-1650-ND" H 8750 1750 60  0001 L CNN "Digi-Key_PN"
F 5 "1825910-6" H 8750 1850 60  0001 L CNN "MPN"
F 6 "Switches" H 8750 1950 60  0001 L CNN "Category"
F 7 "Tactile Switches" H 8750 2050 60  0001 L CNN "Family"
F 8 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=1825910&DocType=Customer+Drawing&DocLang=English" H 8750 2150 60  0001 L CNN "DK_Datasheet_Link"
F 9 "/product-detail/en/te-connectivity-alcoswitch-switches/1825910-6/450-1650-ND/1632536" H 8750 2250 60  0001 L CNN "DK_Detail_Page"
F 10 "SWITCH TACTILE SPST-NO 0.05A 24V" H 8750 2350 60  0001 L CNN "Description"
F 11 "TE Connectivity ALCOSWITCH Switches" H 8750 2450 60  0001 L CNN "Manufacturer"
F 12 "Active" H 8750 2550 60  0001 L CNN "Status"
	1    8550 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 1250 8350 1250
Wire Wire Line
	8350 1250 8350 1450
Connection ~ 8350 1250
Wire Wire Line
	8250 1800 8350 1800
Wire Wire Line
	8350 2000 8350 1800
Connection ~ 8350 1800
Wire Wire Line
	8350 2550 8350 2350
Wire Wire Line
	8350 2350 8250 2350
Connection ~ 8350 2350
Wire Wire Line
	8250 2900 8350 2900
Wire Wire Line
	8350 2900 8350 3100
Connection ~ 8350 2900
Wire Wire Line
	8900 3150 8900 3100
Wire Wire Line
	8900 1250 8750 1250
Wire Wire Line
	8750 1450 8900 1450
Connection ~ 8900 1450
Wire Wire Line
	8900 1450 8900 1250
Wire Wire Line
	8750 1800 8900 1800
Connection ~ 8900 1800
Wire Wire Line
	8900 1800 8900 1450
Wire Wire Line
	8750 2000 8900 2000
Connection ~ 8900 2000
Wire Wire Line
	8900 2000 8900 1800
Wire Wire Line
	8750 2350 8900 2350
Wire Wire Line
	8900 2350 8900 2000
Connection ~ 8900 2350
Wire Wire Line
	8750 2550 8900 2550
Wire Wire Line
	8900 2550 8900 2350
Connection ~ 8900 2550
Wire Wire Line
	8750 2900 8900 2900
Wire Wire Line
	8900 2900 8900 2550
Connection ~ 8900 2900
Wire Wire Line
	8750 3100 8900 3100
Wire Wire Line
	8900 3100 8900 2900
Connection ~ 8900 3100
NoConn ~ 2500 1850
NoConn ~ 2500 2450
NoConn ~ 2500 2550
NoConn ~ 2500 3050
NoConn ~ 2500 3150
NoConn ~ 5150 1900
NoConn ~ 5150 2000
NoConn ~ 5150 2400
NoConn ~ 5150 2600
NoConn ~ 5150 2700
NoConn ~ 5150 2800
NoConn ~ 5150 2900
NoConn ~ 5150 3000
NoConn ~ 5150 3100
NoConn ~ 3350 5200
NoConn ~ 3350 5300
NoConn ~ 3350 5400
NoConn ~ 3350 5500
NoConn ~ 3350 5600
NoConn ~ 3350 5700
NoConn ~ 3350 5800
NoConn ~ 3350 5900
NoConn ~ 4550 5600
NoConn ~ 4550 5700
NoConn ~ 4550 5800
NoConn ~ 4550 5900
NoConn ~ 10250 5250
NoConn ~ 10250 5350
NoConn ~ 10250 5450
NoConn ~ 10250 5550
NoConn ~ 7050 1500
NoConn ~ 7050 1700
NoConn ~ 7050 1800
NoConn ~ 7050 1900
NoConn ~ 7050 2100
NoConn ~ 7050 2200
NoConn ~ 7050 2400
NoConn ~ 7050 2500
NoConn ~ 7050 3000
NoConn ~ 7050 3100
$Comp
L power:GND #PWR016
U 1 1 5C36BA8B
P 1350 5550
F 0 "#PWR016" H 1350 5300 50  0001 C CNN
F 1 "GND" H 1355 5377 50  0000 C CNN
F 2 "" H 1350 5550 50  0001 C CNN
F 3 "" H 1350 5550 50  0001 C CNN
	1    1350 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	1650 4850 1750 4850
Wire Wire Line
	1350 5550 1350 5500
Wire Wire Line
	1350 5500 1250 5500
Wire Wire Line
	1250 5500 1250 5450
Connection ~ 1350 5500
Wire Wire Line
	1350 5500 1350 5450
NoConn ~ 1650 5050
NoConn ~ 1650 5150
$Comp
L Connector:USB_B J1
U 1 1 5C6A3011
P 1350 5050
F 0 "J1" H 1405 5517 50  0000 C CNN
F 1 "USB_B" H 1405 5426 50  0000 C CNN
F 2 "Connector_USB:USB_B_OST_USB-B1HSxx_Horizontal" H 1500 5000 50  0001 C CNN
F 3 " ~" H 1500 5000 50  0001 C CNN
	1    1350 5050
	1    0    0    -1  
$EndComp
$Comp
L arduino_shieldsNCL:ARDUINO_SHIELD SHIELD1
U 1 1 5C2C5383
P 6100 2300
F 0 "SHIELD1" H 6100 3587 60  0000 C CNN
F 1 "ARDUINO_SHIELD" H 6100 3481 60  0000 C CNN
F 2 "project_custom:Arduino_Uno_Shield" H 6100 2300 50  0001 C CNN
F 3 "" H 6100 2300 50  0001 C CNN
	1    6100 2300
	1    0    0    -1  
$EndComp
NoConn ~ 5150 1800
NoConn ~ 7050 1300
NoConn ~ 7050 1400
$EndSCHEMATC
