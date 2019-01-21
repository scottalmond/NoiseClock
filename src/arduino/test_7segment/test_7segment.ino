//----- Clock Display -----
#include <Wire.h>
#include <Adafruit_GFX.h>
#include "Adafruit_LEDBackpack.h"
Adafruit_AlphaNum4 alpha4 = Adafruit_AlphaNum4();

void setup() {
  //----- Debug -----
  Serial.begin(115200);
  
  //----- Clock Display -----
  alpha4.begin(0x70);  // pass in the address
  alpha4.clear();
  alpha4.writeDisplay();
}

void loop() {
  // put your main code here, to run repeatedly:
  int rtc_hour=11;//load from RTC on boot
  int rtc_minute=34;//load from RTC on boot
  char hour_ten=(rtc_hour%12+1)/10;
  char hour_one=(rtc_hour%12+1)%10;
  char minute_ten=rtc_minute/10;
  char minute_one=rtc_minute%10;
  if(hour_ten==0) alpha4.writeDigitAscii(0, ' ');//if 1 AM, display as " 1", not "01"
  else alpha4.writeDigitAscii(0,hour_ten+'0');
  alpha4.writeDigitAscii(1,hour_one+'0');
  alpha4.writeDigitAscii(2,minute_ten+'0');
  alpha4.writeDigitAscii(3,minute_one+'0');
  alpha4.writeDigitAscii(4,1);//turn on colon in center of screen
  alpha4.writeDisplay();
}
